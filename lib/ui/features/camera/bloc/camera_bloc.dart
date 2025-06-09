import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/utils/image_processor.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  // 1. Tạo một Logger instance cho class này
  // Đặt tên logger theo tên class giúp dễ dàng lọc log sau này
  final _log = Logger('CameraBloc');

  CameraController? _controller;

  CameraBloc() : super(CameraInitial()) {
    on<CameraInitialized>(_onCameraInitialized);
    on<CameraStopped>(_onCameraStopped);
    on<CameraCaptureRequested>(_onCameraCaptureRequested);
  }

  Future<void> _onCameraInitialized(event, emit) async {
    // Log khi bắt đầu xử lý event
    _log.info('Event CameraInitialized: Bắt đầu quá trình khởi tạo camera...');

    // Emit trạng thái loading ngay lập tức để UI cập nhật
    emit(CameraInitializationInProgress());

    try {
      // BƯỚC 1: LẤY DANH SÁCH CAMERA
      _log.fine('Đang gọi availableCameras()...');
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        _log.severe('Không tìm thấy camera nào trên thiết bị.');
        // Ném một lỗi cụ thể để khối catch có thể xử lý
        throw CameraException('E01', 'No cameras found on the device.');
      }
      _log.info('Tìm thấy ${cameras.length} camera. Sử dụng camera đầu tiên.');

      // BƯỚC 2: KHỞI TẠO CAMERA CONTROLLER
      _log.fine('Đang khởi tạo CameraController...');
      // Chọn camera đầu tiên (thường là camera sau)
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high, // Dùng high thay vì veryHigh để tương thích tốt hơn
        enableAudio: false,
      );

      // BƯỚC 3: INITIALIZE CONTROLLER
      _log.fine('Đang gọi _controller.initialize()...');
      await _controller!.initialize();
      _log.info('CameraController đã khởi tạo thành công!');

      // BƯỚC 4: EMIT TRẠNG THÁI READY
      // Chỉ emit khi tất cả các bước trên thành công
      emit(CameraReady(cameraController: _controller!));
    } on CameraException catch (e, stackTrace) {
      // Bắt lỗi cụ thể từ package camera
      _log.severe(
        'Lỗi CameraException trong quá trình khởi tạo: ${e.code} - ${e.description}',
        e,
        stackTrace,
      );
      emit(CameraFailure(failureMessage: 'Lỗi camera: ${e.description} (Code: ${e.code})'));
    } catch (e, stackTrace) {
      // Bắt tất cả các lỗi khác không lường trước được
      _log.severe(
        'Lỗi không xác định trong CameraInitialized: $e',
        e,
        stackTrace, // Ghi lại cả stack trace để debug
      );
      emit(CameraFailure(failureMessage: 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.'));
    }
  }

  Future<void> _onCameraStopped(event, emit) async {
    _log.info('Event CameraStopped: Đang dừng và giải phóng CameraController...');

    // 2. Kiểm tra xem controller có thực sự tồn tại và đã được khởi tạo chưa.
    // Nếu không kiểm tra, việc gọi dispose() trên một controller null sẽ gây lỗi.
    if (_controller == null || !_controller!.value.isInitialized) {
      _log.warning('Cố gắng dừng một controller chưa được khởi tạo hoặc đã null.');
      // Không cần làm gì thêm nếu controller không tồn tại.
      return;
    }

    try {
      // 3. Thực hiện việc giải phóng tài nguyên. Đây là một tác vụ bất đồng bộ.
      await _controller!.dispose();
      _log.info('CameraController đã được dispose thành công.');

      // 4. Set controller về null để tránh các truy cập sau này.
      _controller = null;

      // 5. (Tùy chọn) Emit một trạng thái để reset UI về ban đầu.
      // Điều này hữu ích nếu người dùng có thể quay lại màn hình camera
      // mà không tạo lại BLoC.
      emit(CameraInitial());
    } catch (e, stackTrace) {
      _log.severe('Lỗi khi dispose CameraController: $e', e, stackTrace);
      // Ngay cả khi có lỗi, chúng ta vẫn nên emit một trạng thái ổn định.
      // Có thể emit CameraFailure hoặc CameraInitial tùy vào logic bạn muốn.
      emit(CameraFailure(failureMessage: 'Không thể dừng camera một cách chính xác. Lỗi: $e'));
    }
  }

  Future<void> _onCameraCaptureRequested(event, emit) async {
    _log.info('Event CameraCaptureRequested: Bắt đầu quá trình chụp ảnh...');

    // 1. Kiểm tra điều kiện tiên quyết
    // Đảm bảo camera đã sẵn sàng và controller không null.
    // Dùng `state is! CameraReady` để chắc chắn.
    if (state is! CameraReady || _controller == null || !_controller!.value.isInitialized) {
      _log.warning('Cố gắng chụp ảnh khi camera chưa sẵn sàng.');
      // Không emit gì cả, vì không nên có hành động nào xảy ra.
      return;
    }

    try {
      // 2. Emit trạng thái "đang xử lý"
      // UI sẽ dựa vào đây để hiển thị loading indicator và vô hiệu hóa nút chụp
      emit(CameraCaptureInProgress());

      // 3. Chụp ảnh
      _log.fine('Đang gọi _controller.takePicture()...');
      final XFile imageFile = await _controller!.takePicture();
      _log.info('Ảnh đã được chụp và lưu tại: ${imageFile.path}');

      // 4. Xử lý ảnh (ví dụ: crop)
      // Tốt nhất là đưa logic này vào một service riêng, ví dụ ImageProcessingService.
      _log.fine('Đang xử lý crop ảnh...');
      // Giả sử ImageProcessor là một class bạn đã có
      await getIt<ImageProcessor>().cropSquare(imageFile.path, imageFile.path, false);
      _log.info('Crop ảnh thành công.');

      // 5. Emit trạng thái thành công với đường dẫn ảnh
      // UI sẽ lắng nghe state này và thực hiện điều hướng
      emit(CameraCaptureSuccess(imagePath: imageFile.path));

      emit(CameraReady(cameraController: _controller!));
    } on CameraException catch (e, stackTrace) {
      _log.severe('Lỗi CameraException khi chụp ảnh: ${e.code} - ${e.description}', e, stackTrace);
      emit(CameraCaptureFailure(failureMessage: 'Không thể chụp ảnh. Lỗi: ${e.description}'));
      // Sau khi báo lỗi, có thể quay lại trạng thái Ready để người dùng thử lại
      emit(CameraReady(cameraController: _controller!));
    } catch (e, stackTrace) {
      _log.severe('Lỗi không xác định khi chụp ảnh: $e', e, stackTrace);
      emit(CameraCaptureFailure(failureMessage: 'Đã xảy ra lỗi không mong muốn khi xử lý ảnh.'));
      emit(CameraReady(cameraController: _controller!));
    }
  }

  @override
  Future<void> close() {
    _log.info('Closing CameraBloc, disposing controller...');
    _controller?.dispose();

    return super.close();
  }
}

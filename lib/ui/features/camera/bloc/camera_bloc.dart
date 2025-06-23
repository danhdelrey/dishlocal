import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/image_processor.dart';
import 'package:dishlocal/data/categories/moderation/repository/interface/moderation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'camera_event.dart';
part 'camera_state.dart';

@injectable
class CameraBloc extends Bloc<CameraEvent, CameraState> {
  // 1. Tạo một Logger instance cho class này
  // Đặt tên logger theo tên class giúp dễ dàng lọc log sau này
  final _log = Logger('CameraBloc');

  CameraController? _controller;

  final ImageProcessor imageProcessor;
  final ModerationRepository _moderationRepository;

  CameraBloc(this._moderationRepository, this.imageProcessor) : super(const CameraInitial()) {
    on<CameraInitialized>(_onCameraInitialized);
    on<CameraStopped>(_onCameraStopped);
    on<CameraCaptureRequested>(_onCameraCaptureRequested);
  }

  Future<void> _onCameraInitialized(event, emit) async {
    // Log khi bắt đầu xử lý event
    _log.info('Event CameraInitialized: Bắt đầu quá trình khởi tạo camera...');

    // Emit trạng thái loading ngay lập tức để UI cập nhật
    emit(const CameraInitializationInProgress());

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
      emit(const CameraFailure(failureMessage: 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.'));
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
      emit(const CameraInitial());
    } catch (e, stackTrace) {
      _log.severe('Lỗi khi dispose CameraController: $e', e, stackTrace);
      // Ngay cả khi có lỗi, chúng ta vẫn nên emit một trạng thái ổn định.
      // Có thể emit CameraFailure hoặc CameraInitial tùy vào logic bạn muốn.
      emit(CameraFailure(failureMessage: 'Không thể dừng camera một cách chính xác. Lỗi: $e'));
    }
  }

  Future<void> _onCameraCaptureRequested(
    CameraCaptureRequested event,
    Emitter<CameraState> emit,
  ) async {
    _log.info('▶️ Event CameraCaptureRequested: Bắt đầu quá trình chụp ảnh và kiểm duyệt...');

    if (state is! CameraReady || _controller == null || !_controller!.value.isInitialized) {
      _log.warning('Cố gắng chụp ảnh khi camera chưa sẵn sàng.');
      return;
    }

    // Lấy ra controller hiện tại để tránh lỗi race condition
    final currentController = _controller!;

    try {
      // === GIAI ĐOẠN 1: CHỤP VÀ XỬ LÝ ẢNH ===
      _log.info('⏳ Phát ra trạng thái: [CaptureInProgress]');
      emit(const CameraCaptureInProgress());

      _log.fine('📸 Đang gọi controller.takePicture()...');
      final xFile = await currentController.takePicture();
      final imageFile = File(xFile.path); // Chuyển đổi XFile sang File
      _log.info('✅ Ảnh đã được chụp: ${imageFile.path}');

      _log.fine('🖼️ Đang xử lý crop ảnh và tạo blurhash...');
      await imageProcessor.cropSquare(imageFile.path, imageFile.path, false);
      final hash = imageProcessor.encodeImageToBlurhashString(imageFile.path);
      _log.info('✅ Xử lý ảnh và tạo blurhash thành công: "$hash"');

      // === GIAI ĐOẠN 2: KIỂM DUYỆT HÌNH ẢNH ===
      _log.info('⏳ Phát ra trạng thái: [ModerationInProgress]');
      emit(const CameraModerationInProgress());

      _log.info('🛡️ Đang gọi _moderationRepository.moderateImage()...');
      final moderationResult = await _moderationRepository.moderateImage(imageFile);

      // Xử lý kết quả kiểm duyệt
      await moderationResult.fold(
        // Trường hợp thất bại (Left): Ảnh không an toàn hoặc có lỗi
        (failure) async {
          _log.warning('❌ Kiểm duyệt thất bại. Failure: ${failure.message}');
          
          imageProcessor.deleteTempImageFile(imageFile.path);
          _log.info('Đã xóa file ảnh vừa chụp ở đường dẫn: ${imageFile.path}');

          // Phát ra trạng thái ModerationFailure để UI hiển thị thông báo
          emit(CameraModerationFailure(failureMessage: failure.message));

          // [QUAN TRỌNG] Sau khi báo lỗi, quay lại trạng thái Ready để người dùng thử lại
          _log.info('🔄 Quay lại trạng thái [Ready] sau khi kiểm duyệt thất bại.');
          emit(CameraReady(cameraController: currentController));
        },

        // Trường hợp thành công (Right): Ảnh an toàn
        (_) async {
          _log.info('👍 Kiểm duyệt thành công. Ảnh an toàn.');

          // === GIAI ĐOẠN 3: HOÀN TẤT ===
          _log.info('🎉 Phát ra trạng thái: [CaptureSuccess] với đường dẫn ảnh.');
          emit(CameraCaptureSuccess(
            imagePath: imageFile.path,
            blurHash: hash,
          ));

          // Sau khi thành công, có thể quay lại trạng thái Ready
          // để nếu người dùng quay lại màn hình này, họ có thể chụp tiếp.
          emit(CameraReady(cameraController: currentController));
        },
      );
    } on CameraException catch (e, stackTrace) {
      _log.severe('❌ Lỗi CameraException khi chụp ảnh: ${e.code} - ${e.description}', e, stackTrace);
      emit(CameraFailure(failureMessage: 'Không thể chụp ảnh. Lỗi: ${e.description}'));
      // Sau khi báo lỗi, quay lại trạng thái Ready để người dùng thử lại
      emit(CameraReady(cameraController: currentController));
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi không xác định khi chụp và xử lý ảnh: $e', e, stackTrace);
      emit(const CameraFailure(failureMessage: 'Đã xảy ra lỗi không mong muốn.'));
      emit(CameraReady(cameraController: currentController));
    }
  }

  @override
  Future<void> close() {
    _log.info('Closing CameraBloc, disposing controller...');
    _controller?.dispose();

    return super.close();
  }
}

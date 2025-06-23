part of 'camera_bloc.dart';

sealed class CameraState extends Equatable {
  const CameraState(); // Thêm const constructor vào lớp cơ sở

  @override
  List<Object?> get props => [];
}

// ===================================
// TRẠNG THÁI KHỞI TẠO CAMERA
// ===================================

/// Trạng thái ban đầu, trước khi có bất kỳ hành động nào.
final class CameraInitial extends CameraState {
  const CameraInitial();
}

/// Trạng thái khi camera đang được khởi tạo.
final class CameraInitializationInProgress extends CameraState {
  const CameraInitializationInProgress();
}

/// Trạng thái khi camera đã sẵn sàng để sử dụng.
final class CameraReady extends CameraState {
  final CameraController cameraController;

  const CameraReady({required this.cameraController});

  @override
  List<Object?> get props => [cameraController];
}

/// Trạng thái khi có lỗi trong quá trình khởi tạo camera.
final class CameraFailure extends CameraState {
  final String failureMessage;

  const CameraFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

// ===================================
// TRẠNG THÁI CHỤP VÀ KIỂM DUYỆT ẢNH
// ===================================

/// Trạng thái khi đang chụp và xử lý ảnh (crop, blurhash).
final class CameraCaptureInProgress extends CameraState {
  const CameraCaptureInProgress();
}

/// [MỚI] Trạng thái khi ảnh đã chụp xong và đang được gửi đi kiểm duyệt.
/// UI có thể hiển thị một thông điệp cụ thể hơn như "Đang kiểm tra hình ảnh...".
final class CameraModerationInProgress extends CameraState {
  const CameraModerationInProgress();
}

/// [MỚI] Trạng thái khi ảnh bị từ chối bởi dịch vụ kiểm duyệt.
final class CameraModerationFailure extends CameraState {
  final String failureMessage;

  const CameraModerationFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

/// Trạng thái khi chụp, xử lý và kiểm duyệt thành công.
/// Đây là trạng thái cuối cùng, báo hiệu cho UI thực hiện điều hướng.
final class CameraCaptureSuccess extends CameraState {
  final String imagePath;
  final String blurHash;

  const CameraCaptureSuccess({
    required this.imagePath,
    required this.blurHash,
  });

  @override
  List<Object?> get props => [imagePath, blurHash]; // Thêm blurHash vào props
}

/// Trạng thái khi có lỗi trong quá trình chụp hoặc xử lý ảnh (không phải lỗi kiểm duyệt).
final class CameraCaptureFailure extends CameraState {
  final String failureMessage;

  const CameraCaptureFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

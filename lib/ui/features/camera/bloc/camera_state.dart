part of 'camera_bloc.dart';


sealed class CameraState extends Equatable {
  @override
  List<Object?> get props => [];
}

//khởi tạo
final class CameraInitial extends CameraState {}

final class CameraInitializationInProgress extends CameraState {}

final class CameraReady extends CameraState {
  final double previewSizeWidth;
  final double previewSizeHeight;

  CameraReady({required this.previewSizeWidth, required this.previewSizeHeight});

  

  @override
  List<Object?> get props => [previewSizeWidth, previewSizeHeight];
}

final class CameraFailure extends CameraState {
  final String failureMessage;

  CameraFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

//tính năng chụp ảnh

final class CameraCaptureInProgress extends CameraState {}

final class CameraCaptureSuccess extends CameraState {
  final String imagePath;

  CameraCaptureSuccess({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

final class CameraCaptureFailure extends CameraState {
  final String failureMessage;

  CameraCaptureFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

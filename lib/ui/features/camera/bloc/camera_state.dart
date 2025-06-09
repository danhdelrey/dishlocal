part of 'camera_bloc.dart';

@immutable
sealed class CameraState extends Equatable {
  @override
  List<Object?> get props => [];
}

//khởi tạo
final class CameraInitial extends CameraState {}

final class CameraLoading extends CameraState {}

final class CameraReady extends CameraState {}

final class CameraFailure extends CameraState {}

//tính năng chụp ảnh

final class CameraCaptureInProgress extends CameraState {}

final class CameraCaptureSuccess extends CameraState {
  final XFile imageFile;

  CameraCaptureSuccess({required this.imageFile});
}

final class CameraCaptureFailure extends CameraState {}

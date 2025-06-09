part of 'camera_bloc.dart';

@immutable
sealed class CameraEvent extends Equatable {
  
  @override
  List<Object?> get props => [];
}

//camera
class CameraInitialized extends CameraEvent {}
class CameraStopped extends CameraEvent {}

//tương tác của người dùng
class CameraCaptureRequested extends CameraEvent {}


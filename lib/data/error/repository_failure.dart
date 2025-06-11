import 'package:equatable/equatable.dart';

abstract class RepositoryFailure extends Equatable {
  final String message;
  const RepositoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

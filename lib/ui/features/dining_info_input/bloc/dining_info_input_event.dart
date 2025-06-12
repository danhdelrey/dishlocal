part of 'dining_info_input_bloc.dart';

sealed class DiningInfoInputEvent extends Equatable {
  const DiningInfoInputEvent();

  @override
  List<Object> get props => [];
}

final class DiningInfoInputSubmitted extends DiningInfoInputEvent{}

final class DishNameInputChanged extends DiningInfoInputEvent {
  final String dishName;

  const DishNameInputChanged({required this.dishName});

  @override
  List<Object> get props => [dishName];
}

//cac lop khac cho hour, location,...
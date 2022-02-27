part of 'bloc.dart';

abstract class CounterState {}

class CounterStateCompleted extends CounterState {
  final CounterPageModel data;
  CounterStateCompleted({required this.data});
}

class CounterStateLoading extends CounterState {}

class CounterStateError extends CounterState {
  String error;
  CounterStateError(this.error);
}

class CounterStateInitial extends CounterState {}

import 'package:equatable/equatable.dart';

abstract class DatePickerState extends Equatable {
  const DatePickerState();

  @override
  List<Object?> get props => [];
}

class DatePickerInitial extends DatePickerState {}

class DateSelectedState extends DatePickerState {
  final DateTime selectedDate;

  const DateSelectedState(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

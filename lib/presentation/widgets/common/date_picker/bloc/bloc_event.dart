import 'package:equatable/equatable.dart';

abstract class DatePickerEvent extends Equatable {
  const DatePickerEvent();

  @override
  List<Object?> get props => [];
}

class SelectDateEvent extends DatePickerEvent {
  final DateTime? selectedDate;

  const SelectDateEvent(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}
class ClearDateEvent extends DatePickerEvent {}
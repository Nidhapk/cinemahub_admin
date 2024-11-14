import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerInitial()) {
    on<SelectDateEvent>(selectDate);
    on<ClearDateEvent>(clearDate);
  }
  void selectDate(SelectDateEvent event, Emitter<DatePickerState> emit) {
    emit(DateSelectedState(event.selectedDate!));
  }
   void clearDate(ClearDateEvent event, Emitter<DatePickerState> emit) {
    emit(DatePickerInitial()); 
  }
}

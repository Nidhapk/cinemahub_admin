import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/modals/theatre_model.dart';

abstract class TheatresStates extends Equatable {
  const TheatresStates();
  @override
  List<Object> get props => [];
}

class TheatresLoadingState extends TheatresStates {
  const TheatresLoadingState();
  @override
  List<Object> get props => [];
}

class TheatresLoadedState extends TheatresStates {
  final List<TheatreModel> theatre;
  const TheatresLoadedState(this.theatre);
  @override
  List<Object> get props => [theatre];
}

class TheatresLoadedErrorState extends TheatresStates {
  final String error;
  const TheatresLoadedErrorState(this.error);
  @override
  List<Object> get props => [error];
}



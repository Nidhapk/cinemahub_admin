import 'package:equatable/equatable.dart';

abstract class TheatreEvents extends Equatable {
  const TheatreEvents();
  @override
  List<Object> get props => [];
}

class LoadTheatresEvent extends TheatreEvents {
  const LoadTheatresEvent();
   @override
  List<Object> get props => [];
}

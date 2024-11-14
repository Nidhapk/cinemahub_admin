import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/theatre_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/bloc/bloc_state.dart';

class TheatresBloc extends Bloc<TheatreEvents, TheatresStates> {
  TheatresBloc() : super(const TheatresLoadingState()) {
    on<LoadTheatresEvent>(loadTheatres);
  }

  Future<void> loadTheatres(
      LoadTheatresEvent event, Emitter<TheatresStates> emit) async {
    try {
      final theatres = await TheatreRepository().fetchTheatres();
      emit(TheatresLoadedState(theatres));
    } catch (e) {
      emit(TheatresLoadedErrorState('Error:$e'));
    }
  }
}

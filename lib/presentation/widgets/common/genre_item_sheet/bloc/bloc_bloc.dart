import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_state.dart';

class GenreSelectionBloc
    extends Bloc<GenreSelectionEvent, GenreSelectionState> {
  GenreSelectionBloc() : super(GenreInitialState()) {
    on<InitializeGenreSelectionEvent>((event, emit) {
      emit(GenreLoadedState(
          items: event.items, selectedItems: event.preselectedItems));
    });

    on<GenreSelectedEvent>((event, emit) {
      if (state is GenreLoadedState) {
        final currentState = state as GenreLoadedState;
        final updatedSelectedItems =
            List<String>.from(currentState.selectedItems)..add(event.item);
        emit(GenreLoadedState(
          items: currentState.items,
          selectedItems: updatedSelectedItems,
        ));
      }
    });

    on<GenreDeselectedEvent>((event, emit) {
      if (state is GenreLoadedState) {
        final currentState = state as GenreLoadedState;
        final updatedSelectedItems =
            List<String>.from(currentState.selectedItems)..remove(event.item);
        emit(GenreLoadedState(
          items: currentState.items,
          selectedItems: updatedSelectedItems,
        ));
      }
    });

    on<SubmitGenreSelectionEvent>((event, emit) {
      if (state is GenreLoadedState) {
        final currentState = state as GenreLoadedState;
        emit(GenreSubmittedState(currentState.selectedItems));
      }
    });
  }
}

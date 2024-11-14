// bloc_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/language_item_sheet/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/language_item_sheet/bloc/bloc_state.dart';

class MultipleItemSelectionBloc
    extends Bloc<MultipleItemSelectionEvent, MultipleItemSelectionState> {
  MultipleItemSelectionBloc() : super(ItemSelectionInitialState()) {
  
    on<InitializeItemSelectionEvent>((event, emit) {
      emit(ItemSelectionLoadedState(
          items: event.items, selectedItems: event.preselectedItems));
    });

    on<ItemSelectedEvent>((event, emit) {
      if (state is ItemSelectionLoadedState) {
        final currentState = state as ItemSelectionLoadedState;
        final updatedSelectedItems =
            List<String>.from(currentState.selectedItems)..add(event.item);
        emit(ItemSelectionLoadedState(
          items: currentState.items,
          selectedItems: updatedSelectedItems,
        ));
      }
    });

    on<ItemDeselectedEvent>((event, emit) {
      if (state is ItemSelectionLoadedState) {
        final currentState = state as ItemSelectionLoadedState;
        final updatedSelectedItems =
            List<String>.from(currentState.selectedItems)..remove(event.item);
        emit(ItemSelectionLoadedState(
          items: currentState.items,
          selectedItems: updatedSelectedItems,
        ));
      }
    });

    on<SubmitSelectionEvent>((event, emit) {
      if (state is ItemSelectionLoadedState) {
        final currentState = state as ItemSelectionLoadedState;
        emit(ItemSelectionSubmittedState(currentState.selectedItems));
      }
    });
  }
}

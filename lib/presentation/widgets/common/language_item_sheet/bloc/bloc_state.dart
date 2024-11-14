abstract class MultipleItemSelectionState {}

class ItemSelectionInitialState extends MultipleItemSelectionState {}

class ItemSelectionLoadedState extends MultipleItemSelectionState {
  final List<String> items;
  final List<String> selectedItems;

  ItemSelectionLoadedState({required this.items, required this.selectedItems});
}

class ItemSelectionSubmittingState extends MultipleItemSelectionState {}

class ItemSelectionSubmittedState extends MultipleItemSelectionState {
  final List<String> selectedItems;

  ItemSelectionSubmittedState(this.selectedItems);
}

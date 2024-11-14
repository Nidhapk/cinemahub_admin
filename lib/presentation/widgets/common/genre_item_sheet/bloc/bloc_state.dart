abstract class GenreSelectionState {}

class GenreInitialState extends GenreSelectionState {}

class GenreLoadedState extends GenreSelectionState {
  final List<String> items;
  final List<String> selectedItems;

  GenreLoadedState
  ({required this.items, required this.selectedItems});
}

class GenreSubmittingState extends GenreSelectionState {}

class GenreSubmittedState extends GenreSelectionState {
  final List<String> selectedItems;

  GenreSubmittedState(this.selectedItems);
}

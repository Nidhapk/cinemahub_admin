abstract class GenreSelectionEvent {}

class InitializeGenreSelectionEvent extends GenreSelectionEvent {
  final List<String> items;
  final List<String> preselectedItems;

  InitializeGenreSelectionEvent({required this.items, required this.preselectedItems});
}

class GenreSelectedEvent extends GenreSelectionEvent {
  final String item;

  GenreSelectedEvent(this.item);
}

class GenreDeselectedEvent extends GenreSelectionEvent {
  final String item;

  GenreDeselectedEvent(this.item);
}

class SubmitGenreSelectionEvent extends GenreSelectionEvent {}

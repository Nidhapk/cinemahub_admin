abstract class MultipleItemSelectionEvent {}

class InitializeItemSelectionEvent extends MultipleItemSelectionEvent {
  final List<String> items;
  final List<String> preselectedItems;

  InitializeItemSelectionEvent({required this.items, required this.preselectedItems});
}

class ItemSelectedEvent extends MultipleItemSelectionEvent {
  final String item;

  ItemSelectedEvent(this.item);
}

class ItemDeselectedEvent extends MultipleItemSelectionEvent {
  final String item;

  ItemDeselectedEvent(this.item);
}

class SubmitSelectionEvent extends MultipleItemSelectionEvent {}

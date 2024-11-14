import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/modals/movie_model.dart';

abstract class AddDetailsEvent extends Equatable {
  const AddDetailsEvent();

  @override
  List<Object?> get props => [];
}

class DropdownItemSelected extends AddDetailsEvent {
  final String selectedItem;

  const DropdownItemSelected(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class MultipleDropdownItemSelected extends AddDetailsEvent {
  final List<String>? selectedLanguages;
  final List<String>? selectedGenres;

  const MultipleDropdownItemSelected({
    this.selectedLanguages,
    this.selectedGenres,
  });

  @override
  List<Object?> get props => [selectedLanguages, selectedGenres];
}

class AddCastMemberEvent extends AddDetailsEvent {
  final String name;
  final String imagePath;

  const AddCastMemberEvent({
    required this.name,
    required this.imagePath,
  });

  @override
  List<Object> get props => [name, imagePath];
}

class DeleteCastMemberEvent extends AddDetailsEvent {
  final String name;

  const DeleteCastMemberEvent({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class ClearCastMembersEvent extends AddDetailsEvent {
  const ClearCastMembersEvent();

  @override
  List<Object?> get props => [];
}

class AddMovieEvent extends AddDetailsEvent {
  final MovieClass movie;
  const AddMovieEvent(this.movie);

  @override
  List<Object> get props => [];
}

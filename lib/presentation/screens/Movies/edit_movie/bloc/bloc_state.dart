import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';

abstract class EditMovieState extends Equatable {
  const EditMovieState();

  @override
  List<Object> get props => [];
}

class EditMovieInitial extends EditMovieState {}

class EditMovieLoading extends EditMovieState {}

class EditMovieSuccess extends EditMovieState {}

class EditDropdownItemSelectedState extends EditMovieState {
  final String selectedItem;

  const EditDropdownItemSelectedState(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class EditMultipleItemsSelectedState extends EditMovieState {
  final List<String> selectedLanguages;
  final List<String> selectedGenres;

  const EditMultipleItemsSelectedState({
    required this.selectedLanguages,
    required this.selectedGenres,
  });

  @override
  List<Object> get props => [selectedLanguages, selectedGenres];
}

class EditMovieFailure extends EditMovieState {
  final String error;

  const EditMovieFailure(this.error);

  @override
  List<Object> get props => [error];
}

class CastMembersUpdatedStateInEditPage extends EditMovieState {
  final List<CastMember> castMembers;

  const CastMembersUpdatedStateInEditPage({required this.castMembers});

  @override
  List<Object> get props => [castMembers];
}

class DropdownItemSelectedStateinEdit extends EditMovieState {
  final String selectedItem;

  const DropdownItemSelectedStateinEdit(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class CastememberDeletedState extends EditMovieState {
  final CastMember member;
 const CastememberDeletedState(this.member);
  @override
  List<Object> get props => [member];
}

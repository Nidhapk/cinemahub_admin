import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';

abstract class AddDetailsState extends Equatable {
  const AddDetailsState();

  @override
  List<Object> get props => [];
}

class AddDetailsInitial extends AddDetailsState {}

class DropdownItemSelectedState extends AddDetailsState {
  final String selectedItem;

  const DropdownItemSelectedState(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class MultipleItemsSelectedState extends AddDetailsState {
  final List<String> selectedLanguages;
  final List<String> selectedGenres;

  const MultipleItemsSelectedState({
    required this.selectedLanguages,
    required this.selectedGenres,
  });

  @override
  List<Object> get props => [selectedLanguages, selectedGenres];
}

class CastMembersUpdatedState extends AddDetailsState {
  final List<CastMember> castMembers;

  const CastMembersUpdatedState({required this.castMembers});

  @override
  List<Object> get props => [castMembers];
}

// class CastMember {
//   final String name;
//   final String imagePath;

//   CastMember({required this.name, required this.imagePath});
// }
class AddMovieSuccessState extends AddDetailsState {
  final String message;
const  AddMovieSuccessState({this.message = 'Movies has been successfully Added'});
 @override
  List<Object> get props => [message];
}
class AddMovieFailureState extends AddDetailsState {
  final String message;
const  AddMovieFailureState(this.message);
 @override
  List<Object> get props => [message];
}class AddMovieLoadingState extends AddDetailsState{
  
}
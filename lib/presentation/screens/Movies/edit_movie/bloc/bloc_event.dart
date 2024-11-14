import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';
import 'package:onlinebooking_adminside/data/modals/movie_review_model.dart';

abstract class EditMovieEvent extends Equatable {
  const EditMovieEvent();

  @override
  List<Object> get props => [];
}

class DropdownItemSelected extends EditMovieEvent {
  final String selectedItem;

  const DropdownItemSelected(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class MultipleDropdownItemSelected extends EditMovieEvent {
  final List<String> selectedLanguages;
  final List<String> selectedGenres;

  const MultipleDropdownItemSelected({
    required this.selectedLanguages,
    required this.selectedGenres,
  });

  @override
  List<Object> get props => [selectedLanguages, selectedGenres];
}

class EditMovieButtonPressed extends EditMovieEvent {
  final String movieId;
  final bool blocked;
  final String trailerLink;
  final String movieName;
  final String certificate;
  final List<String> languages;
  final List<String> genres;
  final String releaseDate;
  final String duration;
  final String description;
  final List<CastMember> castMembers;
  final String posterImage;
  final String backdropImage;
  final List<MovieReviewModel> review;

  const EditMovieButtonPressed({
    required this.blocked,
    required this.movieId,
    required this.trailerLink,
    required this.movieName,
    required this.certificate,
    required this.languages,
    required this.genres,
    required this.releaseDate,
    required this.duration,
    required this.description,
    required this.castMembers,
    required this.posterImage,
    required this.backdropImage,
    required this.review
  });

  @override
  List<Object> get props => [
        movieId,
        trailerLink,
        movieName,
        certificate,
        languages,
        genres,
        releaseDate,
        duration,
        description,
        castMembers,
        posterImage,
        backdropImage,review
      ];
}

class AddCastMemberEventInEdit extends EditMovieEvent {
  final String name;
  final String imagePath;

  const AddCastMemberEventInEdit({
    required this.name,
    required this.imagePath,
  });
}

class DeletecastememberinEdit extends EditMovieEvent {
  final int index;
  const DeletecastememberinEdit(this.index);
}

class ClearCastMembersEventInEditPage extends EditMovieEvent {
  const ClearCastMembersEventInEditPage();

  @override
  List<Object> get props => [];
}

class DropdownItemSelectedinEdit extends EditMovieEvent {
  final String selectedItem;

  const DropdownItemSelectedinEdit(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class InitializeCastMembersEvent extends EditMovieEvent {
  final List<CastMember> originalCastMembers;
  const InitializeCastMembersEvent(this.originalCastMembers);
}

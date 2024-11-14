import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}
class FetchMovieEvent extends MovieEvent {
  final String movieId;

  const FetchMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

// Event to fetch all movies
class FetchAllMoviesEvent extends MovieEvent {}
class BlockMovieEvent extends MovieEvent {
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

  const BlockMovieEvent({
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
        backdropImage
      ];
}

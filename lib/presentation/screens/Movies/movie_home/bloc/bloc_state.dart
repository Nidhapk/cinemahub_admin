import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/modals/movie_model.dart';

abstract class MovieState extends Equatable{
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieClass movie;

  const MovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}
class NoMoviesLoaded extends MovieState{
  
}

class MoviesLoaded extends MovieState {
  final List<MovieClass> movies;

  const MoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}
class MovieDeleting extends MovieState {}

class MovieDeletedSuccess extends MovieState {


  const MovieDeletedSuccess();

  @override
  List<Object> get props => [];
}
class MovieDeletionError extends MovieState {
  final String message;

  const MovieDeletionError(this.message);

  @override
  List<Object> get props => [message];
}
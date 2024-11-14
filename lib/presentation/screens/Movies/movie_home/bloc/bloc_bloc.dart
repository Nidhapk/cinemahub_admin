import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieDatabaserepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchAllMoviesEvent>(_onFetchAllMovies);
    on<FetchMovieEvent>(_onFetchMovie);
    on<BlockMovieEvent>(deleteMovie);
  }

 Future<void> _onFetchAllMovies(
  FetchAllMoviesEvent event,
  Emitter<MovieState> emit,
) async {
  emit(MovieLoading());
  try {
    final movies = await movieRepository.getAllMovies();
    
    if (movies.isEmpty) {
      emit(NoMoviesLoaded());  // Emit a state when no movies are available
    } else {
      emit(MoviesLoaded(movies));  // Emit the loaded movies state
    }
  } catch (e) {
    emit(MovieError("Failed to fetch movies: $e"));
  }
}

  Future<void> _onFetchMovie(
    FetchMovieEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    try {
      final movie = await movieRepository.getMovies(event.movieId);
      emit(MovieLoaded(movie));
    } catch (e) {
      emit(MovieError("Failed to fetch movie: $e"));
    }
  }

  Future<void> deleteMovie(
      BlockMovieEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      await movieRepository.updateMovie(
          blocked: true,
          backdropImage: event.backdropImage,
          movieId: event.movieId,
          trailerLink: event.trailerLink,
          movieName: event.movieName,
          certificate: event.certificate,
          languages: event.languages,
          genres: event.genres,
          releaseDate: event.releaseDate,
          duration: event.duration,
          description: event.description,
          castMembers: event.castMembers,
          posterImage: event.posterImage);
      final movies = await movieRepository.getAllMovies();
       emit(
        const MovieDeletedSuccess(),
      );
      emit(
        MoviesLoaded(movies),
      );
     
    } catch (e) {
      log(' error deleting $e');
      emit(
        MovieError('$e'),
      );
    }
  }
}

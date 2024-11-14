import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_event.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'bloc_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDatabaserepository movieRepository;

  MovieDetailsBloc({required this.movieRepository})
      : super(MovieDetailsLoading()) {
    on<FetchMovieDetailsinPageEvent>(_onFetchMovieDetails);
    on<ToggleDescriptionEvent>(onToggleDescription);
    on<PlayVideoEvent>(_mapPlayVideoToState);
  }

  Future<void> _onFetchMovieDetails(FetchMovieDetailsinPageEvent event,
      Emitter<MovieDetailsState> emit) async {
    try {
      emit(MovieDetailsLoading());
      final movie = await movieRepository.getMovies(event.movieId);
      emit(MovieDetailsLoaded(movie));
    } catch (error) {
      emit(const MovieError('Failed to fetch movie details.'));
    }
  }

  void onToggleDescription(
      ToggleDescriptionEvent event, Emitter<MovieDetailsState> emit) {
    if (state is MovieDetailsLoaded) {
      final currentState = state as MovieDetailsLoaded;
      // Emit a new state with toggled description
      emit(currentState.copyWith(
        isDescriptionExpanded: !currentState.isDescriptionExpanded,
      ));
    }
  }

  Future<void> _mapPlayVideoToState(
      PlayVideoEvent event, Emitter<MovieDetailsState> emit) async {
    emit(VideoLoadingState());

    try {
      final videoId = YoutubePlayer.convertUrlToId(event.videoUrl)!;
      final controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags:const  YoutubePlayerFlags(autoPlay: true, mute: false),
      );

     controller.initialVideoId;

      emit(VideoPlayingState(
        controller,
        event.isFullScreen));
    } catch (e) {
      emit(const MovieError('Failed to load video'));
    }
  }

   void onToggleFullScreen(
      ToggleFullScreenEvent event, Emitter<MovieDetailsState> emit) {
    if (state is VideoPlayingState) {
      final currentState = state as VideoPlayingState;
      emit(currentState.copyWith(isFullScreen: event.isFullScreen));
    }
  }
}

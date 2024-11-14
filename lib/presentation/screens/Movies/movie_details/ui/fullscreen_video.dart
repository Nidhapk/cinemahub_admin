import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreen extends StatelessWidget {
  final String movieId;
  const FullScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  context
                      .read<MovieDetailsBloc>()
                      .add(FetchMovieDetailsinPageEvent(movieId));
                  Navigator.of(context).pop();
                },
                icon:const  Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ))),
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is VideoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VideoPlayingState) {
              return YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: state.controller,
                  showVideoProgressIndicator: true,
                ),
                builder: (context, player) {
                  return Center(
                    child: player,
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ));
  }
}

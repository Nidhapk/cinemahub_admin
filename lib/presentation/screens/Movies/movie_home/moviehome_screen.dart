import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/edit_movie.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/ui/view_movie_details.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_alertbox.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_snackbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/custom_movie_container.dart';

class MovieHomeScreen extends StatelessWidget {
  const MovieHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(FetchAllMoviesEvent());
    return Stack(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state is MovieDeletedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                      text: 'Movie has been deleted successfully',
                      icon: Icons.check_circle,
                      iconColor: green,
                      borderColor: green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MoviesLoaded) {
                  final unblockedMovies = state.movies
                      .where((movie) => movie.blocked == false)
                      .toList();
                  if (unblockedMovies.isEmpty) {
                    return const Center(child: Text("No  movies available"));
                  }
                  return Stack(
                    children: [
                      GridView.builder(
                        itemCount: unblockedMovies.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.55),
                        itemBuilder: (context, index) {
                          final movie = unblockedMovies[index];

                          return CustomMovieContainer(
                            image: movie.posterImage.isEmpty
                                ? const AssetImage('assets/profile.jpg')
                                : NetworkImage(state.movies[index].posterImage
                                    // File(state.movies[index].posterImage),
                                    ),
                            movieName: movie.movieName,
                            onPressed: () {
                              context.read<MovieDetailsBloc>().add(
                                  FetchMovieDetailsinPageEvent(
                                      movie.movieId ?? ''));

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViewMovieDetails(
                                    movieId: movie.movieId ?? '',
                                  ),
                                ),
                              );
                            },
                            onSelected: (value) {
                              if (value == 'edit') {
                                context.read<MovieBloc>().add(
                                      FetchMovieEvent(movie.movieId ?? ''),
                                    );
                                context.read<EditMovieBloc>().add(
                                    InitializeCastMembersEvent(
                                        movie.castMembers));
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditMovieScreen(
                                      movieClass: movie,
                                      movieId: movie.movieId ?? '',
                                    ),
                                  ),
                                );
                              } else if (value == 'delete') {
                                context.read<MovieBloc>().add(
                                      BlockMovieEvent(
                                          blocked: true,
                                          movieId: movie.movieId ?? '',
                                          trailerLink: movie.trailerLink,
                                          movieName: movie.movieName,
                                          certificate: movie.certificate,
                                          languages: movie.languages,
                                          genres: movie.genres,
                                          releaseDate: movie.releaseDate,
                                          duration: movie.duration,
                                          description: movie.description,
                                          castMembers: movie.castMembers,
                                          posterImage: movie.posterImage,
                                          backdropImage: movie.backdropImage),
                                    );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is NoMoviesLoaded) {
                  return const Center(
                    child: Text('No Movies Available'),
                  );
                } else if (state is MovieError) {
                  log(state.message);
                  return CustomAlertBox(
                    title: 'Error',
                    content: 'Error loading movies : ${state.message}',
                    confirmText: 'Ok',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                } else {
                  return CustomAlertBox(
                    title: 'Something went wrong',
                    content: 'Something went wrong ,try again later',
                    confirmText: 'Ok',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Material(
              elevation: 5,
              shadowColor: const Color.fromARGB(255, 219, 250, 220),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: mainColor,
              child: FloatingActionButton.small(
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pushNamed('/addMovie');
                },
                elevation: 0,
                child: Image.asset(
                  'assets/video.png',
                  height: 35,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

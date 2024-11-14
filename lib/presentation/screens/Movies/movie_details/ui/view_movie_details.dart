import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/ui/fullscreen_video.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/castemember_container.dart';

class ViewMovieDetails extends StatelessWidget {
  final String movieId;
  const ViewMovieDetails({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieDetailsLoaded) {
            final movie = state.movie;

            DateTime parsedDate =
                DateFormat('dd/MM/yyyy').parse(movie.releaseDate);
            String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.3,
                      width: width,
                      // color: Colors.grey,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(movie.backdropImage)
                          //  FileImage(File(movie.backdropImage))
                          ,
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.04,
                      left: width * 0.03,
                      child: GestureDetector(
                        onTap: Navigator.of(context).pop,
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: mainColor,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: black,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.13,
                      left: width * 0.45,
                      child: movie.trailerLink.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                      movieId: movieId,
                                    ),
                                  ),
                                );
                                context.read<MovieDetailsBloc>().add(
                                      PlayVideoEvent(
                                        movie.trailerLink,
                                      ),
                                    );
                              },
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: mainColor,
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: black,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(width * 0.03),
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        movie.movieName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        movie.genres.join(', '),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '${movie.duration.split(':')[0]}hr ${movie.duration.split(':')[1]}min  .  ${movie.certificate}  .  $formattedDate ',
                        style: const TextStyle(
                            color: Color.fromRGBO(92, 92, 92, 1),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          color: const Color.fromARGB(255, 192, 192, 192),
                          child: Text(
                            movie.languages.join(', '),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 360,
                            child: Text(
                                textAlign: TextAlign.justify,
                                movie.description),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      const Text(
                        'Cast',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 35,
                            childAspectRatio: 0.5,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.movie.castMembers.length,
                          itemBuilder: (context, index) {
                            final casteMember = state.movie.castMembers[index];
                            return CasteMemberContainer(
                              onPressed: () {},
                              casteMemberImage: casteMember.imagePath,
                              casteMembername: casteMember.name,
                            );
                          }),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
            // } else if (state is VideoPlayingState) {
            //   log('controller: ${state.controller}');
            //   return YoutubePlayerBuilder(
            //     player: YoutubePlayer(
            //       controller: state.controller,
            //       showVideoProgressIndicator: true,
            //     ),
            //     builder: (context, player) {
            //       return Column(
            //         children: [
            //           player,
            //         ],
            //       );
            //     },
            //   );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}

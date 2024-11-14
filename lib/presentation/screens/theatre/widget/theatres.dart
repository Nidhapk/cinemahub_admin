import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/widget/theatres_builder.dart';

Widget theatres() {
  return BlocBuilder<TheatresBloc, TheatresStates>(builder: (context, state) {
    if (state is TheatresLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TheatresLoadedState) {
      final theatres = state.theatre;
      if (theatres.isEmpty) {
        return const Text('No theatres');
      } else {
        return theatresBuilder(context: context, itemCount: theatres.length,theatres: theatres);
      }
    } else if (state is TheatresLoadedErrorState) {
      return Center(
        child: Text(state.error),
      );
    } else {
      return const Text('something went wrong');
    }
  });
}

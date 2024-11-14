import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/drawer.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/widget/theatres.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_mainappbar.dart';

class TheatreHomeScreen extends StatelessWidget {
  const TheatreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKeyyy = GlobalKey<ScaffoldState>();
    context.read<TheatresBloc>().add(const LoadTheatresEvent());
    return Scaffold(
      backgroundColor: appBackgroundColor,
      key: scaffoldKeyyy,
      appBar: HomeAppBar(
        title: 'Theatres',
        onPressed: () {
          scaffoldKeyyy.currentState?.openDrawer();
        },
      ),
      body: theatres(),
      drawer: const CustomDrawer(),
    );
  }
}

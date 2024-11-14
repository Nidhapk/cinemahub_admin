import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/moviehome_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/drawer.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_mainappbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        appBar: HomeAppBar(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          title: 'Movies',
        ),
        body: const MovieHomeScreen(),
        drawer: const CustomDrawer());
  }
}

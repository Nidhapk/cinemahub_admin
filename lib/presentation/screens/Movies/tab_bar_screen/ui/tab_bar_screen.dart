import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/languages/ui/languages_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/moviehome_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/drawer.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';


class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: mainColor,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Movies'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: const CustomDrawer(), // Add your custom drawer here
        body: const Column(
          children: [
             TabBar(
              tabs: [
                Tab(text: "Movies"),
                Tab(text: "Languages "),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: MovieHomeScreen()),
                  Center(child: LanguagesScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

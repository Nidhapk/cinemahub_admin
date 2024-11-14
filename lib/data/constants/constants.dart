import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/drawer_item.dart';

BuildContext? context;

final List<ListItem> items = [
  // ListItem(path: 'assets/icons8-menu-64.png',title: 'Dashboard'),
  ListItem(
    path: 'assets/icons8-movies-96.png',
    title: 'Movies',
  ),
  ListItem(
    path: 'assets/icons8-movies-100.png',
    title: 'Theatres',
  ),
  // ListItem(
  //   path: 'assets/icons8-users-96.png',
  //   title: 'Users',
  // ),
  ListItem(
    path: 'assets/icons8-admin-settings-male-96.png',
    title: 'Profile',
  ),
  ListItem(
    path: 'assets/icons8-logout-100.png',
    title: 'Logout',
  ),
];

final List<String> certificateItems = ['U', 'UA', 'A', 'S'];
final List<String> languageItems = [
  'English',
  'Hindi',
  'Malayalam',
  'Tamil',
  'Telugu',
  'Kannada',
  'Marathi',
  'Bengali',
  'Punjabi'
];

final List<String> genreItems = [
  'Comedy',
  'Horror',
  'Action',
  'Drama',
  'Romance',
  'Fantacy',
  'Thriller',
  'Crime',
  'Mistery',
  'Black comedy'
];

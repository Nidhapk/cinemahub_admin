import 'package:flutter/material.dart';

class ListItem {
  final String path;
  final String title;
  final VoidCallback? onTap;

  ListItem({
    required this.path,
    required this.title,
    this.onTap ,
  });
}

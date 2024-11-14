import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';

SnackBar customSnackBar({
  required String text,
  required IconData icon,
  required Color iconColor,
  required Color borderColor,
  
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: borderColor),
    ),
    content: Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 30,
        ),
        Flexible(
          child: Text(
            text,
            style:  TextStyle(color: iconColor, fontSize: 10),
          ),
        ),
      ],
    ),
    backgroundColor: black,
  );
}

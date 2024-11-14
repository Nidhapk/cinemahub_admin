import 'package:flutter/material.dart';

Widget onTapContainer(
    {required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required void Function()? onTap}) {
  final width = MediaQuery.of(context).size.width;
  // final height = MediaQuery.of(context).size.height;
  return Padding(
    padding:
        EdgeInsets.only(left: width * 0.05, right: width * 0.05, bottom: 5),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 0.1),
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(197, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.1))
            ]),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            Icon(
              icon,
              color: color,
              size: width * 0.05,
            ),
            SizedBox(
              width: width * 0.1,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

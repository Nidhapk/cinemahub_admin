import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;final void Function()? onPressed;
  const CustomAppBar({super.key, required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 25,
            ),
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.transparent,
          height: 1.0,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

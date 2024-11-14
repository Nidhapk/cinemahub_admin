import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onPressed;
  final Widget? tabBar;
  const HomeAppBar(
      {super.key, required this.title, required this.onPressed, this.tabBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.menu,
              size: 25,
            ),
          );
        },
      ),
      bottom:  PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.transparent,
                // height: 1,
                child:
                    Container(
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
          
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

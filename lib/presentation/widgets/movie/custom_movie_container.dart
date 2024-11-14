import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';

class CustomMovieContainer extends StatelessWidget {
 // final int itemCount;
  final ImageProvider<Object> image;
  final String movieName;
  final void Function()? onPressed;

  final void Function(String)? onSelected;
  const CustomMovieContainer(
      {super.key,
     // required this.itemCount,
      required this.image,
      required this.movieName,
      required this.onPressed,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 139, 138, 141).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(2, 1),
            ),
          ],
        ),
        height: 160,
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(image: image, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                movieName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ),
            const Divider(
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 2, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 76,
                    height: 23,
                    child: TextButton(
                      onLongPress: onPressed,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: const BorderSide(color: green, width: 1),
                      ),
                      onPressed: onPressed,
                      child: const Text(
                        'VIEW DETAILS',
                        style: TextStyle(color: green, fontSize: 7),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 20,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          popupMenuTheme: PopupMenuThemeData(
                            color: mainColor,
                            shadowColor:const Color.fromARGB(
                                255, 213, 213, 218), // Black background color
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                        child: PopupMenuButton<String>(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 25, top: 0),
                          icon: const Icon(
                            Icons.more_vert_outlined,
                            color: Colors.green,
                            size: 20,
                          ),
                          onSelected: onSelected,
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                           const  PopupMenuItem<String>(
                              height: 10,
                              value: 'edit',
                              padding: EdgeInsets.only(
                                  top: 5), // Adjust padding here
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                   Text('Edit     ',
                                      style: TextStyle(fontSize: 12)),
                                  Icon(
                                    Icons.edit_note,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                           const PopupMenuItem<String>(
                              height: 10,
                              value: 'delete',
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 5), // Adjust padding here
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                   Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.delete_sweep_outlined,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

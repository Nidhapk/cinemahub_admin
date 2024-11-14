import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/data/modals/theatre_model.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';

Widget theatreContainer(
    {required BuildContext context,
    required TheatreModel theatre,
    required void Function()? onTap}) {
  final width = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.all(width * 0.05),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 139, 138, 141).withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(2, 1),
            ),
          ],
        ),
        child: Padding(
           padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    opacity: 0.85,
                    fit: BoxFit.cover,
                    image: theatre.profileImage.isNotEmpty
                        ? NetworkImage(
                            theatre.profileImage,
                          )
                        : const AssetImage(''),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    theatre.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Row(
                    children: [
                      // Icon(
                      //   Icons.star_outlined,
                      //   size: 17,
                      //   color: Color.fromARGB(
                      //     255,
                      //     252,
                      //     227,
                      //     3,
                      //   ),
                      //   shadows: [
                      //     Shadow(
                      //       color: Color.fromARGB(255, 215, 215, 192),
                      //       offset: Offset(0, 0),
                      //       blurRadius: 5,
                      //     ),
                      //   ],
                      // // ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      // Text(
                      //   '4.8',
                      //   style: TextStyle(fontWeight: FontWeight.w500),
                      // ),
                      // SizedBox(
                      //   width: 5,
                      // )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 12,
                  ),
                  Text(
                    theatre.address,
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

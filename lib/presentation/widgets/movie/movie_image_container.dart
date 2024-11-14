import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_textstyles.dart';
import 'package:onlinebooking_adminside/presentation/widgets/sizedbox_one.dart';

class MovieImageContainer extends StatelessWidget {
  final double posterImageWidth;
  final double backdropImageWidth;
  final DecorationImage? posterImage;
  final DecorationImage? backdropImage;
  final double sizedBoxWidth;
  final void Function()? posteronTap;
  final void Function()? backdroponTap;
  final Widget? posterChild;
  final Widget? backdropChild;
  const MovieImageContainer(
      {super.key,
      required this.posterImageWidth,
      required this.backdropImageWidth,
      required this.sizedBoxWidth,
      required this.posteronTap,
      required this.backdroponTap,
      required this.posterChild,
      required this.backdropChild,
      required this.backdropImage,
      required this.posterImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Poster Image', style: AppTextstyles.textformTitleStyle),
              const SizedBoxOne(),
              GestureDetector(
                onTap: posteronTap,
                child: Container(
                  height: 150,
                  width: posterImageWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: posterImage,
                    border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 199, 199, 206),
                    ),
                  ),
                  child: posterChild,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '2 : 3 preferred',
                  style: TextStyle(
                      color: Color.fromARGB(255, 175, 175, 180),
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          SizedBox(
            width: sizedBoxWidth,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Backdrop Image', style: AppTextstyles.textformTitleStyle),
              const SizedBoxOne(),
              GestureDetector(
                onTap: backdroponTap,
                child: Container(
                  height: 150,
                  width: backdropImageWidth,
                  decoration: BoxDecoration(
                    image: backdropImage,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 199, 199, 206),
                    ),
                  ),
                  child: backdropChild,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '4 : 3 preferred',
                  style: TextStyle(
                      color: Color.fromARGB(255, 175, 175, 180),
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

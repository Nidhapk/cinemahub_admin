import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinebooking_adminside/data/modals/theatre_model.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre_details/widget/main_photo_container.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre_details/widget/ontap_photocontainers.dart';

Widget photoGallery(
    {required BuildContext context, required TheatreModel theatre}) {
  final height = MediaQuery.of(context).size.height;
  return SizedBox(
    height: height * 0.4,
    child: Stack(
      children: [
        mainPhotoContainer(context: context, theatre: theatre),
        Align(
          alignment: Alignment.bottomCenter,
          child: onTapPhotoContainers(context: context, theatre: theatre),
        )
      ],
    ),
  );
}

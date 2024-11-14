import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/data/modals/theatre_model.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/widget/theatre_container.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre_details/ui/theatre_details_screen.dart';

Widget theatresBuilder(
    {required BuildContext context,
    required int itemCount,
    required List<TheatreModel> theatres}) {
  return ListView.builder(
    itemCount: itemCount,
    itemBuilder: (context, index) {
      return theatreContainer(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TheatreDetailsScreen(
              theatre: theatres[index],
            ),
          ),
        ),
        context: context,
        theatre: theatres[index],
      );
    },
  );
}

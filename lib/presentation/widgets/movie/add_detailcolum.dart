import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_textstyles.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/details_textform.dart';

class AddDetailColum extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final void Function()? onTap;
  final bool? readOnly;
  final List<String>? dropdownItems;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int? maxLines;
  const AddDetailColum(
      {super.key,
      required this.controller,
      required this.title,
      required this.hintText,
      this.onTap,
      this.readOnly,
      this.dropdownItems,
      this.suffixIcon,
      this.validator,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    log('rebuild');
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextstyles.textformTitleStyle),
          DetailsTextForm(
            controller: controller,
            suffixIcon: suffixIcon,
            maxLines: maxLines,
            hintText: hintText,
            onTap: onTap,
            readOnly: readOnly ?? false,
            validator: validator,
          )
        ],
      ),
    );
  }
}

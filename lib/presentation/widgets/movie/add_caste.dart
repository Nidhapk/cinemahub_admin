import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_buttom.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_textform.dart';

class CasteBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final Widget imagePicker;
  final void Function()? addCasteButtonOnPressed;
 final  String? Function(String?)? validator;
  const CasteBottomSheet(
      {super.key, required this.controller, required this.imagePicker,required this.addCasteButtonOnPressed,this.validator});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        imagePicker,
        CustomTextForm(
          controller: controller,
          hintText: 'Name',
          validator: validator,
        ),
        CustomButton(
          onPressed: addCasteButtonOnPressed,
        ),
      ],
    );
  }
}

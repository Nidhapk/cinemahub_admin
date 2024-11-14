import 'package:flutter/material.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/add_detailcolum.dart';

class AddDetailRaw extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final String title1;
  final String title2;
  final String hintText1;
  final String hintText2;
  final void Function()? onTap;
  final bool? readOnly;
  final List<String>? dropdownItems;
  final Widget? suffixIcon;
  final Widget? calendarIcon;
  final String? Function(String?)? validatorOne;
  final String? Function(String?)? validatorTwo;

  const AddDetailRaw(
      {super.key,
      required this.controller1,
      required this.controller2,
      required this.title1,
      required this.title2,
      required this.hintText1,
      required this.hintText2,
      this.onTap,
      this.readOnly,
      this.dropdownItems,
      this.suffixIcon,this.calendarIcon,
      this.validatorOne,
      this.validatorTwo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: AddDetailColum(
            controller: controller1,
            title: title1,
            hintText: hintText1,
            validator: validatorOne,
            suffixIcon: calendarIcon,
          ),
        ),
        Expanded(
          child: AddDetailColum(
            controller: controller2,
            title: title2,
            hintText: hintText2,
            onTap: onTap,
            validator: validatorTwo,
            readOnly: readOnly ?? false,
             suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

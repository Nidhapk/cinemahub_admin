import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final void Function(String)? onChanged;final TextInputType? keyboardType;
  const CustomTextForm(
      {super.key,
      required this.controller,
      this.validator,
      required this.hintText,
       this.labelText,
      this.suffixIcon,
     this.obscureText,
      this.onChanged,this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: TextFormField(keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: true,
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.only(left: 15),
          constraints: const BoxConstraints(minHeight: 50),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          hintText: hintText,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
          labelText: labelText,
          errorStyle:const  TextStyle(fontSize: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

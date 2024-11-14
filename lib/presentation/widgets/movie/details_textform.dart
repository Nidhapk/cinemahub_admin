import 'package:flutter/material.dart';

class DetailsTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final void Function()? onTap;
  final bool? readOnly;
  final int? maxLines;

  final Widget? suffixIcon;
  final bool? obscureText;
  
  final List<String>? dropdownItems;
  const DetailsTextForm(
      {super.key,
      required this.controller,
      this.validator,
      required this.hintText,
      this.suffixIcon,
      this.obscureText,
  
      this.onTap,
      this.readOnly,
      this.dropdownItems,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: true,
        controller: controller,
        obscureText: obscureText ?? false,
        maxLines: maxLines,
        onTap: onTap,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 243, 243, 245),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.only(left: 15),
          constraints: const BoxConstraints(minHeight: 50),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          hintText: hintText,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
          errorStyle: const TextStyle(fontSize: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 199, 199, 206),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 89, 89, 180),
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
        ),
        validator: validator,
        
      ),
    );
  }
}

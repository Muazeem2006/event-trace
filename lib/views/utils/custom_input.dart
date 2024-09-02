// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_trace/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.labelText = "",
    this.hintText = "",
    this.maxLines = 1,
    this.prefixIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.validator,
    this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: 1,
      style: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: appRed),
        ),
        labelText: labelText,
        hintText: hintText,
        errorStyle: TextStyle(
          fontSize: 12,
          color: appRed,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // prefixIconColor: Theme.of(context).colorScheme.primary,
        // suffixIconColor: Theme.of(context).colorScheme.primary,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}



import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData suffixIcon;
  final Function(String)? onChanged;
  final Function()? suffixIconPressed;
  final IconData prefixIcon;
  final Function()? prefixIconPressed;
  final Color color;
  final bool? readOnly;
  final FocusNode? focusNode;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.suffixIcon,
    required this.color,
    required this.prefixIcon,
    this.readOnly = false,
    this.focusNode,
    this.suffixIconPressed,
    this.prefixIconPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: color,
      readOnly: readOnly!,
      focusNode: focusNode,
      onChanged: onChanged,
      style: TextStyle(
        color: color,
      ),
      decoration: InputDecoration(
        hintText: 'Ex: São Paulo - SP',
        hintStyle: TextStyle(
          color: color,
        ),
        suffixIcon: IconButton(
          onPressed: suffixIconPressed,
          icon: Icon(
            suffixIcon,
            color: color,
          ),
        ),
        prefixIcon: IconButton(
          icon: Icon(
            prefixIcon,
            color: color,
          ),
          onPressed: prefixIconPressed,
        ),
        focusColor: color,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }
}

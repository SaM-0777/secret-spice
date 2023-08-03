import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';


class PrimaryTextInputField extends StatelessWidget {
  final String hintText;
  final Color? backgroundColor;
  final TextInputType? keyboardType;

  const PrimaryTextInputField({
    super.key, required this.hintText, this.backgroundColor, this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: backgroundColor ?? white,
        border: MaterialStateOutlineInputBorder.resolveWith(
          (states) => OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: neutral150,
            ),
          ),
        ),
      ),
    );
  }
}

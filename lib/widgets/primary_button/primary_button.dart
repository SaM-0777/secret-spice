import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class PrimaryTextButton extends StatelessWidget {
  final String labelText;
  final void Function() onPressed;
  final TextStyle? labeltextStyle;

  const PrimaryTextButton({
    super.key, required this.labelText, required this.onPressed, this.labeltextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((states) => 0),
        minimumSize: MaterialStateProperty.resolveWith(
            (states) => const Size(double.infinity, 54)),
        shape: MaterialStateProperty.resolveWith((states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        backgroundColor: MaterialStateColor.resolveWith((states) => primary800),
        splashFactory: NoSplash.splashFactory,
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      child: Text(
        labelText,
        style: labeltextStyle ?? heading5.copyWith(color: white),
      ),
    );
  }
}

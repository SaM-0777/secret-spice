import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class PrimaryTextIconButton extends StatelessWidget {
  final String iconPath;
  final String labelText;
  final TextStyle? labelTextStyle;
  final Color? backgrounColor;

  const PrimaryTextIconButton({
    super.key, required this.iconPath, required this.labelText, this.labelTextStyle, this.backgrounColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => backgrounColor ?? white),
          minimumSize: MaterialStateProperty.resolveWith(
              (states) => const Size(double.infinity, 54)),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: neutral500,
                ),
                borderRadius: BorderRadius.circular(16)),
          ),
          splashFactory: NoSplash.splashFactory,
          elevation: MaterialStateProperty.resolveWith((states) => 0),
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent)),
      icon: SvgPicture.asset(
        iconPath,
      ),
      label: Text(
        labelText,
        style: labelTextStyle ?? heading5.copyWith(color: neutral500),
      ),
    );
  }
}
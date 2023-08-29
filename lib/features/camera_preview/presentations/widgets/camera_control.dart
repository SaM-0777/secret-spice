import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class CameraControl extends StatelessWidget {
  final bool? isDisabled;
  final void Function() onTap;
  
  const CameraControl({
    super.key,
    required this.onTap,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12
          ),
          decoration: BoxDecoration(
            color: neutral900.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "Tap the shutter button to search",
            style: body1.copyWith(color: white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: isDisabled == true ? (){} : onTap,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    width: 1,
                    color: white,
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/SearchIcon.svg",
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: white),
                  top: BorderSide(width: 1, color: white),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class CameraControl extends StatelessWidget {
  final bool? isDisabled;
  final void Function() onTap;
  final void Function() onTapPickImage;
  
  const CameraControl({
    super.key,
    this.isDisabled,
    required this.onTap,
    required this.onTapPickImage,
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
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/GalleryIcon.svg",
                  width: 40,
                  height: 40,
                ),
                onPressed: isDisabled == true ? (){} : onTapPickImage,
              ),
            ),
            Align(
              //alignment: Alignment.center,
              child: GestureDetector(
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
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

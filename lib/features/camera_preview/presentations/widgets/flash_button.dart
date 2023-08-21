import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FlashButton extends StatelessWidget {
  const FlashButton({
    super.key,
    required this.flashMode,
    required this.onTap,
  });

  final FlashMode flashMode;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        flashMode == FlashMode.off
          ? "assets/icons/FlashOnIcon.svg"
          : "assets/icons/FlashOffIcon.svg",
        width: 24,
        height: 24,
      )
    );
  }
}

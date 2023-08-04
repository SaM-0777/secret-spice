import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? iconPath;
  final void Function()? onPressed;

  const Appbar({
    super.key,
    this.title,
    this.titleStyle,
    this.iconPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: neutral100,
      automaticallyImplyLeading: false,
      title: (title != null)
        ? Text(
            title!,
            style: titleStyle ??
                heading4.copyWith(
                    color: neutral800, fontWeight: FontWeight.w800),
          )
        : null,
      actions: (iconPath != null)
        ? <Widget>[
            IconButton(
                onPressed: onPressed,
                color: neutral700,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: SvgPicture.asset(
                  iconPath!,
                  width: 20,
                  height: 20,
                )),
          ]
        : null,
    );
  }

  @override
  // implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

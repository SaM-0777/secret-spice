import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool veg;
  final String prepTime;
  final String cuisine;
  final void Function() showBottomActionSheet;

  const RecipeCard({
    super.key, required this.imageUrl, required this.title, required this.veg, required this.prepTime, required this.cuisine, required this.showBottomActionSheet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showBottomActionSheet,
      child: Container(
        height: 140,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: neutral800.withOpacity(0.15),
              spreadRadius: -1,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 7,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: heading5.copyWith(
                          color: neutral800,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/StopwatchIcon.svg",
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            prepTime,
                            style: subtitle1.copyWith(color: neutral600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        cuisine,
                        style: subtitle1.copyWith(
                          color: secondary700,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      veg ? 
                        "assets/icons/VegIcon.svg"
                      :
                        "assets/icons/NonvegIcon.svg",
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

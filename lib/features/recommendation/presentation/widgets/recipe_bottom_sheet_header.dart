import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class RecipeBottomSheetHeader extends StatelessWidget {
  final String imageUrl;
  final bool isVeg;
  
  const RecipeBottomSheetHeader({
    super.key, required this.imageUrl, required this.isVeg,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: 170,
          height: 170,
          cacheHeight: 170,
          cacheWidth: 170,
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          width: isVeg ? 72 : 96,
          height: 30,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0XFF0C1A4B).withOpacity(0.15),
                blurRadius: 10
              ),
              BoxShadow(
                color: const Color(0XFF14253F).withOpacity(0.16),
                blurRadius: 16,
                offset: const Offset(0, 10)
              ),
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SvgPicture.asset(
                isVeg ? "assets/icons/VegIcon.svg" : "assets/icons/NonvegIcon.svg",
                width: 18,
                height: 18,
              ),
              Text(
                isVeg ? "Veg" : "Non-veg",
                style: cardsmall.copyWith(color: neutral500),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

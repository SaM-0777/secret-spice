import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class BottomActionSheetModal extends StatelessWidget {
  const BottomActionSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: neutral50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: <Widget>[
            Container(
              width: 130,
              height: 5,
              decoration: BoxDecoration(
                color: neutral300,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Stack(
              children: <Widget>[
                Image.asset(
                  "assets/images/avocadosandwich.png",
                  fit: BoxFit.cover,
                  width: 170,
                  height: 170,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0XFF0C1A4B).withOpacity(0.15),
                          blurRadius: 10
                        ),
                        BoxShadow(
                          color: Color(0XFF14253F).withOpacity(0.16),
                          blurRadius: 16,
                          offset: const Offset(0, 10)
                        ),
                      ]
                    ),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/NonvegIcon.svg",
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            "Non-veg",
                            style: cardsmall.copyWith(color: neutral500),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}

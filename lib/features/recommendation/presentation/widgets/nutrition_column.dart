import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class NutritionColumn extends StatelessWidget {
  final double value;
  final String label;
  
  const NutritionColumn({
    super.key, required this.value, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "$value",
          style: pricesmall.copyWith(color: neutral800),
        ),
        Text(
          label.toLowerCase(),
          style: body2.copyWith(color: neutral500),
        ),
      ],
    );
  }
}

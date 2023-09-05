import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class RecipeStepContainer extends StatelessWidget {
  final String step;
  
  const RecipeStepContainer({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        step,
        style: subtitle1.copyWith(color: neutral600),
      ),
    );
  }
}

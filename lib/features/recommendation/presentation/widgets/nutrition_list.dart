import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';

import 'nutrition_column.dart';

class NutritionList extends StatelessWidget {
  final List<Map<String, dynamic>> nutritions;
  
  const NutritionList({
    super.key, required this.nutritions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1,
            color: const Color(0XFF0C1A4B).withOpacity(0.15),
          ),
          BoxShadow(
            blurRadius: 20,
            color: neutral800.withOpacity(0.25),
            spreadRadius: -2,
            offset: const Offset(0, 4),
          ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: nutritions.map((nutrition) {
            return NutritionColumn(
              value: nutrition["value"],
              name: nutrition["name"],
            );
          }
        ).toList()
      ),
    );
  }
}
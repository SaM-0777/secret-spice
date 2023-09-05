import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';


class IngredientList extends StatelessWidget {
  final List<String> ingredients;
  
  const IngredientList({
    super.key, required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 122,
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(2, 20, 20, 20),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0XFF0C1A4B).withOpacity(0.05),
                      blurRadius: 1,
                    ),
                    BoxShadow(
                      color: neutral800.withOpacity(0.075),
                      blurRadius: 20,
                      spreadRadius: -2,
                      offset: const Offset(0, 4),
                    ),
                  ]),
              child: Center(
                child: Text(
                  ingredients[index],
                  style: body2.copyWith(color: neutral500),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';

import 'ingredient_list.dart';
import 'nutrition_list.dart';
import 'recipe_bottom_sheet_header.dart';
import 'recipe_step_container.dart';

class BottomActionSheetModal extends StatelessWidget {
  const BottomActionSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> preparationSteps = [
      "To begin making the Thayir Semiya recipe, firstly boil the vermicelli in 2 cups water. Drain it and spread on a colander. Pass cold water through it. This ensures that the vermicelli does not become sticky.",
      "Keep it aside and let it cool down.",
      "Heat a kadai/wok and add oil. Add the peanuts and roast till it turns brownish. Remove and keep it aside.",
      "In the same kadai, add more oil if needed and add the mustard seeds and after it splutters add the other ingredients meant for tempering. Add the boiled vermicelli and mix everything. Add salt to taste and mix.",
      "Finally just before serving add curd and mix well.A Serve Thayir Semiya on its own for a light and healthy lunch or dinner",
    ];

    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0XFFF7F7F7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 130,
                height: 5,
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: BoxDecoration(
                  color: neutral300,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const MaterialScrollBehavior().copyWith(
                  overscroll: false
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const RecipeBottomSheetHeader(
                        imageUrl: "assets/images/avocadosandwich.png",
                        isVeg: false,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Avocado and Egg Toast",
                        style: heading3.copyWith(color: neutral800),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "You won't skip the most important meal of the day with this avocado toast recipe. Crispy, lacy eggs and creamy avocado top hot buttered toast.",
                        style: subtitle1.copyWith(color: neutral500),
                      ),
                      const SizedBox(height: 35),
                      const NutritionList(
                        nutritions: [
                          {
                            "name": "kcal",
                            "value": 400,
                          },
                          {
                            "name": "grams",
                            "value": 510,
                          },
                          {
                            "name": "protiens",
                            "value": 30,
                          },
                          {
                            "name": "carbs",
                            "value": 56,
                          },
                          {
                            "name": "fats",
                            "value": 24,
                          },
                        ],
                      ),
                      const SizedBox(height: 35),
                      Text(
                        "Ingredients",
                        style: mediumbutton.copyWith(color: neutral600),
                      ),
                      const IngredientList(
                        ingredients: <String>[
                          "Egg",
                          "Avocado",
                          "Spinach",
                          "Bread",
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Preparations",
                        style: mediumbutton.copyWith(color: neutral600),
                      ),
                      const SizedBox(height: 20),
                      ...preparationSteps.map<Widget>((step) {
                        return RecipeStepContainer(
                          step: step,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';
import 'package:secret_spice/core/db/models/recipe_model.dart';

import 'ingredient_list.dart';
import 'nutrition_list.dart';
import 'recipe_bottom_sheet_header.dart';
import 'recipe_step_container.dart';

class BottomActionSheetModal extends StatelessWidget {
  final RecipeModel recipe;

  const BottomActionSheetModal({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
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
                      RecipeBottomSheetHeader(
                        imageUrl: recipe.image_url,
                        isVeg: recipe.diet == Diet.veg,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        recipe.name,
                        style: heading3.copyWith(color: neutral800),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        recipe.description,
                        style: subtitle1.copyWith(color: neutral500),
                      ),
                      const SizedBox(height: 35),
                      NutritionList(
                        nutritions: [
                          Nutrition(
                            value: recipe.nutritions.calories,
                            label: "kCal",
                          ),
                          Nutrition(
                            value: recipe.nutritions.carbs,
                            label: "carbs",
                          ),
                          Nutrition(
                            value: recipe.nutritions.protiens,
                            label: "protien",
                          ),
                          Nutrition(
                            value: recipe.nutritions.fats,
                            label: "fat",
                          ),
                          Nutrition(
                            value: recipe.nutritions.weight,
                            label: "grams",
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Text(
                        "Ingredients",
                        style: mediumbutton.copyWith(color: neutral600),
                      ),
                      IngredientList(
                        ingredients: recipe.ingredients,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Preparations",
                        style: mediumbutton.copyWith(color: neutral600),
                      ),
                      const SizedBox(height: 20),
                      ...recipe.preparations.map<Widget>((step) {
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

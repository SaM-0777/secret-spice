import 'package:flutter/material.dart';
import 'package:secret_spice/core/actions/show_bottom_action_sheet.dart';
import 'package:secret_spice/core/constants/recipes/recipes.dart';
import 'package:secret_spice/core/db/models/recipe_model.dart';

import 'recipe_card.dart';


class RecipeList extends StatelessWidget {
  final int itemCount;
  final double itemExtent;
  
  const RecipeList({
    super.key, required this.itemCount, required this.itemExtent,
  });

  void showBottomActionSheet(BuildContext context, RecipeModel recipe) {
    ShowBottomActionSheet bottomActionSheet = ShowBottomActionSheet(context: context);
    bottomActionSheet.showBottomActionSheet(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
        itemCount: recipes.length,
        itemExtent: itemExtent,
        itemBuilder: (context, index) {
          return RecipeCard(
            imageUrl: recipes[index].image_url,
            title: "${recipes[index].name.substring(0, 20)}...",
            veg: recipes[index].diet == Diet.veg,
            prepTime: recipes[index].prep_time ?? "",
            cuisine: recipes[index].cuisine ?? "",
            showBottomActionSheet: () => showBottomActionSheet(context, recipes[index]),
          );
        },
      ),
    );
  }
}

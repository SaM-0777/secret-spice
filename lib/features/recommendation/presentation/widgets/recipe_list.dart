import 'package:flutter/material.dart';
import 'package:secret_spice/core/constants/recipes/recipes.dart';
import 'package:secret_spice/core/db/models/recipe_model.dart';

import 'bottom_sheet_action_sheet_modal.dart';
import 'recipe_card.dart';


class RecipeList extends StatelessWidget {
  final int itemCount;
  final double itemExtent;
  
  const RecipeList({
    super.key, required this.itemCount, required this.itemExtent,
  });

  String modifyRecipeName(String name) {
    return "H";
  }

  void showBottomActionSheet(BuildContext context, RecipeModel recipe) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BottomActionSheetModal(
          recipe: recipe,
        );
      }
    );
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

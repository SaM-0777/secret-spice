import 'package:flutter/material.dart';

import 'recipe_card.dart';


class RecipeList extends StatelessWidget {
  final int itemCount;
  final double itemExtent;
  
  const RecipeList({
    super.key, required this.itemCount, required this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
        itemCount: itemCount,
        itemExtent: itemExtent,
        itemBuilder: (context, index) {
          return const RecipeCard(
            imageUrl: "assets/images/avocadosandwich.png",
            title: "Avocado and Egg Toast",
            veg: true,
            prepTime: "35min",
            cuisine: "North Indian",
          );
        },
      ),
    );
  }
}

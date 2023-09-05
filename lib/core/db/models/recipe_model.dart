// ignore_for_file: non_constant_identifier_names

enum Diet {
  veg,
  nonVeg,
}

class Nutritions {
  final double calories;
  final double weight;
  final double protiens;
  final double carbs;
  final double fats;

  const Nutritions({
    required this.calories,
    required this.weight,
    required this.protiens,
    required this.carbs,
    required this.fats,
  });
}

class RecipeModel {
  final int id;
  final String name;
  final String image_url;
  final String description;
  final String? cuisine;
  final String? course;
  final Diet diet;
  final String? prep_time;
  final List<String> ingredients;
  final List<String> preparations;
  final Nutritions nutritions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RecipeModel({
    required this.id,
    required this.name,
    required this.image_url,
    required this.description,
    required this.diet,
    required this.ingredients,
    required this.preparations,
    required this.nutritions,
    this.cuisine,
    this.course,
    this.prep_time,
    this.createdAt,
    this.updatedAt,
  });
}

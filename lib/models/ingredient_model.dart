class IngredientModel {
  final String name;
  final String quantity;
  final String unit;

  IngredientModel({
    required this.name,
    required this.quantity,
    required this.unit,
  });
}

class RecipeStepModel {
  final int stepNumber;
  final String title;
  final String instruction;
  final String? imageUrl;
  final int? timerMinutes;

  RecipeStepModel({
    required this.stepNumber,
    required this.title,
    required this.instruction,
    this.imageUrl,
    this.timerMinutes,
  });
}

/*
part of 'recipe_cubit.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}

final class RecipeLoaded extends RecipeState{
  final List<Recipe> allRecipes;

  RecipeLoaded(this.allRecipes);
}

*/
part of 'recipe_cubit.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {
}

final class RecipeLoaded extends RecipeState{
  final List<Recipe> allRecipes;
  RecipeLoaded(this.allRecipes,);
}

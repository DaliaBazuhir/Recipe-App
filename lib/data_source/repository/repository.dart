import 'package:food_recipe_app/data_source/model/recipes_model.dart';
import 'package:food_recipe_app/data_source/webservices/recipe_webservices.dart';

class Repository{
  final RecipeWebServices recipeWebServices;
  Repository(this.recipeWebServices);

  Future<List<Recipe>>getAllRecipes()async{
    List allRecipes = await recipeWebServices.getAllRecipes();
    return allRecipes.map((recipe)=>Recipe.fromJson(recipe)).toList();
  }

}
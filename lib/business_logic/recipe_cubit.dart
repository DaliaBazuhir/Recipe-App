import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data_source/model/recipes_model.dart';
import 'package:food_recipe_app/data_source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final Repository repository;
  List<Recipe>myRecipes = [];
  //List<Recipe>favouriteRecipeList = [];
  RecipeCubit(this.repository) : super(RecipeInitial());
  List<Recipe> getAllRecipes(){
    repository.getAllRecipes().then((recipes){
      emit(RecipeLoaded(recipes,
      //    favouriteRecipeList
      ));
      this.myRecipes = recipes;
    });
    return myRecipes;
  }

}


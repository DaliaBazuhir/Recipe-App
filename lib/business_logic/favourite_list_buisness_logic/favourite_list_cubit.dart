import 'package:bloc/bloc.dart';
import 'package:food_recipe_app/data_source/model/recipes_model.dart';
import 'package:food_recipe_app/utils/app_images.dart';
import 'package:meta/meta.dart';

part 'favourite_list_state.dart';

class FavouriteListCubit extends Cubit<FavouriteListState> {
  List<Recipe> favouriteList = [];

  FavouriteListCubit() : super(FavouriteListInitial([])) {
    // Emit empty state initially if the list is empty
    _emitEmptyStateIfNeeded();
  }

  void addRecipeToFavouriteList(Recipe recipe) {
    favouriteList.add(recipe);
    emit(FavouriteListInitial(favouriteList));
  }

  void removeRecipeFromFavouriteList(Recipe recipe) {
    if (favouriteList.contains(recipe)) {
      favouriteList.remove(recipe);
      if (favouriteList.isEmpty) {
        emit(EmptyFavouriteList('Your favorite list is empty.'));
      } else {
        emit(FavouriteListInitial(favouriteList));
      }
    }
  }

  void _emitEmptyStateIfNeeded() {
    if (favouriteList.isEmpty) {
      emit(EmptyFavouriteList('Your favorite list is empty.'));
    }
  }
}

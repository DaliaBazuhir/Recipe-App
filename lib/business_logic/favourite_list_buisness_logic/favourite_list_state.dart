part of 'favourite_list_cubit.dart';

@immutable
sealed class FavouriteListState {}

final class FavouriteListInitial extends FavouriteListState {
  final List<Recipe>favouriteList;
  FavouriteListInitial(this.favouriteList);
}
final class EmptyFavouriteList extends FavouriteListState {
  String message;
  EmptyFavouriteList(this.message);
}


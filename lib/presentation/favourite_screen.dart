import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/utils/app_color.dart';
import 'package:food_recipe_app/utils/app_images.dart';

import '../business_logic/favourite_list_buisness_logic/favourite_list_cubit.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Recipes',style: TextStyle(color:  Colors.white),),
          backgroundColor: AppColor.ColorDarkBlue,
      ),
      body: BlocBuilder<FavouriteListCubit, FavouriteListState>(
        builder: (context, state) {
          if (state is FavouriteListInitial) {
            final myList = state.favouriteList;
            return ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    context.read<FavouriteListCubit>().removeRecipeFromFavouriteList(myList[index]);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(myList[index].recipeName),
                    trailing: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          myList[index].recipeImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is EmptyFavouriteList) {
            return
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
          } else {
            return Center(
              child: CircularProgressIndicator(), // Default for unexpected states
            );
          }
        },
      ),
    );
  }
}

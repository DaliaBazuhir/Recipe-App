
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/presentation/recipe_details.dart';

import '../business_logic/recipe_cubit.dart';
import '../data_source/model/recipes_model.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../utils/widgets/bottom_sheet_for_filter.dart';
import '../utils/widgets/loading_indicator.dart';
import '../utils/widgets/recipe_container.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late TextEditingController searchTextController;
  late List<Recipe> allRecipes;
  List<Recipe>searchedList = [];
  List<Recipe>filteredRecipeList = [];
  bool isSearched = false;
  bool filterRecipes = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecipeCubit>(context).getAllRecipes();
    searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.ColorLightgray,
        appBar: AppBar(
          backgroundColor: AppColor.ColorDarkBlue,
          actions: [
            isSearched ?
             IconButton(
                onPressed: (){
                  setState(() {
                    isSearched = !isSearched;
                  });
                  searchTextController.clear();
                  searchedList = [];
                },
                icon: Icon(Icons.close,color: AppColor.ColorLightgray,)
            ):
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearched = !isSearched;
                  });
                  print(isSearched);
                },
                icon: Icon(
                  Icons.search,
                  color: AppColor.ColorLightgray,
                )
            ),
            IconButton(onPressed: (){
             setState(() {
               filterRecipes = !filterRecipes;
             });
             if(filterRecipes){
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context){
                        return ShowModalBottomSheetForFilter(
                          selectedFilterIndex: -1,
                          onFilterSelected: (selectedCategory) {
                          filterItems(selectedCategory);
                          Navigator.pop(context); // Close the bottom sheet
                        },);
                      });
             }else{
               setState(() {
                 filteredRecipeList = [];
               });
             }
            }, icon: Icon(Icons.menu_rounded,color:AppColor.ColorLightgray,))
          ],
          title: isSearched ? SearchingBar() : Text('Recipes',style: TextStyle(color: Colors.white),),
        ),
        body: BlocBuilder<RecipeCubit, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoaded) {
              allRecipes = state.allRecipes;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3),
                  itemCount: searchedList.isNotEmpty?  searchedList.length: filteredRecipeList.isNotEmpty? filteredRecipeList.length :  state.allRecipes.length ,

                  //searchedList.isEmpty? state.allRecipes.length: searchedList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecipeDetails(recipe:
                          searchedList.isNotEmpty?  searchedList[index]: filteredRecipeList.isNotEmpty? filteredRecipeList[index] :  state.allRecipes[index]
                          ))),
                      child:
                              recipeContainer(searchedList.isNotEmpty?  searchedList[index]: filteredRecipeList.isNotEmpty? filteredRecipeList[index] :  state.allRecipes[index]
                              ),

                    );
                  });
            } else {
              return loadingProgressIndicator();
            }
          },
        ));
  }

  Widget SearchingBar() {
    return TextFormField(
          controller: searchTextController,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: 'Find a recipe ..',
            hintStyle: TextStyle(
              color: Colors.white
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white,)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white,)
            ),
          ),
      onChanged:(searchedCharacter){
        addSearchedForItemsToSearchedList(searchedCharacter);
      },);
  }
  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedList = allRecipes.where((recipe) => recipe.recipeName.toLowerCase().startsWith(searchedCharacter)).toList();
    setState(() {});
  }
  void filterItems(String optionName) {
    filteredRecipeList = allRecipes.where((recipe) => recipe.course == optionName).toList();
    setState(() {
    });
  }
}
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/business_logic/favourite_list_buisness_logic/favourite_list_cubit.dart';
import 'package:food_recipe_app/business_logic/recipe_cubit.dart';
import 'package:food_recipe_app/data_source/model/recipes_model.dart';
import 'package:food_recipe_app/utils/app_color.dart';

import '../utils/app_images.dart';
class RecipeDetails extends StatefulWidget {
   final Recipe recipe;
   RecipeDetails({required this.recipe});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
   late String stepsWithoutSpace;
   late List<String> splittedSteps;
 //  bool addedToFavouriteList = false;
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {

    widget.stepsWithoutSpace = widget.recipe.steps.replaceAll(". ", ".").replaceAll("!", "").replaceAll("\n", "");
    widget.splittedSteps= widget.stepsWithoutSpace.split('.').map((step) => '$step.').toList();
    return Scaffold(
      backgroundColor: AppColor.ColorLightgray,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: widget.recipe.recipeImage.isNotEmpty
                    ?   FadeInImage.assetNetwork(placeholder: AppImages.imageRecipeLoading,
                  image: widget.recipe.recipeImage,fit: BoxFit.fill,):
                SvgPicture.asset( AppImages.imageRecipePlaceHolder,fit: BoxFit.fill,),
              ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(widget.recipe.recipeName,style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20,
                               ),
                               ),
                          ),
                          IconButton(onPressed: (){
                                 setState(() {
                                   widget.recipe.inFavouriteList=!widget.recipe.inFavouriteList;
                                 });
                                 if(widget.recipe.inFavouriteList){
                                   context.read<FavouriteListCubit>().addRecipeToFavouriteList(widget.recipe);
                                 }else{
                                   context.read<FavouriteListCubit>().removeRecipeFromFavouriteList(widget.recipe);
                                 }
                          }, icon: Icon(Icons.favorite,color:widget.recipe.inFavouriteList? Colors.red:Colors.black ,))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,color: AppColor.ColorLightgray.withOpacity(0.5),),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: ListTile(
                            title: Text('Calories',style: TextStyle(color: Colors.grey,fontSize: 18),),
                            subtitle: Text("${widget.recipe.calories} Kcal",style: TextStyle(fontWeight: FontWeight.bold),),
                           )
                          ),
                          Expanded(child: ListTile(
                            title: Text('Servings',style: TextStyle(color: Colors.grey,fontSize: 18),),
                            subtitle: Text("${widget.recipe.servings} servings",style: TextStyle(fontWeight: FontWeight.bold),),
                          )
                          ),
                          Expanded(child: ListTile(
                            title: Text('Time',style: TextStyle(color: Colors.grey,fontSize: 18),),
                            subtitle: Text("${widget.recipe.totalTime} mins",style: TextStyle(fontWeight: FontWeight.bold),),
                          )
                          ),
                        ],
                      ),
                      Divider(thickness: 1,color: AppColor.ColorLightgray.withOpacity(0.5),),
                      SizedBox(height: 10,),
                      Text('Ingredients',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      ),
                      Text(widget.recipe.ingredients,maxLines: null,style: TextStyle(fontSize: 16),),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,color: AppColor.ColorLightgray.withOpacity(0.5),),
                      SizedBox(height: 10,),
                      Text('Steps',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      ),
                      stepsColumn(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget stepsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.splittedSteps.asMap().entries.map((entry) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0,top: 8),
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.sizeOf(context).height/21,
              width:  MediaQuery.sizeOf(context).height/21,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Center(child: Text(
                '${entry.key + 1}',
                style: const TextStyle(color: Colors.white,fontSize: 13),
              ),)
            ),
            Expanded(
              child: Padding(padding: EdgeInsets.only(top: 8),
              child: Text(
                entry.value.trim(),
                style: const TextStyle(fontSize: 16),
              ),)
            ),
          ],
        );
      }).toList(),
    );
  }

}

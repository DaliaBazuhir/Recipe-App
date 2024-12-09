
 import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/presentation/recipe_details.dart';
import 'package:food_recipe_app/utils/app_color.dart';

import '../../business_logic/recipe_cubit.dart';
import '../../data_source/model/recipes_model.dart';
import '../app_images.dart';

Widget recipeContainer(Recipe recipe){
  return   Padding(
    padding: const EdgeInsets.only(left: 5,right: 5),
    child: GridTile(
      child: Hero(
        tag: recipe.id,
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.ColorLightgray,
                borderRadius: BorderRadius.circular(20)
            ),
            child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: recipe.recipeImage.isNotEmpty
                      ?   FadeInImage.assetNetwork(placeholder: AppImages.imageRecipeLoading,//AppImages.imageRecipeLoading,
                    image: recipe.recipeImage,fit: BoxFit.fill,height: double.infinity,width: double.infinity,):
                  SvgPicture.asset( AppImages.imageRecipePlaceHolder,fit: BoxFit.fill,height: double.infinity,width: double.infinity,),
                ),
        ),
      ),
      footer: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
        ),
        alignment: Alignment.bottomCenter,
        child: Text(
          '${recipe.recipeName}',
          style: TextStyle(
            height: 1.3,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/business_logic/favourite_list_buisness_logic/favourite_list_cubit.dart';
import 'package:food_recipe_app/presentation/main_screen.dart';

import 'business_logic/recipe_cubit.dart';
import 'data_source/repository/repository.dart';
import 'data_source/webservices/recipe_webservices.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RecipeCubit>(
          create: (context) => RecipeCubit(Repository(RecipeWebServices())),
        ),
        BlocProvider<FavouriteListCubit>(
         create: (context) => FavouriteListCubit(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
        MainScreen(),
    );
  }
}

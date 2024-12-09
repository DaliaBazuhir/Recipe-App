import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_app/business_logic/recipe_cubit.dart';
import 'package:food_recipe_app/data_source/repository/repository.dart';
import 'package:food_recipe_app/data_source/webservices/recipe_webservices.dart';
import 'package:food_recipe_app/presentation/favourite_screen.dart';
import 'package:food_recipe_app/presentation/recipes_screen.dart';
import 'package:food_recipe_app/utils/app_color.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs = [
  RecipesScreen(),

     FavouriteScreen(),

  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.utensils,), label: 'Recipes'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
        ],
        selectedItemColor: AppColor.ColorDarkBlue,
        unselectedItemColor: AppColor.ColorLightgray,
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index != selectedIndex) {
            setState(() {
              selectedIndex = index;
            });
          }
        },
      ),
      body: tabs[selectedIndex],
    );
  }
}

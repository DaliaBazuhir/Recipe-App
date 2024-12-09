import 'package:food_recipe_app/utils/app_enums.dart';

abstract class AppConstant{
  static const constantApi = 'https://api.sampleapis.com/recipes/';
  static List<FilterOption>filterOptionsList = [
    FilterOption(filterOptionName: 'Main Course', isSelected: false),
    FilterOption(filterOptionName: 'Desserts', isSelected: false),
    FilterOption(filterOptionName: 'Lunch', isSelected: false),
    FilterOption(filterOptionName: 'Side Dishes', isSelected: false),
    FilterOption(filterOptionName: 'Breakfast', isSelected: false),
    FilterOption(filterOptionName: 'Soup', isSelected: false),
    FilterOption(filterOptionName: 'Snacks and Sandwiches', isSelected: false),
  ];
}
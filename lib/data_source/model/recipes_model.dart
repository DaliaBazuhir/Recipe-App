class Recipe{
  late int id;
  late String recipeName;
  late String course;
  late String cuisine;
  late String mainIngredient;
  late String recipeImage;
  late int totalTime;
  late String ingredients;
  late String steps;
  late dynamic calories;
  late String fat;
  late String carb;
  late String protein;
  late dynamic servings;
  late String tags;
  //
  late bool inFavouriteList;

  Recipe.fromJson(Map<String,dynamic>json){
    id = json['id'];
    recipeName = json['title'];
    course = json['course'];
    cuisine = json['cuisine'];
    mainIngredient = json['mainIngredient'];
    recipeImage = json['photoUrl'];
    totalTime = json['totalTime'];
    ingredients = json['ingredients'];
    steps = json['directions'];
    calories = json['calories'];
    fat = json['fat'];
    carb = json['carbohydrate'];
    protein = json['protein'];
    servings = json['servings'];
    tags = json['tags'];
    inFavouriteList = false;
  }

}
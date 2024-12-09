import 'package:dio/dio.dart';
import 'package:food_recipe_app/utils/app_constant.dart';

class RecipeWebServices{
  late Dio dio;
  BaseOptions options = BaseOptions(
   baseUrl: AppConstant.constantApi,
    connectTimeout: Duration(seconds: 60),
    receiveTimeout: Duration(seconds: 60),
    receiveDataWhenStatusError: true,
  );
  RecipeWebServices(){
     dio = Dio(options);
  }
  Future<List<dynamic>> getAllRecipes() async{
    try{
      Response response = await dio.get('recipes');
      return response.data;
    }catch(e){
      print(e);
      return [];
    }
  }
}
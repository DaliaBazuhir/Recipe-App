import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_color.dart';

Widget loadingProgressIndicator(){
  return Center(child: CircularProgressIndicator(color: AppColor.ColorDarkBlue,),);
}
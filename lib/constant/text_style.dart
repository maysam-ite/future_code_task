import 'package:flutter/material.dart';
import 'package:future_code_task/constant/theme.dart';
import 'package:get/get.dart';

import 'fonts.dart';

TextStyle generalTextStyle(double? size) {
  return TextStyle(
      fontFamily: jostFontFamily,
      color: Colors.black,
      fontSize: size);
}
TextStyle styleForTextFields(){
  return TextStyle(
              fontFamily: jostFontFamily,
              color: PublicColors().buttonColor,fontWeight: FontWeight.w500);
}

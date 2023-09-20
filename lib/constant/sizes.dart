// ignore_for_file: avoid_print

import 'package:flutter/material.dart';


class Sizes {
  late double normalButtonInsidePaddin;
  late double normalButtonTextSize;
late double textFieldWidth;
late double logoHeight;
late double finalHeight;
late double finalWidth;
late double logoWidth;
late double logoPaddingFromTop;
late double logoPaddingFromLeft;
  late double width;
  late double height;
  late double widthDesign;
  late double heightDesign;
  final double  buttonRadius=30;
   late double normalButtonHeight ; //height * .06 / 1.1;
    late double  normalButtonWidht ;
  late BuildContext context;
  Sizes(this.context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    heightDesign=844;
    widthDesign=390;
    finalHeight=height/heightDesign;
    finalWidth=width/widthDesign;
      setSizesForMobile();
  
  }
  void setSizesForMobile() {
    normalButtonInsidePaddin = width * .08;
     normalButtonHeight = 53*finalHeight;
    normalButtonWidht =346*finalWidth;
  logoWidth=112*finalWidth;
    logoHeight=49*finalHeight;
    logoPaddingFromTop=52*finalHeight;
    logoPaddingFromLeft=139*finalWidth;
    textFieldWidth=346*finalWidth;
    normalButtonTextSize=20;
    //need a check.
   }

}
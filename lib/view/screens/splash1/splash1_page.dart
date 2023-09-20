import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
      Future.delayed(
      const Duration(seconds: 2), // Adjust the duration as needed
      () {
        Get.offAllNamed('/Login');
      },
    );

    return Scaffold(
      body: Center(
        child:Image.asset('asset/images/splash1.png',fit: BoxFit.fill,)
      ),
    );}
  
}
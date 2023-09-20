import 'package:flutter/material.dart';
import 'package:future_code_task/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/service/pref_service.dart';


SharedPreferences? sharedPreferences;
PrefService prefService = PrefService();
// late String themeValue;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  // themeValue = await prefService.readString("theme");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test',
         initialRoute: '/',
        getPages: appRoutes());
  }
}

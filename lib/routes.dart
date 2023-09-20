import 'package:future_code_task/view/screens/addPhoto/addPhoto_binding.dart';
import 'package:future_code_task/view/screens/addPhoto/addPhoto_page.dart';
import 'package:future_code_task/view/screens/add_vehicles.dart/add_vehicles_binding.dart';
import 'package:future_code_task/view/screens/add_vehicles.dart/add_vehicles_page.dart';
import 'package:future_code_task/view/screens/logIn/logIn_binding.dart';
import 'package:future_code_task/view/screens/logIn/login_page.dart';
import 'package:future_code_task/view/screens/register/register_binding.dart';
import 'package:future_code_task/view/screens/register/register_page.dart';
import 'package:future_code_task/view/screens/show_all_vehicles/show_vehicle_binding.dart';
import 'package:future_code_task/view/screens/show_all_vehicles/show_vehicle_page.dart';
import 'package:future_code_task/view/screens/splash1/splash1_page.dart';
import 'package:future_code_task/view/screens/vehicle_information/vehicle_onformation_binding.dart';
import 'package:future_code_task/view/screens/vehicle_information/vehicle_onformation_page.dart';
import 'package:get/get.dart';

appRoutes() => [
  GetPage(
          name: '/', page: () =>const Splash1()),
     
  GetPage(
          name: '/Login', page: () => LoginPage(), binding: LoginBinding()),
     
  GetPage(
          name: '/Register', page: () => RegisterPage(), binding: RegisterBinding()),
     
  GetPage(
          name: '/AddPhoto', page: () => AddPhotoPage(), binding: AddPhotoBinding()),
     
  GetPage(
          name: '/ShowAllVehicle', page: () => ShowAllVehiclePage(), binding: ShowAllVehicleBinding()),
     
  GetPage(
          name: '/AddVehicle', page: () => AddVehiclePage(), binding: AddVehicleBinding()),
  GetPage(
          name: '/VehicleInformation', page: () => VehocleInformationPage(), binding: ShowVehicleInformationBinding()),
     
     ];

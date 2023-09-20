import 'package:get/get.dart';

import '../../../data/Models/vehicle_model.dart';

class vehicleInformationController extends GetxController{
@override
  void onInit() {
    model=Get.arguments;
    // TODO: implement onInit
    super.onInit();
  }
  late VehicleModel model;

}
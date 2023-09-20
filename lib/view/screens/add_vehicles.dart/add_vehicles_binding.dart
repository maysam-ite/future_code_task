import 'package:get/get.dart';

import 'add_vehicles_controller.dart';



class AddVehicleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddVehicleController());
  }
  
}


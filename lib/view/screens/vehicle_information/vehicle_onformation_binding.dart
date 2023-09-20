import 'package:future_code_task/view/screens/vehicle_information/vehicle_onformation_controller.dart';
import 'package:get/get.dart';



class ShowVehicleInformationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(vehicleInformationController());
  }
  
}


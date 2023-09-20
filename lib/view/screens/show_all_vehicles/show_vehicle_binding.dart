import 'package:future_code_task/view/screens/show_all_vehicles/show_vehicle_controller.dart';
import 'package:get/get.dart';



class ShowAllVehicleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ShowAllVehicleController());
  }
  
}


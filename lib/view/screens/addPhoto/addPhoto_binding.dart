import 'package:get/get.dart';

import 'addPhoto_controller.dart';



class AddPhotoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddPhotoController());
  }
  
}


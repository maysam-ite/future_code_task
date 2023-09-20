import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/status_request.dart';
import '../../../general_controller/statuse_request_controller.dart';
import '../../widget/snak_bar_for_errors.dart';
import 'addPhoto_service.dart';

class AddPhotoController extends GetxController implements  StatuseRequestController {
  String selctPhoto = '';
   @override
  StatuseRequest? statuseRequest = StatuseRequest.init;
 late Map<String,String> data;
 AddPhotoService service=AddPhotoService();
  @override
  void onInit() {
    data=Get.arguments;

    // TODO: implement onInit
    super.onInit();
  }
  late File image;
  final picker = ImagePicker();
  late Uint8List imageInBytes;
  
  Future<void> pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
         imageInBytes = await pickedImage.readAsBytes();
   
      selctPhoto=pickedImage.path;
      update();
    }
  }
  onPressDone()async {
     statuseRequest = StatuseRequest.loading;
      update();
      
     dynamic response =
          await registerData(); // check if the return data is statuseRequest or real data
      statuseRequest = handlingData(response); //return the statuseResponse
      if (statuseRequest == StatuseRequest.success) {
        whenAddSuccess(response);
      } else if (statuseRequest == StatuseRequest.authfailuer) {
        // snackBarForErrors("Auth error", "Please login again");
        Get.offAllNamed('LoginPage');
      } else if (statuseRequest == StatuseRequest.validationfailuer) {
        snackBarForErrors("Inputs wrong", "Please theck your inputs");
        Get.back();
      } else {
        snackBarForErrors("Server error", "Please try again later");
      }
    
    update();
 
  }
  registerData()async{
    print(image.path);
     Either<StatuseRequest, Map<dynamic, dynamic>> response = await service
        .register(data, imageInBytes, image.path.split('/').last);
    return response.fold((l) => l, (r) => r);
  
  }
  handlingData(response) {
    if (response is StatuseRequest) {
      return response;
    } else {
      return StatuseRequest.success;
    }
  }

  whenAddSuccess(response) async {
    Get.offAllNamed('/Login');
    update();
  }


}
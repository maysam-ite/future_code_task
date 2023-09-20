import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/status_request.dart';
import '../../../data/Models/vehicle_type_mode.dart';
import '../../../general_controller/statuse_request_controller.dart';
import '../../../main.dart';
import '../../widget/snak_bar_for_errors.dart';
import 'add_vehicles_service.dart';

class AddVehicleController extends GetxController
    implements StatuseRequestController {
  List<String> selctPhotos = [];
  StatuseRequest? statuseRequest = StatuseRequest.init;
  late GlobalKey<FormState> formstate;
  AddVehiclesService service = AddVehiclesService();
  late String boardNumber;
  late String model;
  late String color;
  late String description;
  String vehicleType = '';
  String vehicleColor = '';
  List<VehicleType> vehicleTypesModel = [];
  List<String> vehicleTypes = [];
  List<String> vehicleColors = ['', 'red', 'black'];
  @override
  void onInit() {
    getVehicleTypes();
    boardNumber = '';
    model = '';
    color = '';
    description = '';
    formstate = GlobalKey<FormState>();

    super.onInit();
  }

  getVehicleTypes() async {
    dynamic response =
        await getTypes(); // check if the return data is statuseRequest or real data
    statuseRequest = handlingData(response); //return the statuseResponse
    print(statuseRequest);
    if (statuseRequest == StatuseRequest.success) {
      whenGetTypesSuccess(response);
    } else if (statuseRequest == StatuseRequest.authfailuer) {
      snackBarForErrors("خطأ في المصادقة","رجاءا أعد تسجيل الدخول");
       Get.offAllNamed('LoginPage');
    } else if (statuseRequest == StatuseRequest.validationfailuer) {
      snackBarForErrors("خطأ في الادخال", "يرجى اعادة الادخال");
    } else {
      // snackBarForErrors("Server error", "Please try again later");
    }
  }

  whenGetTypesSuccess(response) {
    List responsedata = response['data'];
    for (int i = 0; i < responsedata.length; i++) {
      vehicleTypesModel.add(VehicleType.fromJson(responsedata[i]));
    }
    print(vehicleTypesModel.length);
    vehicleTypes.clear();
    for (var element in vehicleTypesModel) {
      vehicleTypes.add(element.name);
    }
    vehicleType = vehicleTypes[0];
    update();
  }

  getTypes() async {
    String token = await prefService.readString('token');

    Either<StatuseRequest, Map<dynamic, dynamic>> response =
        await service.getVehicleTypes(token);

    return response.fold((l) => l, (r) => r);
  }

  List<File> image = [];
  final picker = ImagePicker();
  List<Uint8List> listImageInBytes = [];
  Future<void> pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.add(File(pickedImage.path));
      selctPhotos.add(pickedImage.path);
      listImageInBytes.add(await pickedImage.readAsBytes());

      update();
    }
  }

  onPressDone() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      if(listImageInBytes.length<5||listImageInBytes.length>5){
        snackBarForErrors("number of required images not correct", "Please make sure of number");
      }
      else{
      statuseRequest = StatuseRequest.loading;
      update();

      dynamic response =
          await addData(); // check if the return data is statuseRequest or real data
      statuseRequest = handlingData(response); //return the statuseResponse
      if (statuseRequest == StatuseRequest.success) {
        whenAddSuccess(response);
      } else if (statuseRequest == StatuseRequest.authfailuer) {
        snackBarForErrors("Auth error", "Please login again");
        Get.offAllNamed('LoginPage');
      } else if (statuseRequest == StatuseRequest.missingimage) {
          snackBarForErrors("number of required images not correct", "Please make sure of number");
      } else {
        snackBarForErrors("Server error", "Please try again later");
      }
    }}
    update();
  }

  addData() async {
    String token = await prefService.readString('token');
    int vehicleTypeId = 0;
    for (var element in vehicleTypesModel) {
      if (element.name == vehicleType) {
        vehicleTypeId = element.id;
      }
    }
    Map<String, String> data = {
      'vehicle_type_id': vehicleTypeId.toString(),
      'board_number': boardNumber,
      'model': model,
      'color': vehicleColor,
    };
    List<Map<String, dynamic>> imagesData = [
      {
        "key": "vehicle_image",
        "inBytes": listImageInBytes[1],
        "imageName": image[1].path.split('/').last
      },
      {
        "key": "board_image",
        "inBytes": listImageInBytes[2],
        "imageName": image[2].path.split('/').last
      },
      {
        "key": "id_image",
        "inBytes": listImageInBytes[3],
        "imageName": image[3].path.split('/').last
      },
      {
        "key": "mechanic_image",
        "inBytes": listImageInBytes[0],
        "imageName": image[0].path.split('/').last
      },
      {
        "key": "delegate_image",
        "inBytes": listImageInBytes[4],
        "imageName": image[4].path.split('/').last
      }
    ];
    Either<StatuseRequest, Map<dynamic, dynamic>> response =
        await service.addvehicle(data, imagesData, token);
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
    Get.offAllNamed('/ShowAllVehicle');
    // update();
  }
}

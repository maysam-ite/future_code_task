import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/status_request.dart';
import '../../../general_controller/statuse_request_controller.dart';
import '../../../main.dart';
import '../../widget/snak_bar_for_errors.dart';
import 'login_service.dart';

class LoginController extends GetxController     implements StatuseRequestController{
  late String password;
  late String phone;
   @override
  StatuseRequest? statuseRequest = StatuseRequest.init;
  late RxBool passwordSecure = true.obs;
  LoginService service = LoginService();
  late GlobalKey<FormState> formstate;

  @override
  void onInit() {
    password = '';
    phone = '';
    formstate = GlobalKey<FormState>();
    
    // TODO: implement onInit
    super.onInit();
  }
  
  void changePasswordSecure() {
    passwordSecure.value = !passwordSecure.value;
  }

  void onpresslogin() async {

    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      statuseRequest = StatuseRequest.loading;
      update();
      dynamic response =
          await logindata(); // check if the return data is statuseRequest or real data
      statuseRequest = handlingData(response); //return the statuseResponse
      if (statuseRequest == StatuseRequest.success) {
        whenLoginSuccess(response);
      } else if (statuseRequest == StatuseRequest.authfailuer) {
        snackBarForErrors("خطأ في المصادقة","رجاءا أعد تسجيل الدخول");
       } else if (statuseRequest == StatuseRequest.validationfailuer) {
        snackBarForErrors("Input error","Please Try again");
       } else {
        // snackBarForErrors();
      }
    }
    update();
  }


  logindata() async {
    Map<String, String> data = {
      "phone_number": phone,
      "password": password
    };
    Either<StatuseRequest, Map<dynamic, dynamic>> response =
        await service.login(data);

    return response.fold((l) => l, (r) => r);
  }

  handlingData(response) {
    if (response is StatuseRequest) {
      return response;
    } else {
      return StatuseRequest.success;
    }
  }

  whenLoginSuccess(response) async {
    print(response['data']['token']);
    await prefService.createString('token', response['data']['token']); // storing token
    update();
     Get.offAllNamed('/ShowAllVehicle');
  }

}
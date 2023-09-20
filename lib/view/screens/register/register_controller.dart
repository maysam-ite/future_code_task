import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/status_request.dart';
import '../../../general_controller/statuse_request_controller.dart';

class RegisterController extends GetxController
    implements StatuseRequestController {
  late String password;
  late String name;

  late String confirmPassword;
  late String phoneNumber;
  @override
  StatuseRequest? statuseRequest = StatuseRequest.init;
  late RxBool passwordSecure = true.obs;
  late RxBool confirmPasswordSecure = true.obs;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  void onInit() async {
    confirmPassword = '';
    name = '';
    password = '';
    phoneNumber = '';
    // statuseRequest = await checkIfTheInternetIsConectedBeforGoingToThePage();
    super.onInit();
  }

  void changePasswordSecure() {
    passwordSecure.value = !passwordSecure.value;
  }

  void changeConfirmPasswordSecure() {
    confirmPasswordSecure.value = !confirmPasswordSecure.value;
  }

  void onPressRegister() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      Map<String, String> data = {
        "password": password,
        "phone_number": phoneNumber,
        "password_confirmation": confirmPassword,
        "fullname": name
      };
      Get.toNamed('/AddPhoto', arguments: data);

     
    }
  }
}

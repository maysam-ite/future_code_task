import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../constant/sizes.dart';
import '../../../constant/status_request.dart';
import '../../../constant/text_style.dart';
import '../../../constant/theme.dart';
import '../../widget/costum_text_field.dart';
import '../../widget/my_button.dart';
import '../../widget/no_internet_page.dart';
import 'login_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  // GetDeviceType getDeviceType = GetDeviceType();
  LoginController controller = Get.find();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodyAllStatuse(context));
  }

  Widget bodyAllStatuse(BuildContext context) {
    Sizes size = Sizes(context);

    return GetBuilder<LoginController>(
      builder: (controller) {
        if (controller.statuseRequest == StatuseRequest.offlinefailure) {
          return noInternetPage(size, controller);
        } else {
          return bodyWithLoginElements(size, context);
        }
      },
    );
  }

  Widget bodyWithLoginElements(Sizes size, BuildContext context) {
    return Form(
      key: controller.formstate,
      child: theLoginColumnBody(size),
    );
  }

  Widget passwordTextFeild(Sizes size) {
    return Obx(
      () {
        return CostumTextField(
          labelStyle: TextStyle(
              color: PublicColors().textInsideButtonColor),
          widthOnTheScreen: size.textFieldWidth,
          onsaved: (value) {
            controller.password = value!;
          },
          hint: 'كلمة السر'.tr,
          hintStyle: TextStyle(
              fontFamily: jostFontFamily,
              color: PublicColors().buttonColor,fontWeight: FontWeight.w500),
          prefixIcon: IconButton(
            onPressed: () {
              controller.changePasswordSecure();
            },
            icon: controller.passwordSecure.value
                ? Icon(Icons.visibility_off, color: PublicColors().labelColor,size: 20)
                : Icon(Icons.visibility, color: PublicColors().labelColor,size: 20),
          ),
          suffixIcon: Icon(Icons.lock, color: PublicColors().iconColor,size:15),
          sucer: controller.passwordSecure.value,
          validat: (value) {
            if (value!.length < 4) {
              return "the password can't be smaller than 4 character ".tr;
            }
            return null;
          },
        );
      },
    );
  }

  Widget emailTextFeild(Sizes size) {
    return CostumTextField(
      labelStyle: TextStyle(color: PublicColors().textInsideButtonColor),
      widthOnTheScreen: size.textFieldWidth,
      onsaved: (value) {
        controller.phone = value!;
      },
      hint: 'رقم الهاتف'.tr,
      hintStyle:
          TextStyle(fontFamily: jostFontFamily, color: PublicColors().buttonColor,fontWeight: FontWeight.w500),
      suffixIcon: Icon(
        Icons.phone,
        color: PublicColors().iconColor,
        size: 15,
      ),
      sucer: false,
      validat: (value) {
        if (value!.length>10||value.length<10) {
          return (("The phone number should be 10 digit").tr);

          ///add for translate
        }
        return null;
      },
    );
  }

  MyButton theDoneButton(Sizes size) {
    return MyButton(
      mycolor: PublicColors().buttonColor ,
      myRadius: size.buttonRadius,
      ontap: () {
        controller.onpresslogin();
        },
      mywidth: size.normalButtonWidht,
      myheight: size.normalButtonHeight,
      myShadow: 0,
      child: controller.statuseRequest == StatuseRequest.loading
          ? Container(
              padding: const EdgeInsets.all(2),
              child: CircularProgressIndicator(
                color: PublicColors().textInsideButtonColor,
              ),
            )
          : AutoSizeText(
              'تسجيل الدخول'.tr,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: size.normalButtonTextSize,
                  fontFamily: jostFontFamily,
                  color: PublicColors().textInsideButtonColor),
            ),
    );
  }
  Widget moveToRegister(Sizes size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
        AutoSizeText(
          "ليس لديك حساب؟".tr,
          style: generalTextStyle(15),
        ),
        GestureDetector(
          child: AutoSizeText(
            "إنشاء حساب".tr,
            style: TextStyle(
               decoration: TextDecoration.underline,
               
                color:PublicColors().iconColor,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          onTap: () {
            Get.offNamed('/Register');
      },
        ),
      ],
    );
  }


  ListView theLoginColumnBody(Sizes size) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.finalWidth * 25),
      children: [
        SizedBox(
          height: size.logoPaddingFromTop,
        ),
        Image.asset(
        
          'asset/images/logo.png',
          height: size.logoHeight,
          width: size.logoWidth,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: size.finalHeight * 82,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            'تسجيل الدخول',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 61 * size.finalHeight),

        emailTextFeild(size),
        SizedBox(height: 40 * size.finalHeight),
        passwordTextFeild(size),
         SizedBox(
          height: size.finalHeight * 13,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'هل نسيت كلمة السر؟',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 77 * size.finalHeight),

        theDoneButton(size),
        SizedBox(
          height: size.finalHeight*30,
        ),
        moveToRegister(size)

      ],
    );
  }
}

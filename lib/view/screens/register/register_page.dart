import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/fonts.dart';
import '../../../constant/sizes.dart';
import '../../../constant/status_request.dart';
import '../../../constant/text_style.dart';
import '../../../constant/theme.dart';
import '../../widget/costum_text_field.dart';
import '../../widget/my_button.dart';
import 'register_controller.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterController controller = Get.find();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodyAllStatuse(context));
  }

  Widget bodyAllStatuse(BuildContext context) {
    Sizes size = Sizes(context);

    return GetBuilder<RegisterController>(builder: (controller) {
      return bodyWithLoginElements(size, context);
    });
  }

  Widget bodyWithLoginElements(Sizes size, BuildContext context) {
    return Form(
      key: controller.formstate,
      child: theRegisterColumnBody(size),
    );
  }

  Widget passwordTextFeild(Sizes size) {
    return Obx(
      () {
        return CostumTextField(
          labelStyle: TextStyle(color: PublicColors().textInsideButtonColor),
          widthOnTheScreen: size.textFieldWidth,
          onsaved: (value) {
            controller.password = value!;
          },
          hint: 'كلمة السر'.tr,
          hintStyle: TextStyle(
              fontFamily: jostFontFamily,
              color: PublicColors().buttonColor,
              fontWeight: FontWeight.w500),
          prefixIcon: IconButton(
            onPressed: () {
              controller.changePasswordSecure();
            },
            icon: controller.passwordSecure.value
                ? Icon(Icons.visibility_off,
                    color: PublicColors().labelColor, size: 20)
                : Icon(Icons.visibility,
                    color: PublicColors().labelColor, size: 20),
          ),
          suffixIcon:
              Icon(Icons.lock, color: PublicColors().iconColor, size: 15),
          sucer: controller.passwordSecure.value,
          validat: (value) {
            if (value!.length < 8) {
              return "the password can't be smaller than 4 character ".tr;
            }
            return null;
          },
        );
      },
    );
  }

  Widget confirmPasswordTextFeild(Sizes size) {
    return Obx(
      () {
        return CostumTextField(
          labelStyle: TextStyle(color: PublicColors().textInsideButtonColor),
          widthOnTheScreen: size.textFieldWidth,
          onsaved: (value) {
            controller.confirmPassword = value!;
          },
          hint: 'تأكيد كلمة السر',
          hintStyle: TextStyle(
              fontFamily: jostFontFamily,
              color: PublicColors().buttonColor,
              fontWeight: FontWeight.w500),
          prefixIcon: IconButton(
            onPressed: () {
              controller.changeConfirmPasswordSecure();
            },
            icon: controller.confirmPasswordSecure.value
                ? Icon(Icons.visibility_off,
                    color: PublicColors().labelColor, size: 20)
                : Icon(Icons.visibility,
                    color: PublicColors().labelColor, size: 20),
          ),
          suffixIcon:
              Icon(Icons.lock, color: PublicColors().iconColor, size: 15),
          sucer: controller.confirmPasswordSecure.value,
          validat: (value) {
            if (controller.confirmPassword != controller.password) {
              return "the password isn't matching with previous one ".tr;
            }
            return null;
          },
        );
      },
    );
  }

  Widget name(Sizes size) {
    return CostumTextField(
      labelStyle: TextStyle(color: PublicColors().textInsideButtonColor),
      widthOnTheScreen: size.textFieldWidth,
      onsaved: (value) {
        controller.name = value!;
      },
      hint: 'الاسم',
      hintStyle: TextStyle(
          fontFamily: jostFontFamily,
          color: PublicColors().buttonColor,
          fontWeight: FontWeight.w500),
      suffixIcon: Icon(Icons.person, color: PublicColors().iconColor, size: 15),
      sucer: false,
      validat: (value) {
        if (value!.length < 2) {
          return "your name is shourtest than should be"
              .tr; ////add to translate
        }
        return null;
      },
    );
  }

  Widget phone(Sizes size) {
    return CostumTextField(
      labelStyle: TextStyle(color: PublicColors().textInsideButtonColor),
      widthOnTheScreen: size.textFieldWidth,
      onsaved: (value) {
        controller.phoneNumber = value!;
      },
      hint: 'رقم الهاتف',
      hintStyle: TextStyle(
          fontFamily: jostFontFamily,
          color: PublicColors().buttonColor,
          fontWeight: FontWeight.w500),
      suffixIcon: Icon(Icons.phone, color: PublicColors().iconColor, size: 15),
      sucer: false,
      validat: (value) {
        if (value!.length < 10 || value.length > 10) {
          return (("your phone number should be 10 digits"));

          ///add for translate
        }
        return null;
      },
    );
  }

  MyButton theDoneButton(Sizes size) {
    return MyButton(
      mycolor: PublicColors().buttonColor,
      myRadius: size.buttonRadius,
      ontap: () {
        print("object");
        controller.onPressRegister();
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
              'التالي',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: size.normalButtonTextSize,
                  fontFamily: jostFontFamily,
                  color: PublicColors().textInsideButtonColor),
            ),
    );
  }

  Widget moveToLogin(Sizes size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
          AutoSizeText(
            "لديك حساب؟",
            style: generalTextStyle(15),
          ),
          GestureDetector(
            child: AutoSizeText(
              "تسحيل الدخول".tr,
              style: TextStyle(
                  color: PublicColors().iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            onTap: () {
              // Get.offAllnamed('/LoginPage');
            },
          ),
        ],
      ),
    );
  }
  Widget rulesText(Sizes size){
    return const Text("متابعتك تعني موافقتك على الشروط والأحكام وسياسة الخصوصية");
  }
  Widget theRegisterColumnBody(Sizes size) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.finalWidth * 25),
      children: [
         SizedBox(
          height: size.finalHeight*30,
        ),
       
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: size.finalHeight*40,
              width: size.finalWidth*40,
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.13),
                    blurRadius: 20,
                    spreadRadius: 0)
              ],
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: PublicColors().buttonColor,
                  )),
            ),
          ],
        ),
       
        Image.asset(
          'asset/images/logo.png',
          height: size.logoHeight,
          width: size.logoWidth,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: size.finalHeight * 62,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            'إنشاء حساب',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 33 * size.finalHeight),
        name(size),
        SizedBox(height: 40 * size.finalHeight),
        phone(size),
        SizedBox(height: 40 * size.finalHeight),
        passwordTextFeild(size),
        SizedBox(height: 40 * size.finalHeight),
        confirmPasswordTextFeild(size),
        SizedBox(height: 41 * size.finalHeight),
        theDoneButton(size),
        SizedBox(
          height: size.finalHeight * 66,
        ),
        moveToLogin(size),
         SizedBox(
          height: size.finalHeight * 75,
        ),
        rulesText(size)
      
      ],
    );


  }
}

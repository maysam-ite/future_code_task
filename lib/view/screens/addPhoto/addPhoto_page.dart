import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/fonts.dart';
import '../../../constant/sizes.dart';
import '../../../constant/status_request.dart';
import '../../../constant/theme.dart';
import '../../widget/my_button.dart';
import 'addPhoto_controller.dart';

// ignore: must_be_immutable
class AddPhotoPage extends StatelessWidget {
  AddPhotoPage({super.key});
  AddPhotoController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Sizes size = Sizes(context);
    return Scaffold(
        body: GetBuilder<AddPhotoController>(
      builder: (ctx) => bodyWithElement(size),
    ));
  }

  Widget bodyWithElement(Sizes size) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.finalWidth * 40),
      children: [
        SizedBox(
          height: size.finalHeight * 52,
        ),
        Image.asset(
          'asset/images/logo.png',
          height: size.logoHeight,
          width: size.logoWidth,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: size.finalHeight * 85,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            'أضف صورتك الشخصية',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: size.finalHeight * 11,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            'اجعل صورتك واضحة',
            style: TextStyle(fontSize: 15),
          ),
        ),
        SizedBox(
          height: size.finalHeight * 89,
        ),
        photoPlace(size),
        SizedBox(
          height: size.finalHeight * 180,
        ),
        theDoneButton(size),
      ],
    );
  }

  MyButton theDoneButton(Sizes size) {
    return MyButton(
      mycolor: PublicColors().buttonColor,
      myRadius: size.buttonRadius,
      ontap: () {
        controller.onPressDone();
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
              'إنشاء الحساب',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: size.normalButtonTextSize,
                  fontFamily: jostFontFamily,
                  color: PublicColors().textInsideButtonColor),
            ),
    );
  }

  photoPlace(Sizes size) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: size.finalWidth * 241,
        height: size.finalHeight * 241,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 22,
                spreadRadius: 0)
          ],
        ),
        child: ClipOval(
          child: SizedBox(
            width: size.finalWidth * 241,
            height: size.finalHeight * 241,
            child: controller.selctPhoto != ''
                ? Image.file(
                    controller.image,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.person,
                    size: 60,
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  ),
          ),
        ),
      ),
      Positioned(
        right: size.finalWidth * 30,
        bottom: size.finalHeight * 4,
        child: GestureDetector(
          onTap: () {
            controller.pickImage();
          },
          child: Container(
            width: size.finalWidth * 50,
            height: size.finalHeight * 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PublicColors().iconColor,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      )
    ]);
  }
}

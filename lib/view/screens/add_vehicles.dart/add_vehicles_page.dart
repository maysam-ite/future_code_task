import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../constant/fonts.dart';
import '../../../constant/sizes.dart';
import '../../../constant/status_request.dart';
import '../../../constant/theme.dart';
import '../../widget/costum_text_field.dart';
import '../../widget/my_button.dart';
import 'add_vehicles_controller.dart';

// ignore: must_be_immutable
class AddVehiclePage extends StatelessWidget {
  AddVehiclePage({super.key});
  AddVehicleController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Sizes size = Sizes(context);
    return Scaffold(
      body: GetBuilder<AddVehicleController>(builder: (context) {
        return Form(
          key: controller.formstate,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: size.finalWidth * 20),
            children: [
              SizedBox(
                height: size.finalHeight * 37,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'مركباتي',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: size.finalWidth * 123,
                  ),
                  Container(
                    height: size.finalHeight * 40,
                    width: size.finalWidth * 40,
                    alignment: Alignment.centerRight,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.13),
                            blurRadius: 20,
                            spreadRadius: 0)
                      ],
                    ),
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: PublicColors().buttonColor,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: size.finalHeight * 61,
              ),
              vehicleType(size),
              SizedBox(
                height: size.finalHeight * 20,
              ),
              vehicleModel(size),
              SizedBox(
                height: size.finalHeight * 20,
              ),
              vehicleColor(size),
              SizedBox(
                height: size.finalHeight * 20,
              ),
              vehicleNumber(size),
              SizedBox(
                height: size.finalHeight * 30,
              ),
              Text(
                "صور المركبة",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 15, color: PublicColors().buttonColor),
              ),
              Text(
                " صورة الميكانيك",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
              ),
              Text(
                "2-صورة المركبة ",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
              ),
              Text(
                "3- صورة اللوحة",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
              ),
              Text(
                "4- الهوية الشخصية",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
              ),
              Text(
                "5-الوكالة أو التفويض",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
              ),
              SizedBox(
                height: size.finalHeight * 13,
              ),
              SizedBox(
                height: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.finalWidth * 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.image.length,
                        itemBuilder: (xtc, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.finalWidth * 8),
                          child: Image.file(
                            controller.image[index],
                            width: size.finalWidth * 157,
                            height: size.finalHeight * 157,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.finalWidth * 8,
                    ),
                    addPhoto(size),
                  ],
                ),
              ),
              SizedBox(
                width: size.finalWidth * 23,
              ),
              theDoneButton(size),
              SizedBox(
                width: size.finalWidth * 23,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget addPhoto(Sizes size) {
    return GestureDetector(
      onTap: () {
        controller.pickImage();
      },
      child: Container(
        width: size.finalWidth * 100,
        height: size.finalHeight * 157,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.13),
              blurRadius: 20,
              spreadRadius: 0)
        ]),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            width: size.finalWidth * 40,
            height: size.finalHeight * 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.add,
              color: PublicColors().iconColor,
              size: 30,
            ),
          ),
          Text("إضافة صورة")
        ]),
      ),
    );
  }

  List<Widget> photo(Sizes size) {
    List<Widget> j = [];
    j.add(addPhoto(size));
    List.generate(controller.selctPhotos.length,
        (index) => Image.file(controller.image[index]));
    return j;
  }

  Widget vehicleType(Sizes size) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: size.finalWidth*15,),
      
          Icon(Icons.type_specimen_outlined,
              color: PublicColors().iconColor, size: 15),
          SizedBox(width: size.finalWidth * 12), // Spacer
          Text(
            'نوع المركبة',
            style: TextStyle(
                fontFamily: jostFontFamily,
                color: PublicColors().buttonColor,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          DropdownButton<String>(
            value: controller.vehicleType,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            onChanged: (String? newValue) {
              controller.vehicleType = newValue!;
              controller.update();
            },
            items: controller.vehicleTypes
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      SizedBox(height: size.finalHeight * 5), // Spacer
      // Spacer

      // Divider
      Divider(
        thickness: 1.0, // Customize divider thickness as needed
        color: PublicColors().labelColor, // Customize divider color as needed
      ),
    ]);
  }
  /*

  
   */

  Widget vehicleNumber(Sizes size) {
    return CostumTextField(
      labelStyle: TextStyle(color: PublicColors().textInsideButtonColor),
      widthOnTheScreen: size.textFieldWidth,
      onsaved: (value) {
         controller.boardNumber = value!;
      },
      hint: ' : رقم اللوحة',
      hintStyle: TextStyle(
          fontFamily: jostFontFamily,
          color: PublicColors().buttonColor,
          fontWeight: FontWeight.w500),
      suffixIcon:
          Icon(Icons.numbers, color: PublicColors().iconColor, size: 15),
      sucer: false,
      validat: (value) {
        if (value!.length < 2) {
          return "your name is shourtest than should be"; ////add to translate
        }
        return null;
      },
    );
  }

  Widget vehicleColor(Sizes size) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        textDirection: TextDirection.rtl,
        children: [
      SizedBox(width: size.finalWidth*15,),
          Icon(Icons.format_color_fill_sharp,
              color: PublicColors().iconColor, size: 15),
          SizedBox(width: size.finalWidth * 12), // Spacer
          Text(
            'لون المركبة',
            style: TextStyle(
                fontFamily: jostFontFamily,
                color: PublicColors().buttonColor,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          DropdownButton<String>(
            value: controller.vehicleColor,
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            onChanged: (String? newValue) {
              controller.vehicleColor = newValue!;
              controller.update();
            },
            items: controller.vehicleColors
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      SizedBox(height: size.finalHeight * 5), // Spacer
      // Spacer

      // Divider
      Divider(
        thickness: 1.0, // Customize divider thickness as needed
        color: PublicColors().labelColor, // Customize divider color as needed
      ),
    ]);
  }

  Widget vehicleModel(Sizes size) {
    return CostumTextField(
      labelStyle: TextStyle(color: PublicColors().textInsideButtonColor),
      widthOnTheScreen: size.textFieldWidth,
      onsaved: (value) {
         controller.model = value!;
      },
      hint: ' الموديل',
      hintStyle: TextStyle(
          fontFamily: jostFontFamily,
          color: PublicColors().buttonColor,
          fontWeight: FontWeight.w500),
      suffixIcon:
          Icon(Icons.moped_outlined, color: PublicColors().iconColor, size: 15),
      sucer: false,
      validat: (value) {
        if (value!.length < 2) {
          return "your name is shourtest than should be"; ////add to translate
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
              'إضافة المركبة',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: size.normalButtonTextSize,
                  fontFamily: jostFontFamily,
                  color: PublicColors().textInsideButtonColor),
            ),
    );
  }
}

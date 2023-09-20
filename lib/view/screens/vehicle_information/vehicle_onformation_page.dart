import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:future_code_task/constant/sizes.dart';
import 'package:future_code_task/view/screens/show_all_vehicles/show_vehicle_controller.dart';
import 'package:future_code_task/view/screens/vehicle_information/vehicle_onformation_controller.dart';
import 'package:get/get.dart';

import '../../../constant/fonts.dart';
import '../../../constant/server_const.dart';
import '../../../constant/theme.dart';
import '../../widget/my_button.dart';

// ignore: must_be_immutable
class VehocleInformationPage extends StatelessWidget {
  VehocleInformationPage({super.key});
  vehicleInformationController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Sizes size = Sizes(context);
    return Scaffold(
      body: ListView(
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
            height: size.finalHeight * 62,
          ),
          vehicleType(size, 'نوع المركبة', controller.model.type.name,
              Icons.car_rental),
          SizedBox(
            height: size.finalHeight * 20,
          ),
          vehicleType(
              size, 'الموديل', controller.model.model, Icons.moped_outlined),
          SizedBox(
            height: size.finalHeight * 20,
          ),
          vehicleType(
              size, 'لون المركبة', controller.model.color, Icons.color_lens),
          SizedBox(
            height: size.finalHeight * 20,
          ),
          vehicleType(size, 'رقم اللوحة',
              controller.model.boardNumber.toString(), Icons.numbers),
          SizedBox(
            height: size.finalHeight * 20,
          ),
          vehicleType(size, 'سعر الكيلو', '30', Icons.price_change),
          SizedBox(
            height: size.finalHeight * 20,
          ),
          vehicleType(size, 'نسبة ربح الشركة', '30', Icons.percent),
          SizedBox(
            height: size.finalHeight * 30,
          ),
          Text(
            "صور المركبة ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 15, color: PublicColors().buttonColor),
          ),
          Text(
            " صورة الميكانيك",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
          ),
          Text(
            "صورة المركبة ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
          ),
          Text(
            "صورة اللوحة",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
          ),
          Text(
            "الهوية الشخصية",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
          ),
          Text(
            "الوكالة أو التفويض",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: PublicColors().labelColor),
          ),
          SizedBox(
            height: size.finalHeight * 13,
          ),
          // allPhotos(size),
          theDoneButton(size)
        ],
      ),
    );
  }
MyButton theDoneButton(Sizes size) {
    return MyButton(
      mycolor: PublicColors().buttonColor,
      myRadius: size.buttonRadius,
      ontap: () {
        controller.model.isSelected=true;
        Get.back();
        ShowAllVehicleController().update();
      },
      mywidth: size.normalButtonWidht,
      myheight: size.normalButtonHeight,
      myShadow: 0,
      child:  AutoSizeText(
              'إختيار المركبة',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: size.normalButtonTextSize,
                  fontFamily: jostFontFamily,
                  color: PublicColors().textInsideButtonColor),
            ),
    );
  }
  Widget allPhotos(Sizes size) {
    List<Image> allphoto = [];
    allphoto.add(Image.network(
        "${ServerConstApis.baseAPI}/${controller.model.mechanicImage}",
        fit: BoxFit.cover));
    allphoto.add(Image.network(
        "${ServerConstApis.baseAPI}/${controller.model.vehicleImage}",
        fit: BoxFit.cover));
    allphoto.add(Image.network(
        "${ServerConstApis.baseAPI}/${controller.model.boardImage}",
        fit: BoxFit.cover));
    allphoto.add(Image.network(
        "${ServerConstApis.baseAPI}/${controller.model.idImage}",
        fit: BoxFit.cover));
    allphoto.add(Image.network(
        "${ServerConstApis.baseAPI}/${controller.model.delegateImage}",
        fit: BoxFit.cover));

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: allphoto.length,
      itemBuilder: (xtc, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: size.finalWidth * 8),
          child: allphoto[index]),
    );
  }

  Widget vehicleType(
      Sizes size, String firstText, String secondText, IconData icon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            width: size.finalWidth * 15,
          ),

          Icon(icon, color: PublicColors().iconColor, size: 15),
          SizedBox(width: size.finalWidth * 12), // Spacer
          Text(
            firstText,
            style: TextStyle(
                fontFamily: jostFontFamily,
                color: PublicColors().buttonColor,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            secondText,
            style: TextStyle(
                fontFamily: jostFontFamily,
                color: PublicColors().iconColor,
                fontWeight: FontWeight.w500),
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
}

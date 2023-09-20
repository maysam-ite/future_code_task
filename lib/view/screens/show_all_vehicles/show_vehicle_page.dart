import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:future_code_task/constant/theme.dart';
import 'package:future_code_task/view/screens/show_all_vehicles/show_vehicle_controller.dart';
import 'package:get/get.dart';

import '../../../constant/fonts.dart';
import '../../../constant/sizes.dart';
import '../../../constant/status_request.dart';
import '../../widget/my_button.dart';
import '../../widget/my_vehicle_card.dart';

class ShowAllVehiclePage extends StatelessWidget {
  ShowAllVehiclePage({super.key});
  final ShowAllVehicleController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final Sizes size = Sizes(context);
    return GetBuilder<ShowAllVehicleController>(builder: (ccontext) {
      return Scaffold(
          body: controller.statuseRequest==StatuseRequest.loading?Center(
            child: CircularProgressIndicator(
              color: PublicColors().labelColor,
            ),
          ):
           ListView(
            padding: EdgeInsets.symmetric(horizontal: size.finalWidth*20),
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: PublicColors().buttonColor,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: size.finalHeight * 662,
            child: controller.finalListData.isEmpty
                ? const Center(
                    child: Text("لم يتم اضافة مركبات بعد"),
                  )
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.finalWidth * 60),
                    itemCount: controller.finalListData.length,
                    itemBuilder: (context, index) {
                      return MyVehicleCard(
                          model: controller.finalListData[index]);
                    },
                  ),
          ),
          theDoneButton(size)
        ],
      ));
    });
  }

  MyButton theDoneButton(Sizes size) {
    return MyButton(
      mycolor: PublicColors().buttonColor,
      myRadius: size.buttonRadius,
      ontap: () {
        print("object");
        // controller.onpresslogin();
        Get.toNamed('/AddVehicle');
      },
      mywidth: size.normalButtonWidht,
      myheight: size.normalButtonHeight,
      myShadow: 0,
      child:  AutoSizeText(
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

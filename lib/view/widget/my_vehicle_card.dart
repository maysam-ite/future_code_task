import 'package:flutter/material.dart';
import 'package:future_code_task/constant/server_const.dart';
import 'package:future_code_task/constant/theme.dart';

import '../../constant/sizes.dart';
import '../../data/Models/vehicle_model.dart';

// ignore: must_be_immutable
class MyVehicleCard extends StatelessWidget {
  MyVehicleCard({super.key, required this.model});
  VehicleModel model;
  @override
  Widget build(BuildContext context) {
    Sizes size = Sizes(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.finalWidth * 14, vertical: size.finalHeight * 20),
      width: size.finalWidth * 243,
      height: size.finalHeight * 193,
      margin: EdgeInsets.symmetric(vertical: size.finalHeight * 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: PublicColors().iconColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: SizedBox(
                  width: size.finalWidth * 64,
                  height: size.finalHeight * 64,
                  child: model.vehicleImage == ''
                      ? Image.asset(
                          'asset/images/logo.png',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "${ServerConstApis.baseAPI}/${model.vehicleImage}",
                          fit: BoxFit.cover),
                ),
              ),
              Text(
                model.type.name,
                style: TextStyle(fontSize: 13, color: PublicColors().iconColor),
              )
            ],
          ),
          SizedBox(
            height: size.finalHeight * 11,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                ': سعر الكيلو',
                style: TextStyle(fontSize: 13, color: PublicColors().iconColor),
              ),
              Text(
                "/ 1كم. 20ل س",
                style: TextStyle(fontSize: 13, color: PublicColors().iconColor),
              )
            ],
          ),
          SizedBox(
            height: size.finalHeight * 11,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                ': نسبة الشركة',
                style: TextStyle(fontSize: 13, color: PublicColors().iconColor),
              ),
              Text(
                "1 كم/30ل.س",
                style: TextStyle(fontSize: 13, color: PublicColors().iconColor),
              )
            ],
          )
        ],
      ),
    );
  }
}

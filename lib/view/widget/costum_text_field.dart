import 'package:flutter/material.dart';

import '../../constant/fonts.dart';
import '../../constant/theme.dart';

// ignore: must_be_immutable
class CostumTextField extends StatelessWidget {
  String hint;
  late TextStyle? hintStyle;
  late TextStyle? labelStyle;
  String? label;
  Widget? iconsuffex;
  TextInputType? inputtype;
  Function(String?)? onsaved;
  Function()? onTap;
  String? Function(String?)? validat;
  TextEditingController? controller;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? sucer;
  double? reduis;
  late double widthOnTheScreen;
  String? inialValue;
  CostumTextField(
      {Key? key,
      this.labelStyle,
      this.inialValue,
      this.suffixIcon,
      this.sucer,
      this.prefixIcon,
      required this.hint,
      this.label,
      this.iconsuffex,
      this.inputtype,
      this.onsaved,
      this.onTap,
      this.controller,
      this.hintStyle,
      this.reduis,
      required this.widthOnTheScreen,
      this.validat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthOnTheScreen,
      child: TextFormField(
        textAlign: TextAlign.right,
        initialValue: inialValue,
        style: TextStyle(
            fontFamily: jostFontFamily),
        obscureText: sucer ?? true,
        validator: validat,
        controller: controller,
        onSaved: onsaved,
        onTap: onTap,
        keyboardType: inputtype,
        decoration: InputDecoration(
          contentPadding:const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
            hintText: hint,
            hintMaxLines: 1,
            hintStyle: hintStyle,
            helperMaxLines: 1,
            errorMaxLines: 1,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: PublicColors().labelColor),
                    ),
            label: label != null
                ? Text(
                    label!,
                    style: labelStyle,
                  )
                : null,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixIconColor:PublicColors(). textInsideButtonColor,
            suffixIconColor:PublicColors(). textInsideButtonColor,
            
        
            focusedBorder:const UnderlineInputBorder(
              borderSide: BorderSide(
                  color:Colors.grey),
              // borderRadius: BorderRadius.circular(
              //     reduis == null ? 5 : reduis as double),
            ),
            ),
      ),
    );
  }
}

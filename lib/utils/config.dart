import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  // init height and width
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  static const String api =
      "https://229e-2407-0-3002-5326-b832-4eaf-8b7c-139a.ngrok-free.app/";

  // define spacing
  static const spaceSmall = SizedBox(
    height: 25,
  );
  static final spaceMedium = SizedBox(height: screenHeight! * 0.05);
  static final spaceBig = SizedBox(height: screenHeight! * 0.08);

  // textform field border
  static const outlinedBorder =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)));

  static const focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(9)),
      borderSide: BorderSide(color: Colors.greenAccent));

  static const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(9)),
      borderSide: BorderSide(color: Colors.red));

  static const primaryColor = Colors.grey;
}

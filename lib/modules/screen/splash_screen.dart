import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/modules/controller/splash_screen_controller.dart';
import 'package:vroar/resources/colors.dart';

import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';

class SplashScreen extends ParentWidget {
  const SplashScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    Get.put(SplashScreenController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: ClipOval(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.white, // Optional background color
                child: Image.asset(
                  appImages.myTrekLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: h * 0.07,
            left: w * 0.41,
            child: Center(
              child: Text(
                appStrings.myTreks,
                textAlign: TextAlign.center,
                style: TextStyle(color: appColors.contentAccent, fontSize: 24, fontFamily: appFonts.NunitoBold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

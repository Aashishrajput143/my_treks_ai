import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/colors.dart';

import '../../common/common_widgets.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';

class SuccessPasswordScreen extends ParentWidget {
  const SuccessPasswordScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70), // Top spacing
            Text(
              appStrings.passwordReset,
              style: TextStyle(
                fontSize: 28,
                fontFamily: appFonts.NunitoBold,
                fontWeight: FontWeight.w600,
                color: appColors.contentPrimary,
              ),
            ),
            Text(
              appStrings.successful,
              style: TextStyle(
                fontSize: 28,
                fontFamily: appFonts.NunitoBold,
                fontWeight: FontWeight.w600,
                color: appColors.contentAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              appStrings.successDesc,
              style: TextStyle(
                fontSize: 16,
                color: appColors.contentSecondary,
                fontFamily: appFonts.NunitoMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            commonButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: appStrings.signInButton, () {
              Get.offAllNamed(RoutesClass.login);
            }),
            const SizedBox(height: 20), // Bottom spacing
          ],
        ),
      ),
    );
  }
}

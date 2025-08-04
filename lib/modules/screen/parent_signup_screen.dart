import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';

import 'package:vroar/resources/strings.dart';

import '../../common/common_widgets.dart';
import '../../routes/routes_class.dart';
import '../controller/parent_signup_controller.dart';

class ParentSignUpScreen extends ParentWidget {
  const ParentSignUpScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ParentSignUpController controller = Get.put(ParentSignUpController());
    return SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                height: h * 0.48,
                width: w,
                appImages.parentSignUpImage,
                fit: BoxFit
                    .fill,
              ),
            ),
            backButton(() => Get.back()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //height: h * 0.57,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        textAlign: TextAlign.center,
                        appStrings.welcomeParent,
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: AppFonts.appFonts.NunitoBold,
                          color: appColors.contentPrimary
                        ),
                      ),
                      Text(
                        appStrings.parentGuardians,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: AppFonts.appFonts.NunitoBold,
                          color: appColors.contentAccent
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: edgeInsetsOnly(left: 10, right: 10),
                        child: Text(
                          appStrings.signUpParentDes,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.appFonts.NunitoRegular,
                            fontWeight: FontWeight.w600,
                              color: appColors.contentPrimary
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      emailField(
                          controller.emailController.value,
                          controller.emailFocusNode.value, (value) {},
                          hint: appStrings.emailHint),
                      const SizedBox(height: 20),
                      commonButton(double.infinity, 50, appColors.contentAccent, Colors.white,hint:appStrings.signUpButton,  () {Get.toNamed(RoutesClass.signUpDetails,arguments: {
                        'role': "PARENT",
                        'emailId':
                        controller.emailController.value.text,
                      },);}),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Flexible(
                            child: Divider(
                              color: appColors.border,
                              thickness: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            appStrings.continueWith,
                            style: TextStyle(
                                fontSize: 14,
                                color: appColors.contentPrimary,
                                fontFamily: appFonts.NunitoRegular,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Divider(
                              color: appColors.border,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: appColors.tertiary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(appImages.googleIcon),
                              iconSize: 40,
                            ),
                          ),
                          const SizedBox(width: 22),
                          Container(
                            decoration: BoxDecoration(
                              color: appColors.tertiary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(appImages.appleIcon),
                              iconSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

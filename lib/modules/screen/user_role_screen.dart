import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/gradient.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/routes/routes_class.dart';

import '../../common/Constants.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../controller/login_controller.dart';

class UserRoleScreen extends ParentWidget {
  const UserRoleScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                centerTitle: true,
                toolbarHeight: 70,
                leading: InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: appColors.contentPrimary,
                  ),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(gradient: AppGradients.roleGradient),
                height: h,
                width: w,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: h * 0.05),
                      Text(
                        appStrings.selectAccount,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: appFonts.NunitoBold,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: h * 0.075),
                      InkWell(
                        onTap: () =>
                            Get.toNamed(RoutesClass.studentOnBoardingScreen),
                        child: _buildRoleCard(
                          context,
                          title: appStrings.student,
                          description: appStrings.studentDescription,
                          imagePath: appImages.studentLogin,
                          active: true,
                          w: w,
                          h: h,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () =>
                            Get.toNamed(RoutesClass.parentOnBoardingScreen),
                        child: _buildRoleCard(
                          context,
                          title: appStrings.parent,
                          description: appStrings.parentDescription,
                          imagePath: appImages.parentLogin,
                          active: false,
                          w: w,
                          h: h,
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // InkWell(
                      //   onTap: () => Get.toNamed(RoutesClass.mentorOnBoardingScreen),
                      //   child: _buildRoleCard(
                      //     context,
                      //     title: appStrings.mentor,
                      //     description: appStrings.mentorDescription,
                      //     imagePath: appImages.mentorLogin,
                      //     active: false,
                      //     w: w,
                      //     h: h,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  }
}

Widget _buildRoleCard(BuildContext context,
    {required String title,
    required String description,
    required String imagePath,
    required bool active,
    required w,
    required h}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
          color: active ? appColors.contentAccent : appColors.border, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: w * 0.38,
            height: 150,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 8, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: appFonts.NunitoBold,
                    fontWeight: FontWeight.bold,
                    color: active
                        ? appColors.contentAccent
                        : appColors.contentPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: appFonts.NunitoRegular,
                    fontWeight: FontWeight.w600,
                    color: appColors.contentPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

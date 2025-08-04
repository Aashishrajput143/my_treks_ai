import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';

import 'package:vroar/resources/strings.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../common/no_leading_space.dart';
import '../../data/response/status.dart';
import '../../resources/formatter.dart';
import '../../resources/validator.dart';
import '../../routes/routes_class.dart';
import '../controller/student_signup_controller.dart';
import '../controller/student_onboarding_controller.dart';

class StudentSignUpScreen extends ParentWidget {
  const StudentSignUpScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    StudentSignUpController controller = Get.put(StudentSignUpController());
    return Obx(
      () => Stack(children: [
        Scaffold(
          body: ScrollConfiguration(
            behavior: NoOverscrollBehavior(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height: h,
                width: w,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset(
                        height: h * 0.48,
                        width: w,
                        appImages.studentSignUpImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    backButton(() => Get.back()),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        //height: h * 0.55,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: h <= 677 ? 10.0 : 20, vertical: h <= 677 ? h * 0.02 : h * 0.06),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Title
                              Text(
                                textAlign: TextAlign.center,
                                appStrings.joinOur,
                                style: TextStyle(fontSize: 35, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
                              ),
                              Text(
                                appStrings.learningCommunity,
                                style: TextStyle(fontSize: 30, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentAccent),
                              ),
                              SizedBox(height: h * 0.01),
                              Padding(
                                padding: edgeInsetsOnly(left: 10, right: 10),
                                child: Text(
                                  appStrings.empower,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                                ),
                              ),
                              SizedBox(height: h * 0.02),
                              emailField(controller.emailController.value, controller.emailFocusNode.value, (value) {
                                if (value.isNotEmpty) {
                                  controller.isValid.value = true;
                                  controller.errorEmail.value = Validator.validateEmail(value);
                                } else {
                                  controller.isValid.value = false;
                                  controller.errorEmail.value = null;
                                }
                              }, onChange: (value) {
                                if (value.isNotEmpty) {
                                  controller.isValid.value = true;
                                  //controller.errorEmail.value=Validator.validateEmail(value);
                                } else {
                                  controller.isValid.value = false;
                                  controller.errorEmail.value = null;
                                }
                              }, hint: appStrings.emailHint, inputFormatters: [NoSpaceTextInputFormatter()], error: controller.errorEmail.value),
                              SizedBox(height: h * 0.02),
                              commonButton(double.infinity, h * 0.06, controller.isValid.value ? appColors.contentAccent : appColors.buttonStateDisabled, controller.isValid.value ? Colors.white : appColors.buttonTextStateDisabled, hint: appStrings.signUpButton, () {
                                if (controller.isValid.value && (Validator.validateEmail(controller.emailFocusNode.value.hasPrimaryFocus ? "" : controller.emailController.value.text) == null)) {
                                  controller.verifyEmailApi();
                                } else {
                                  controller.errorEmail.value = (Validator.validateEmail(controller.emailFocusNode.value.hasPrimaryFocus ? "" : controller.emailController.value.text));
                                }
                                // else {
                                //   CommonMethods.showError(title: "Field Required !", message:  "please enter the email");
                                // }
                              }),
                              SizedBox(height: h * 0.018),
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
                                    style: TextStyle(fontSize: 14, color: appColors.contentPrimary, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600),
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
                              SizedBox(height: h * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: appColors.tertiary,
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () async {
                                        await controller.socialLoginController.signIn();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset(appImages.googleIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 22),
                                  Material(
                                    color: appColors.tertiary,
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () async {
                                        await controller.socialLoginController.signInWithApple();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset(
                                            appImages.appleIcon),
                                      ),
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
                ),
              ),
            ),
          ),
        ),
        progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
        progressBar(controller.socialLoginController.rxRequestStatus.value == Status.LOADING, h, w),
      ]),
    );
  }
}

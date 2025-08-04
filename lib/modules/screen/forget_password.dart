import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/colors.dart';

import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/strings.dart';
import '../../resources/validator.dart';
import '../controller/forget_password_controller.dart';

class ForgotPasswordScreen extends ParentWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ForgetPasswordController controller = Get.put(ForgetPasswordController());
    return Obx(() =>Stack(
      children: [ Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                RichText(
                  text: TextSpan(
                    text: appStrings.resetYour,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: appFonts.NunitoBold,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: appStrings.passwordQ,
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: appFonts.NunitoBold,
                          fontWeight: FontWeight.w600,
                          color: appColors.contentAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  appStrings.newForgetPassDesc,
                  style: TextStyle(
                    fontSize: 16,
                    color: appColors.contentSecondary,
                    fontFamily: appFonts.NunitoMedium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                passwordField(controller.passwordController.value, controller.passwordFocusNode.value, w, hint: appStrings.newPassword, () {
                  controller.showPassword.value = !controller.showPassword.value;
                }, (value) {if (value.isNotEmpty&&controller.cPasswordController.value.text.isNotEmpty) {
                  controller.isValid.value = true;
                } else {
                  controller.isValid.value = false;
                }
                }, onChange: (value) {
                  if (value.isNotEmpty&&controller.cPasswordController.value.text.isNotEmpty) {
                    controller.isValid.value = true;
                  } else {
                    controller.isValid.value = false;
                  }
                }, obscure: controller.showPassword.value,error: Validator.validatePassword(controller.passwordFocusNode.value.hasPrimaryFocus ? "" : controller.passwordController.value.text, controller.cPasswordController.value.text, false)),
                const SizedBox(height: 20),
                passwordField(controller.cPasswordController.value, controller.cPasswordFocusNode.value, w, hint: appStrings.confirmPassword, () {
                  controller.showCPassword.value = !controller.showCPassword.value;
                }, (value) {if (value.isNotEmpty && controller.passwordController.value.text.isNotEmpty) {
                  controller.isValid.value = true;
                } else {
                  controller.isValid.value = false;
                }
                }, onChange: (value) {
                  if (value.isNotEmpty&&controller.passwordController.value.text.isNotEmpty) {
                    controller.isValid.value = true;
                  } else {
                    controller.isValid.value = false;
                  }
                }, obscure: controller.showCPassword.value,error: Validator.validatePassword(controller.cPasswordFocusNode.value.hasPrimaryFocus ? "" : controller.cPasswordController.value.text, controller.passwordController.value.text, true)),
                const SizedBox(height: 20),
                commonButton(double.infinity, 50, controller.isValid.value ? appColors.contentAccent : appColors.buttonStateDisabled,
                    controller.isValid.value ? Colors.white : appColors.buttonTextStateDisabled,
                    hint: appStrings.resetPassword, () {
                      if (controller.isValid.value &&
                          ( Validator.validatePassword(controller.cPasswordFocusNode.value.hasPrimaryFocus ? "" : controller.cPasswordController.value.text, controller.passwordController.value.text, true) ==
                              null)) {
                        controller.forgetPasswordApi();
                      }

                }),
                const SizedBox(height: 20), // Bottom spacing
              ],
            ),
          ),
        ),progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
        // internetException(
        //     controller.rxRequestStatus.value == Status.ERROR &&
        //         controller.error.value.toString() == "No internet",
        //         () {}),
        // generalException(
        //     controller.rxRequestStatus.value == Status.ERROR &&
        //         controller.error.value.toString() != "No internet",
        //         () {}),
      ],
    ),);
  }
}

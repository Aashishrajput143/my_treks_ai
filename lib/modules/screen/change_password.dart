import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';
import '../../resources/validator.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends ParentWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ChangePasswordController controller = Get.put(ChangePasswordController());
    return Obx(
          () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 80,
              title: Text(
                appStrings.changePassword,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: appFonts.NunitoBold,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              leading: InkWell(
                onTap: () => controller.mainController.role.value == "PARENT"
                    ? controller.mainController.selectedIndex.value = 4
                    : controller.mainController.selectedIndex.value = 8,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: appColors.contentPrimary,
                ),
              ),
            ),
            body: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appStrings.currentPasswordHint,
                    style: TextStyle(
                        color: appColors.contentPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  passwordField(
                    controller.currentPasswordController.value,
                    controller.currentPasswordFocusNode.value,
                    w,
                    hint: appStrings.enterCurrentPassword,
                        () {
                      controller.showCurrentPassword.value =
                      !controller.showCurrentPassword.value;
                    },
                        (value) {},
                    onChange: (value){
                      controller.inValidCouponCode.value=null;
                    },
                    inputFormatters: [NoSpaceTextInputFormatter()],
                    obscure: controller.showCurrentPassword.value,
                      error:controller.inValidCouponCode.value?.isNotEmpty??false?controller.inValidCouponCode.value: Validator.validatePassword(
                          controller.cPasswordFocusNode.value.hasPrimaryFocus
                              ? ""
                              : controller.cPasswordController.value.text,
                          controller.passwordController.value.text,
                          true),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appStrings.enterAndConfirmNewPasswordHint,
                    style: TextStyle(
                        color: appColors.contentPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  passwordField(controller.passwordController.value,
                      controller.passwordFocusNode.value, w,
                      hint: appStrings.enterPassword, () {
                        controller.showPassword.value =
                        !controller.showPassword.value;
                      }, (value) {},
                      inputFormatters: [NoSpaceTextInputFormatter()],
                      obscure: controller.showPassword.value,
                      error: Validator.validatePassword(
                          controller.passwordFocusNode.value.hasPrimaryFocus
                              ? ""
                              : controller.passwordController.value.text,
                          controller.cPasswordController.value.text,
                          false)),
                  const SizedBox(height: 8),
                  passwordField(
                      controller.cPasswordController.value,
                      controller.cPasswordFocusNode.value,
                      w,
                      hint: appStrings.confirmPassword,
                          () {
                        controller.showCPassword.value =
                        !controller.showCPassword.value;
                      },
                          (value) {},
                      onChange: (value) {
                        controller.error.value=Validator.validatePassword(
                            controller.cPasswordFocusNode.value.hasPrimaryFocus
                                ? ""
                                : value,
                            controller.passwordController.value.text,
                            true);
                      },
                      inputFormatters: [NoSpaceTextInputFormatter()],
                      obscure: controller.showCPassword.value,
                      error: Validator.validatePassword(
                          controller.cPasswordFocusNode.value.hasPrimaryFocus
                              ? ""
                              : controller.cPasswordController.value.text,
                          controller.passwordController.value.text,
                          true)),
                  const Spacer(),
                  commonButton(
                      double.infinity,
                      50,
                      controller.isValidate() == null
                          ? appColors.contentAccent
                          : appColors.buttonStateDisabled,
                      controller.isValidate() == null
                          ? Colors.white
                          : appColors.buttonTextStateDisabled,
                      hint: appStrings.resetPassword, () {
                    if (controller.isValidate() == null) {
                      controller.changePasswordApi(context);
                    } else {
                      CommonMethods.showError(
                          title: "Field Required !",
                          message: controller.isValidate() ?? "");
                    }
                  }),
                  SizedBox(height: h * 0.05),
                ],
              ),
            ),
          ),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          // internetException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() == "No internet",
          //         () {}),
          // generalException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() != "No internet",
          //         () {}),
        ],
      ),
    );
  }
}

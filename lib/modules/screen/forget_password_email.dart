import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/modules/controller/forget_password_email_controller.dart';
import 'package:vroar/resources/colors.dart';

import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';
import '../../resources/validator.dart';
import '../../routes/routes_class.dart';

class ForgotPasswordEmailScreen extends ParentWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ForgetPasswordEmailController controller =
        Get.put(ForgetPasswordEmailController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60), // Top spacing
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: appColors.contentPrimary,
                      )),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: appStrings.forgetYour,
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
                    appStrings.forgetPassDesc,
                    style: TextStyle(
                      fontSize: 16,
                      color: appColors.contentSecondary,
                      fontFamily: appFonts.NunitoMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  emailField(controller.emailController.value,
                      controller.emailFocusNode.value, (value) {
                    if (value.isNotEmpty) {
                      controller.isValid.value = true;
                      controller.errorEmail.value =
                          Validator.validateEmail(value);
                    } else {
                      controller.isValid.value = false;
                      controller.errorEmail.value = null;
                    }
                  }, onChange: (value) {
                    if (value.isNotEmpty) {
                      controller.isValid.value = true;
                      controller.errorEmail.value = null;
                    } else {
                      controller.isValid.value = false;
                      controller.errorEmail.value = null;
                    }
                  },
                      hint: appStrings.emailHint,
                      inputFormatters: [NoSpaceTextInputFormatter()],
                      error: controller.errorEmail.value),
                  const SizedBox(height: 20),
                  commonButton(
                      double.infinity,
                      50,
                      controller.isValid.value
                          ? appColors.contentAccent
                          : appColors.buttonStateDisabled,
                      controller.isValid.value
                          ? Colors.white
                          : appColors.buttonTextStateDisabled,
                      hint: appStrings.resetPassword, () {
                    if (controller.isValid.value &&
                        (Validator.validateEmail(
                                controller.emailFocusNode.value.hasPrimaryFocus
                                    ? ""
                                    : controller.emailController.value.text) ==
                            null)) {
                      controller.forgetEmailApi();
                    } else {
                      controller.errorEmail.value = (Validator.validateEmail(
                          controller.emailFocusNode.value.hasPrimaryFocus
                              ? ""
                              : controller.emailController.value.text));
                    }
                  }),
                  const Spacer(),
                  Center(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: h * 0.06),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              appStrings.doNotAccount,
                              style: TextStyle(
                                color: appColors.contentSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: appFonts.NunitoRegular,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: appColors.contentAccent.withOpacity(
                                        0.5), // Shadow color with opacity
                                    spreadRadius:
                                        0, // No spread to keep the shadow compact
                                    blurRadius:
                                        10, // Blur radius to make the shadow soft
                                    offset: const Offset(0,
                                        4), // Shadow only at the bottom (X: 0, Y: positive value)
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(RoutesClass.userRole);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 12),
                                  minimumSize: const Size(30, 50),
                                  backgroundColor:
                                      Colors.white, // Button background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: appColors.contentAccent,
                                        width: 1), // Border color and width
                                  ),
                                  shadowColor: Colors
                                      .transparent, // Disable default shadow to avoid duplication
                                ),
                                child: Text(
                                  appStrings.createAccountButton,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: appFonts.NunitoMedium,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        appColors.contentAccent, // Text color
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Bottom spacing
                ],
              ),
            ),
          ),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w)
        ],
      ),
    );
  }
}

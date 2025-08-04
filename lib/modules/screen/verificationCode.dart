import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common/common_widgets.dart';
import '../../common/gradient.dart';
import '../../modules/controller/forget_password_email_controller.dart';
import '../../resources/colors.dart';
import '../../utils/sized_box_extension.dart';
import '../../utils/utils.dart';
import '../../common/common_methods.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/strings.dart';
import '../controller/signup_details_controller.dart';
import '../controller/verification_code_controller.dart';

class VerificationCodeScreen extends ParentWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    VerificationCodeController controller = Get.put(VerificationCodeController());
    SignupDetailsController signupController = Get.put(SignupDetailsController());
    ForgetPasswordEmailController forgetController = Get.put(ForgetPasswordEmailController());
    return Obx(() => Stack(children: [
          Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                  decoration: BoxDecoration(gradient: AppGradients.commonGradient),
                  height: h,
                  width: w,
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            50.kH,
                            Text(appStrings.enter, style: TextStyle(fontSize: 28, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary)),
                            RichText(
                                text: TextSpan(
                                    text: appStrings.verification,
                                    style: TextStyle(fontSize: 28, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                                    children: [TextSpan(text: appStrings.code, style: TextStyle(fontSize: 28, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent))])),
                            10.kH,
                            Text(appStrings.verificationDesc, style: TextStyle(fontSize: 16, color: appColors.contentSecondary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600)),
                            1.kH,
                            Row(children: [
                              Text(controller.emailId.value, style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: appColors.contentSecondary)),
                              3.kW,
                              // InkWell(
                              //     splashColor: Colors.transparent,
                              //     onTap: () => Navigator.pop(context),
                              //     child: Text(appStrings.change,
                              //         style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent, decoration: TextDecoration.underline, decorationThickness: 2, decorationColor: appColors.contentAccent))),
                            ]),
                            const SizedBox(height: 35),
                            PinCodeTextField(
                              appContext: context,
                              length: 6,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.fade,
                              autoFocus: true,
                              cursorHeight: 20,
                              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: appFonts.NunitoBold),
                              controller: controller.otpController.value,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: h * 0.066,
                                  fieldWidth: w * 0.13,
                                  activeFillColor: Colors.white,
                                  selectedColor: appColors.border,
                                  activeColor: appColors.border,
                                  selectedFillColor: Colors.white,
                                  inactiveColor: appColors.border,
                                  inactiveFillColor: Colors.white),
                              enableActiveFill: true,
                              onChanged: (value) {
                                controller.otpController.value.text = value;
                                Utils.printLog("Current OTP: $value");
                              },
                              onCompleted: (value) {
                                Utils.printLog("Submitted OTP: $value");
                              },
                            ),
                            SizedBox(height: h * 0.02),
                            commonButton(
                              double.infinity,
                              50,
                              appColors.contentAccent,
                              Colors.white,
                              hint: appStrings.verifyEmail,
                              () {
                                if (controller.otpController.value.text.length == 6) {
                                  controller.forget.value ? controller.verifyForgetOtpApi() : controller.verifyOtpApi(context, h);
                                } else {
                                  CommonMethods.showToast("Please Enter 6 Digits OTP");
                                }
                              },
                            ),
                            16.kH,
                            controller.seconds.value == 60
                                ? commonButton(
                                    double.infinity,
                                    50,
                                    Colors.white,
                                    appColors.contentAccent,
                                    hint: appStrings.resendOtp,
                                    borderColor: appColors.contentAccent,
                                    () {
                                      controller.otpController.value.text = "";
                                      controller.forget.value ? forgetController.forgetEmailApi() : signupController.registerApi();
                                      if (controller.seconds.value == 60) {
                                        controller.startTimer();
                                      }
                                    },
                                  )
                                : commonButton(double.infinity, 50, appColors.buttonStateDisabled, appColors.buttonTextStateDisabled, hint: "${appStrings.resendOtp} in ${controller.seconds.value} seconds", () {}),
                            20.kH
                          ]))))),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          progressBar(signupController.rxRequestStatus.value == Status.LOADING, h, w),
          // internetException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() == "No internet",
          //         () {}),
          // generalException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() != "No internet",
          //         () {}),
        ]));
  }
}

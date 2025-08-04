import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/login_controller.dart';
import 'package:vroar/resources/validator.dart';
import 'package:vroar/resources/colors.dart';

import '../../common/Constants.dart';
import '../../common/common_widgets.dart';

import '../../common/gradient.dart';
import '../../common/my_utils.dart';
import '../../common/no_leading_space.dart';
import '../../data/response/status.dart';
import '../../resources/font.dart';
import '../../resources/formatter.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';

class LoginScreen extends ParentWidget {
  const LoginScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    LoginController controller = Get.put(LoginController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
              //resizeToAvoidBottomInset: false,
              body: ScrollConfiguration(
            behavior: NoOverscrollBehavior(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                height: h,
                width: w,
                decoration: const BoxDecoration(gradient: AppGradients.loginGradient),
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset(
                        appImages.loginImage,
                        height: h * 0.5,
                        width: w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: h <= 677 ? 0 : h * 0.04),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              right: 10,
                              child: SvgPicture.asset(
                                appImages.vectorRight,
                                colorFilter: null,
                                //height: 60,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: SvgPicture.asset(
                                appImages.vectorLeft,
                                colorFilter: null,
                                //height: 80,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: h <= 677 ? h * 0.02 : h * 0.05),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    appStrings.welcomeLogin,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold),
                                  ),
                                  Text(
                                    appStrings.signInContinue,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18, color: appColors.contentSecondary, fontFamily: appFonts.NunitoBold),
                                  ),
                                  SizedBox(height: h * 0.01),
                                  emailField(controller.emailController.value, controller.emailFocusNode.value, (value) {
                                    if (value.isNotEmpty) {
                                      controller.isEmailValid.value = true;
                                      controller.errorEmail.value = Validator.validateEmail(value);
                                    } else {
                                      controller.isEmailValid.value = false;
                                      controller.errorEmail.value = null;
                                    }
                                  }, onChange: (value) {
                                    if (value.isNotEmpty) {
                                      controller.isEmailValid.value = true;
                                      controller.errorEmail.value = null;
                                    } else {
                                      controller.isEmailValid.value = false;
                                      controller.errorEmail.value = null;
                                    }
                                  }, inputFormatters: [NoSpaceTextInputFormatter()], hint: appStrings.emailHint, error: controller.errorEmail.value),
                                  SizedBox(height: h * 0.01),
                                  passwordField(controller.passwordController.value, controller.passwordFocusNode.value, w, hint: appStrings.passwordHint, () {
                                    controller.showPassword.value = !controller.showPassword.value;
                                  }, (value) {
                                    if (value.isNotEmpty) {
                                      controller.isPasswordValid.value = true;
                                    } else {
                                      controller.isPasswordValid.value = false;
                                    }
                                  }, onChange: (value) {
                                    if (value.isNotEmpty) {
                                      controller.isPasswordValid.value = true;
                                    } else {
                                      controller.isPasswordValid.value = false;
                                    }
                                  }, inputFormatters: [NoSpaceTextInputFormatter()], obscure: controller.showPassword.value, error: null),
                                  SizedBox(height: h * 0.01),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RoutesClass.forgetPasswordEmail);
                                      },
                                      child: Text(
                                        appStrings.forgetPassLogin,
                                        style: TextStyle(color: appColors.contentAccent, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, decoration: TextDecoration.underline, decorationColor: appColors.contentAccent, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01),
                                  commonButton(double.infinity, h * 0.06, controller.isEmailValid.value && controller.isPasswordValid.value ? appColors.contentAccent : appColors.buttonStateDisabled,
                                      controller.isEmailValid.value && controller.isPasswordValid.value ? Colors.white : appColors.buttonTextStateDisabled,
                                      hint: appStrings.signInButton, () {
                                    if (controller.emailController.value.text.isNotEmpty && controller.passwordController.value.text.isNotEmpty && (Validator.validateEmail(controller.emailFocusNode.value.hasPrimaryFocus ? "" : controller.emailController.value.text)) == null) {
                                      controller.errorEmail.value = null;
                                      controller.loginApi(context);
                                    } else {
                                      controller.errorEmail.value = (Validator.validateEmail(controller.emailFocusNode.value.hasPrimaryFocus ? "" : controller.emailController.value.text));
                                    }
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
                                  SizedBox(height: h * 0.018),
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
                                            child: SvgPicture.asset(appImages.appleIcon),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: h * 0.05),
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
                            commonButtonShadow(30, 50, appColors.contentAccent, Colors.white, appColors.contentAccent, hint: appStrings.createAccountButton, () {
                              Utils.savePreferenceValues(Constants.isSocialLogin, "");
                              Get.toNamed(RoutesClass.userRole);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          progressBar(controller.socialLoginController.rxRequestStatus.value == Status.LOADING, h, w),
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

// Stack(
//   children: [
//     Container(
//       height: h,
//       width: w,
//       padding: edgeInsetsOnly(left: 25,right: 25),
//       color: Colors.white,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             paddingOnly(top: h*0.1),
//             Image.asset(
//               appImages.appIcon,
//               height: 64,
//               width: 64,
//
//
//             ),
//             paddingOnly(top: h*0.07),
//
//             titleText(appStrings.login,fontFamily: appFonts.robotsRegular,fontSize: 28,fontWeight: FontWeight.bold),
//             paddingOnly(top: h*0.07),
//             Container(
//               margin: edgeInsetsOnly(left: 15),
//               child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: descriptionText(appStrings.loginEmailAndPass,fontSize: 14)),
//             ),
//             paddingOnly(top: h*0.01),
//             phoneNumberFieldWithoutGradient(controller.phoneNumberController.value, controller.phoneNumberFocusNode.value,w),
//             paddingOnly(top: h*0.031),
//             descriptionText(appStrings.or,fontSize: 15),
//             paddingOnly(top: h*0.02),
//             Container(
//               margin: edgeInsetsOnly(left: 15),
//               child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: descriptionText(appStrings.loginEmail,fontSize: 14)),
//             ),
//             paddingOnly(top: h*0.01),
//           emailField(controller.emailController.value, controller.emailFocusNode.value, Colors.white,w,h*0.05,hint: appStrings.emailHint ),
//             paddingOnly(top: h*0.05),
//             Container(
//               margin: edgeInsetsOnly(left: 15),
//               child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: descriptionText(appStrings.forgotPassword,fontSize: 14)),
//             ),
//             paddingOnly(top: h*0.01),
//             GestureDetector(
//                 onTap: (){
//                   controller.logInAndRegister(context);
//                 },
//                 child: commonButton( w, h*0.06, descriptionText(appStrings.onHold),Color(appColors.colorPrimaryNew))),
//             paddingOnly(top: h*0.02),
//             Container(
//               margin: edgeInsetsOnly(left: 15),
//               child: Align(
//                   alignment: Alignment.center,
//                   child: descriptionText(appStrings.createAccount,fontSize: 14)),
//             ),
//             paddingOnly(top: h*0.02),
//             Container(
//               margin: edgeInsetsOnly(left: 15),
//               child: Align(
//                   alignment: Alignment.center,
//                   child: descriptionText(appStrings.or,fontSize: 14)),
//             ),
//             paddingOnly(top: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 commonContainerOutlined(w*0.4, h*0.05,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           appImages.appleIcon,
//                           height: 24,
//                           width: 24,
//
//
//
//                         ),
//                         paddingOnly(left: 5),
//                         descriptionText(appStrings.signInWithGoogle,fontSize: 12)
//                       ],
//                     ), Colors.white),
//                 paddingOnly(left: 22),
//                 commonContainerOutlined(w*0.4, h*0.05, Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       appImages.appleIcon,
//                       height: 24,
//                       width: 24,
//                       color: Colors.black,
//
//
//
//                     ),
//                     paddingOnly(left: 5),
//                     descriptionText(appStrings.signInWithApple,fontSize: 12)
//                   ],
//                 ), Colors.white)
//               ],
//             ),
//             paddingOnly(top: h*0.05),
//             Align(
//                 alignment: Alignment.bottomCenter,
//                 child: descriptionText(appStrings.contactToVroar,fontSize: 14,color: Colors.red)),
//           ],
//         )
//         ,
//       ),
//     ),
//     progressBar(controller.rxRequestStatus.value==Status.LOADING, h, w),
//     internetException(controller.rxRequestStatus.value==Status.ERROR && controller.error.value.toString() == "No internet", (){
//
//     }),
//     generalException(controller.rxRequestStatus.value==Status.ERROR && controller.error.value.toString() != "No internet", (){
//
//     }),
//   ],
// )

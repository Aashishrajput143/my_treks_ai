import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/validator.dart';
import 'package:vroar/resources/colors.dart';

import '../../common/common_widgets.dart';
import '../../common/gradient.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../controller/student_invite_controller.dart';

class StudentInviteScreen extends ParentWidget {
  const StudentInviteScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    StudentInviteController controller = Get.put(StudentInviteController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            //resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                  gradient: AppGradients.commonGradient
              ),
              height: h,
              width: w,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50), // Top spacing
                      RichText(
                        text: TextSpan(
                          text: appStrings.inviteYour,
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: appFonts.NunitoBold,
                            fontWeight: FontWeight.w600,
                            color: appColors.contentPrimary,
                          ),
                          children: [
                            TextSpan(
                              text: appStrings.child,
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
                        appStrings.studentInviteDesc,
                        style: TextStyle(
                          fontSize: 16,
                          color: appColors.contentSecondary,
                          fontFamily: appFonts.NunitoMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Text(
                        appStrings.kidInformationHint,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      commonTextField(
                        controller.firstNameController.value,
                        controller.firstNameFocusNode.value,
                        w,
                        (value) {},
                        hint: appStrings.firstName,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          RemoveTrailingPeriodsFormatter(),
                          SpecialCharacterValidator(),
                          EmojiInputFormatter(),
                          LengthLimitingTextInputFormatter(20)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      commonTextField(
                        controller.lastNameController.value,
                        controller.lastNameFocusNode.value,
                        w,
                        (value) {},
                        hint: appStrings.lastName,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          RemoveTrailingPeriodsFormatter(),
                          SpecialCharacterValidator(),
                          EmojiInputFormatter(),
                          LengthLimitingTextInputFormatter(20)
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        appStrings.gradeHint,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      dropdownButton(
                        controller.gradeOptions,
                        controller.selectedGrade.value,
                        w,
                        50,
                        Colors.white,
                        hint: appStrings.selectGrade,
                        (newValue) {
                          controller.selectedGrade.value = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        appStrings.emailAddressHint,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      emailField(controller.emailController.value,
                          controller.emailFocusNode.value, (value) {},
                          hint: appStrings.enterEmailAddress,
                          inputFormatters: [NoSpaceTextInputFormatter()],
                          error: Validator.validateEmail(
                              controller.emailFocusNode.value.hasPrimaryFocus
                                  ? ""
                                  : controller.emailController.value.text)),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        appStrings.phoneNumberHint,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      phoneTextField(
                          controller.phoneController.value,
                          controller.countryCode.value,
                          controller.phoneNumberFocusNode.value,
                          onCountryCodeChange: (phone) {
                        print(phone.completeNumber);
                        controller.countryCode.value = phone.countryCode;
                        print(phone.countryCode);
                      }, w, h * 0.06,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          hint: appStrings.enterPhoneNumber),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        appStrings.relationHint,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      dropdownButton(
                        controller.relationOptions,
                        controller.selectedRelation.value,
                        w,
                        50,
                        Colors.white,
                        hint: appStrings.selectRelation,
                        (newValue) {
                          controller.selectedRelation.value = newValue!;
                        },
                      ),

                      SizedBox(
                        height: h * 0.08,
                      ),
                      commonButton(
                          double.infinity,
                          50,
                          controller.emailController.value.text.isNotEmpty
                              ? appColors.contentAccent
                              : appColors.buttonStateDisabled,
                          controller.emailController.value.text.isNotEmpty
                              ? Colors.white
                              : appColors.buttonTextStateDisabled,
                          hint: appStrings.continueButton, () {
                        Get.toNamed(RoutesClass.questionAnswer);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
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

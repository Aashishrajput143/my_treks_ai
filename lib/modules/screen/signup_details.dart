import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vroar/common/gradient.dart';
import 'package:vroar/modules/controller/signup_details_controller.dart';
import 'package:vroar/resources/validator.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/images.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/get_image_photo_gallery.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';

class SignupDetailsScreen extends ParentWidget {
  const SignupDetailsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SignupDetailsController controller = Get.put(SignupDetailsController());
    return Obx(
      () => Stack(
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
              title: RichText(
                text: TextSpan(
                  text: appStrings.enterYour,
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: appFonts.NunitoBold,
                    fontWeight: FontWeight.w600,
                    color: appColors.contentPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: appStrings.details,
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
            ),
            //resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(gradient: AppGradients.commonGradient),
              height: h,
              width: w,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appStrings.signUpDesc,
                        style: TextStyle(
                          fontSize: 16,
                          color: appColors.contentSecondary,
                          fontFamily: appFonts.NunitoMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: appColors.contentAccent,
                                  width: 2.0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 47,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: controller.selectedImage.value
                                              ?.isNotEmpty ??
                                          false
                                      ? Image.file(
                                          File(controller.selectedImage.value ??
                                              ""),
                                          fit: BoxFit.cover,
                                          width: 94,
                                          height: 94,
                                        )
                                      : controller.role.value == "STUDENT"
                                          ? controller.avatar.value.isNotEmpty
                                              ? Image.network(
                                                  controller.avatar.value,
                                                  fit: BoxFit.cover,
                                                  width: 94,
                                                  height: 94,
                                                )
                                              : Image.asset(
                                                  appImages.avatar,
                                                  fit: BoxFit.cover,
                                                  width: 94,
                                                  height: 94,
                                                )
                                          : controller.role.value == "PARENT"
                                              ? Image.asset(
                                                  appImages.parentAvatar,
                                                  fit: BoxFit.cover,
                                                  width: 94,
                                                  height: 94,
                                                )
                                              : controller.role.value ==
                                                      "MENTOR"
                                                  ? Image.asset(
                                                      appImages.mentorAvatar,
                                                      fit: BoxFit.cover,
                                                      width: 94,
                                                      height: 94,
                                                    )
                                                  : const SizedBox(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  showBottomDrawer(context, 250, w);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                      color: appColors.contentAccent),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(appImages.editIcon),
                                    const SizedBox(width: 4),
                                    Text(
                                      appStrings.editPicture,
                                      style: TextStyle(
                                          color: appColors.contentAccent,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        appStrings.personalInformationHint,
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
                      if (controller.role.value == "STUDENT") ...[
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
                      ],
                      const SizedBox(height: 16),
                      Text(
                        appStrings.accountSecurityHint,
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
                      passwordField(controller.cPasswordController.value,
                          controller.cPasswordFocusNode.value, w,
                          hint: appStrings.confirmPassword, () {
                        controller.showCPassword.value =
                            !controller.showCPassword.value;
                      }, (value) {},
                          inputFormatters: [NoSpaceTextInputFormatter()],
                          obscure: controller.showCPassword.value,
                          error: Validator.validatePassword(
                              controller
                                      .cPasswordFocusNode.value.hasPrimaryFocus
                                  ? ""
                                  : controller.cPasswordController.value.text,
                              controller.passwordController.value.text,
                              true)),
                      const SizedBox(height: 16),
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
                          readonly: true,
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
                      }, onCountryChanged: (country) {
                        controller.phoneController.value.text = "";
                        controller.phoneTotalCount.value = country.maxLength;
                      }, w, h * 0.06,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          hint: appStrings.enterPhoneNumber),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        appStrings.ageHint,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ageTextFiled(
                        controller.ageController.value,
                        controller.ageFocusNode.value,
                        w,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChange: (value) {
                          controller.age.value = value.isNotEmpty ? int.parse(value) : null;
                          controller.convertAgeToUnixTimestamp(controller.age.value??13);
                        },
                        hint: appStrings.ageFormat,
                        error: controller.age.value!=null?(controller.age.value??0)<13?"Age Restriction -  Must be 13 or older to sign up.":null:null,
                        ()=>controller.selectAge(context),
                        (value) {},
                      ),
                      // dateOfBirthTextFiled(controller.dobController.value,
                      //     controller.dobFocusNode.value, w, () {
                      //   controller.selectDate(context);
                      // }, (value) {},
                      //     hint: appStrings.dobFormat,
                      //     readonly: true,
                      //     error: Validator.validateAge(
                      //         controller.selectedDate.value.toString(), 13)),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        appStrings.genderHint,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      dropdownButton(
                        controller.genderOptions,
                        controller.selectedGender.value,
                        w,
                        50,
                        Colors.white,
                        hint: appStrings.selectGender,
                        (newValue) {
                          controller.selectedGender.value = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          checkBox(
                            controller.isChecked.value,
                            0.9,
                            4.21,
                            1.3,
                            appColors.contentAccent,
                            Colors.transparent,
                            Colors.transparent,
                            appColors.contentPrimary,
                            (bool? value) {
                              controller.isChecked.value = value ?? false;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              appStrings.iAgreeCheckBox,
                              style: TextStyle(
                                fontSize: 12,
                                color: appColors.contentPrimary,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                fontFamily: appFonts.NunitoRegular,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      commonButton(
                          double.infinity,
                          50,
                          controller.isValidate(controller.role.value) == null
                              ? appColors.contentAccent
                              : appColors.buttonStateDisabled,
                          controller.isValidate(controller.role.value) == null
                              ? Colors.white
                              : appColors.buttonTextStateDisabled,
                          hint: appStrings.submitToProceed, () {
                        if (controller.isValidate(controller.role.value) ==
                            null) {
                          if (controller
                                      .firstNameController.value.text.length >=
                                  2 &&
                              controller.lastNameController.value.text.length >=
                                  2) {
                            if (controller
                                .phoneController.value.text.isNotEmpty) {
                              if (controller
                                      .phoneController.value.text.length ==
                                  controller.phoneTotalCount.value) {
                                controller.submit();
                              }else{
                                CommonMethods.showError(title: "Invalid Phone Number !", message: "Phone Number should be ${controller.phoneTotalCount.value} digits");
                              }
                            } else {
                              controller.submit();
                            }
                          }
                          else if (controller.firstNameController.value.text.length <
                                  2 ||
                              controller.lastNameController.value.text.length <
                                  2) {
                            CommonMethods.showError(
                                title: "Field Length Required!",
                                message:
                                    "First & Last Name Should be Min 2 Characters");
                          } else if (controller.phoneController.value.text.length != controller.phoneTotalCount.value && controller.phoneController.value.text.isNotEmpty) {
                            CommonMethods.showError(
                                title: "Invalid Phone Number!",
                                message:
                                    "Phone Number should be ${controller.phoneTotalCount.value} digits");
                          }
                        }
                        //else {
                        //   CommonMethods.showError(
                        //       title: "Field Required !",
                        //       message: controller
                        //               .isValidate(controller.role.value) ??
                        //           "");
                        // }
                      }),
                      const SizedBox(height: 30), // Bottom spacing
                    ],
                  ),
                ),
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

  void showBottomDrawer(BuildContext context, double h, double w) {
    SignupDetailsController controller = Get.put(SignupDetailsController());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: h,
          width: w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Text(
                  appStrings.uploadPhoto,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: appFonts.NunitoBold,
                      color: appColors.contentPrimary),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await pickImageFromGallery(controller.selectedImage,true);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        appImages.imageGalleryIcon,
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        appStrings.viewPhotoLibrary,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: appFonts.NunitoRegular,
                            fontWeight: FontWeight.w600,
                            color: appColors.contentSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await pickImageFromGallery(controller.selectedImage,false);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        appImages.cameraIcon,
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        appStrings.takeAPhoto,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: appFonts.NunitoRegular,
                            fontWeight: FontWeight.w600,
                            color: appColors.contentSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.selectedImage.value?.isNotEmpty ?? false) {
                      Navigator.pop(context);
                      controller.selectedImage.value = null;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor:
                        controller.selectedImage.value?.isNotEmpty ?? false
                            ? Colors.white
                            : appColors.buttonStateDisabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color:
                            controller.selectedImage.value?.isNotEmpty ?? false
                                ? appColors.contentAccent
                                : appColors.buttonStateDisabled,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        appImages.deleteIcon,
                        width: 25,
                        height: 25,
                        color:
                            controller.selectedImage.value?.isNotEmpty ?? false
                                ? appColors.contentAccent
                                : appColors.buttonTextStateDisabled,
                      ),
                      Text(
                        appStrings.removePhoto,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: appFonts.NunitoMedium,
                          fontWeight: FontWeight.w600,
                          color: controller.selectedImage.value?.isNotEmpty ??
                                  false
                              ? appColors.contentAccent
                              : appColors.buttonTextStateDisabled,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/gradient.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';
import '../../resources/validator.dart';
import '../../routes/routes_class.dart';
import '../controller/parent_invite_controller.dart';

class ParentInviteScreen extends ParentWidget {
  const ParentInviteScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ParentInviteController controller = Get.put(ParentInviteController());

    return Obx(
          () => Stack(
            children: [
              Scaffold(
                      resizeToAvoidBottomInset: true,
                      appBar: controller.isSkip.value
                ? AppBar(surfaceTintColor: Colors.white, toolbarHeight: 20)
                : AppBar(
              surfaceTintColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 50,
              leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back_ios, size: 20, color: appColors.contentPrimary),
              ),
                      ),
                      body: Container(
                  height: h,
                  width: w,
                  decoration: BoxDecoration(gradient: AppGradients.commonGradient),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            text: appStrings.enter,
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: appFonts.NunitoBold,
                              fontWeight: FontWeight.w600,
                              color: appColors.contentPrimary,
                            ),
                            children: [
                              TextSpan(
                                text: appStrings.parentGuardian,
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
                        Text(
                          appStrings.details,
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: appFonts.NunitoBold,
                            fontWeight: FontWeight.w600,
                            color: appColors.contentPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          appStrings.parentInviteDesc,
                          style: TextStyle(
                            fontSize: 16,
                            color: appColors.contentSecondary,
                            fontFamily: appFonts.NunitoMedium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        35.kH,
                        Text(
                          appStrings.personalInformationHint,
                          style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        8.kH,
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
                            LengthLimitingTextInputFormatter(20),
                          ],
                        ),
                        8.kH,
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
                            LengthLimitingTextInputFormatter(20),
                          ],
                        ),
                        16.kH,
                        Text(
                          appStrings.emailAddressHint,
                          style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        8.kH,
                        emailField(
                          controller.emailController.value,
                          controller.emailFocusNode.value,
                              (value) {
                            if (value.isNotEmpty) {
                              controller.errorEmail.value = Validator.validateEmail(value);
                            } else {
                              controller.errorEmail.value = null;
                            }
                          },
                          onChange: (value) {
                            controller.errorEmail.value = null;
                          },
                          hint: appStrings.emailHint,
                          inputFormatters: [NoSpaceTextInputFormatter()],
                          error: controller.errorEmail.value,
                        ),
                        16.kH,
                        Text(
                          appStrings.phoneNumberHint,
                          style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        8.kH,
                        phoneTextField(controller.phoneController.value, controller.countryCode.value, controller.phoneNumberFocusNode.value, onCountryCodeChange: (phone) {
                          print(phone.completeNumber);
                          controller.countryCode.value = phone.countryCode;
                          print(phone.countryCode);
                        }, onCountryChanged: (country) {
                          controller.phoneController.value.text = "";
                          controller.phoneTotalCount.value=country.maxLength;
                        }, w, h * 0.06,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hint: appStrings.enterPhoneNumber),
                        16.kH,
                        Text(
                          appStrings.relationHint,
                          style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        8.kH,
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
                        28.kH,
                        controller.isSkip.value
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonButton(
                              w * 0.42,
                              50,
                              Colors.white,
                              appColors.contentAccent,
                              borderColor: appColors.contentAccent,
                              hint: appStrings.skip,
                                  () {
                                Get.offAllNamed(RoutesClass.commonScreen);
                              },
                            ),
                            commonButton(
                              w * 0.42,
                              50,
                              controller.isValidate() == null ? appColors.contentAccent : appColors.buttonStateDisabled,
                              controller.isValidate() == null ? Colors.white : appColors.buttonTextStateDisabled,
                              hint: appStrings.parentInviteButton,
                                  () {
                                    if (controller.isValidate() == null) {
                                      if (controller.firstNameController.value.text.length >= 2 && controller.lastNameController.value.text.length >= 2 && (Validator.validateEmail(controller.emailFocusNode.value.hasPrimaryFocus ? "" : controller.emailController.value.text) == null)) {
                                        if (controller.phoneController.value.text.isNotEmpty) {
                                          if (controller
                                              .phoneController.value.text.length ==
                                              controller.phoneTotalCount.value) {
                                            controller.userInviteApi();
                                          }
                                          else{
                                            CommonMethods.showError(title: "Invalid Phone Number !", message: "Phone Number should be ${controller.phoneTotalCount.value} digits");
                                          }
                                        } else {
                                          controller.userInviteApi();
                                        }
                                      }
                                      else if (controller.firstNameController.value.text.length < 2 || controller.lastNameController.value.text.length < 2) {
                                        CommonMethods.showError(title: "Field Length Required !", message: "First & Last Name Should be Min 2 Characters");
                                      }
                                      else if(controller.phoneController.value.text.length!=controller.phoneTotalCount.value  && controller.phoneController.value.text.isNotEmpty){
                                        CommonMethods.showError(title: "Invalid Phone Number !", message: "Phone Number should be ${controller.phoneTotalCount.value} digits");
                                      }
                                      else if((Validator.validateEmail(controller.emailController.value.text) != null)){
                                        controller.errorEmail.value = (Validator.validateEmail(controller.emailController.value.text));
                                      }
                                    }
                              },
                            ),
                          ],
                        )
                            : commonButton(
                          double.infinity,
                          50,
                          controller.isValidate() == null ? appColors.contentAccent : appColors.buttonStateDisabled,
                          controller.isValidate() == null ? Colors.white : appColors.buttonTextStateDisabled,
                          hint: appStrings.parentInviteButton,
                              () {
                                if (controller.isValidate() == null) {
                                  if (controller.firstNameController.value.text.length >= 2 && controller.lastNameController.value.text.length >= 2 && (Validator.validateEmail(controller.emailFocusNode.value.hasPrimaryFocus ? "" : controller.emailController.value.text) == null)) {
                                    if (controller.phoneController.value.text.isNotEmpty) {
                                      if (controller
                                          .phoneController.value.text.length ==
                                          controller.phoneTotalCount.value) {
                                        controller.userInviteApi();
                                      }
                                      else{
                                        CommonMethods.showError(title: "Invalid Phone Number !", message: "Phone Number should be ${controller.phoneTotalCount.value} digits");
                                      }
                                    } else {
                                      controller.userInviteApi();
                                    }
                                  }
                                  else if (controller.firstNameController.value.text.length < 2 || controller.lastNameController.value.text.length < 2) {
                                    CommonMethods.showError(title: "Field Length Required !", message: "First & Last Name Should be Min 2 Characters");
                                  }
                                  else if(controller.phoneController.value.text.length!=controller.phoneTotalCount.value  && controller.phoneController.value.text.isNotEmpty){
                                    CommonMethods.showError(title: "Invalid Phone Number !", message: "Phone Number should be ${controller.phoneTotalCount.value} digits");
                                  }
                                  else if((Validator.validateEmail(controller.emailController.value.text) != null)){
                                    controller.errorEmail.value = (Validator.validateEmail(controller.emailController.value.text));
                                  }
                                }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                    ),
              progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
            ],
          ),
    );
  }
}

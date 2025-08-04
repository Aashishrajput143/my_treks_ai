import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends ParentWidget {
  const EditProfileScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    EditProfileController editController = Get.put(EditProfileController());
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
        initState: (state) {
          if (state.mounted) editController.change();
        },
        builder: (controller) {
          return Obx(
            () => Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    surfaceTintColor: Colors.white,
                    centerTitle: true,
                    toolbarHeight: 70,
                    title: Text(
                      appStrings.editProfile,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: appFonts.NunitoBold,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    leading: InkWell(
                      onTap: () => controller.mainController.role.value == "PARENT" ? controller.mainController.selectedIndex.value = 2 : controller.mainController.selectedIndex.value = 4,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: appColors.contentPrimary,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appStrings.personalInformationHint,
                            style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
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
                            inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(20)],
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
                            inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(20)],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            appStrings.emailAddressHint,
                            style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          emailField(controller.emailController.value, controller.emailFocusNode.value, (value) {},
                              hint: appStrings.enterEmailAddress, readonly: true, inputFormatters: [NoSpaceTextInputFormatter()], error: Validator.validateEmail(controller.emailFocusNode.value.hasPrimaryFocus ? "" : controller.emailController.value.text)),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            appStrings.phoneNumberHint,
                            style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          phoneTextField(controller.phoneController.value, controller.countryCode.value, controller.phoneNumberFocusNode.value, initialValue: controller.countryCode.value, onCountryCodeChange: (phone) {
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
                          if (controller.mainController.role.value != "PARENT") ...[
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              appStrings.gradeHint,
                              style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
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
                          const SizedBox(
                            height: 20,
                          ),
                          if (controller.isChangePass.value) ...[
                            commonButton(
                              double.infinity,
                              50,
                              Colors.white,
                              appColors.contentAccent,
                              hint: appStrings.changePassword,
                              borderColor: appColors.contentAccent,
                              () => controller.mainController.role.value == "PARENT" ? controller.mainController.selectedIndex.value = 5 : controller.mainController.selectedIndex.value = 9,
                            ),
                          ],
                          SizedBox(
                            height: h * 0.1,
                          ),
                          commonButton(
                            double.infinity,
                            50,
                            appColors.contentAccent,
                            Colors.white,
                            hint: appStrings.saveChanges,
                            () {
                              if (controller.isValidate() == null) {
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
                                      controller.updateProfileApi();
                                    }else{
                                      CommonMethods.showError(title: "Invalid Phone Number !", message: "Phone Number should be ${controller.phoneTotalCount.value} digits");
                                    }
                                  } else {
                                    controller.updateProfileApi();
                                  }
                                }
                                else if (controller.firstNameController.value.text.length < 2 || controller.lastNameController.value.text.length < 2) {
                                  CommonMethods.showError(title: "Field Length Required !", message: "First & Last Name Should be Min 2 Characters");
                                }
                                else if(controller.phoneController.value.text.length!=controller.phoneTotalCount.value && controller.phoneController.value.text.isNotEmpty){
                                  CommonMethods.showError(title: "Invalid Phone Number !", message: "Phone Number should be ${controller.phoneTotalCount.value} digits");
                                }
                              }else{
                                CommonMethods.showError(title: "Field Required !", message: controller.isValidate()??"");
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                progressBar(controller.mainController.rxRequestStatus.value == Status.LOADING, h, w),
                progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w)
              ],
            ),
          );
        });
  }
}

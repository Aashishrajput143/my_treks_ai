import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/need_assistance_controller.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import '../../common/common_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';

class NeedAssistanceScreen extends ParentWidget {
  const NeedAssistanceScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    NeedAssistanceController controller = Get.put(NeedAssistanceController());
    return Obx(() => Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  surfaceTintColor: Colors.white,
                  centerTitle: true,
                  toolbarHeight: 70,
                  title: Text(
                    appStrings.needAssistance,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: appFonts.NunitoBold,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  leading: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: appColors.contentPrimary,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.025),
                      Text(
                        appStrings.issueTypeHint,
                        style: TextStyle(
                          color: appColors.contentPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      dropdownButton(
                        controller.issueType,
                        controller.selectedIssueType.value,
                        w,
                        50,
                        Colors.white,
                        hint: appStrings.selectIssue,
                        (newValue) {
                          controller.selectedIssueType.value = newValue!;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        appStrings.issueDescHint,
                        style: TextStyle(
                          color: appColors.contentPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      commonDescriptionTextField(
                        controller.descriptionController.value,
                        controller.descriptionFocusNode.value,
                        w,
                        (value) {
                          if (value.isNotEmpty) {
                            controller.isValid.value = true;
                          } else {
                            controller.isValid.value = false;
                          }
                        },
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            controller.isValid.value = true;
                          } else {
                            controller.isValid.value = false;
                          }
                        },
                        hint: appStrings.detailedDescriptionIssue,
                        maxLines: 12,
                        minLines: h <= 677 ? 6 : 9,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLength: 1000,
                      ),
                    ],
                  ),
                ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20,h<=677? 20:50),
                child: commonButton(
                  double.infinity,
                  50,
                  controller.selectedIssueType.value != null &&
                      controller.isValid.value
                      ? appColors.contentAccent
                      : appColors.buttonStateDisabled,
                  controller.selectedIssueType.value != null &&
                      controller.isValid.value
                      ? Colors.white
                      : appColors.buttonTextStateDisabled,
                  hint: appStrings.submit,
                      () {
                    if (controller.selectedIssueType.value != null &&
                        controller.isValid.value) {
                      if (controller
                          .descriptionController.value.text.length >
                          10) {
                        controller.needAssistanceApi(context, w);
                      } else {
                        CommonMethods.showToast(
                            "Description Length Must be More than 10");
                      }
                    }
                  },
                ),),),
            progressBar(
                controller.rxRequestStatus.value == Status.LOADING, h, w),
          ],
        ));
  }
}

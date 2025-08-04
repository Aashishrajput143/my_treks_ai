import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vroar/modules/controller/select_path_controller.dart';
import 'package:vroar/resources/formatter.dart';

import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../models/get_meta_data_model.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../common/gradient.dart';
import '../../common/common_widgets.dart';
import '../../common/roadmap_common_widgets/roadmap_dailogs.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/strings.dart';

class SelectPathScreen extends ParentWidget {
  const SelectPathScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SelectPathController controller = Get.put(SelectPathController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(h * 0.2),
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: appStrings.selectYour,
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: appFonts.NunitoBold,
                          fontWeight: FontWeight.w600,
                          color: appColors.contentPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: appStrings.path,
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
                      appStrings.selectPathDesc,
                      style: TextStyle(
                        fontSize: 18,
                        color: appColors.contentSecondary,
                        fontFamily: appFonts.NunitoMedium,
                        fontWeight: FontWeight.w600,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appStrings.careerPaths,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      commonSearchField(
                        controller.careerSearchController.value,
                        controller.careerSearchFocusNode.value,
                        w,
                        (value) {},
                        hint: appStrings.searchCareerPaths,
                        contentPadding: 14,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          RemoveTrailingPeriodsFormatter(),
                          SpecialCharacterValidator(),
                          EmojiInputFormatter(),
                          LengthLimitingTextInputFormatter(30)
                        ],
                      ),
                      controller.selectedCareerStrength.isNotEmpty
                          ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Wrap(
                            spacing: 6.0,
                            runSpacing: 8.0,
                            children: controller.selectedCareerStrength.map((filter) {
                              return commonButtonFilters(
                                appColors.buttonStateDisabled,
                                appColors.contentPrimary,
                                    fontSize: 14,
                                    () {
                                  controller.selectedCareerStrength.remove(filter);
                                },
                                hint: filter,
                                borderColor: appColors.contentPrimary,
                              );
                            }).toList(),
                          ),)
                          : const SizedBox(),
                      controller.careerSearchFocusNode.value.hasFocus
                          ? commonDropdown(appStrings.searchCareerPaths,controller.getCareerMetaData.value.data?.docs,controller.selectedCareerStrength,(controller.getCareerMetaData.value.data?.docs?.length??0)<=5?5:0)
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Text(
                        appStrings.industryChoices,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      commonSearchField(
                        controller.industrySearchController.value,
                        controller.industrySearchFocusNode.value,
                        w,
                        (value) {},
                        hint: appStrings.searchIndustryChoices,
                        contentPadding: 14,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          RemoveTrailingPeriodsFormatter(),
                          SpecialCharacterValidator(),
                          EmojiInputFormatter(),
                          LengthLimitingTextInputFormatter(30)
                        ],
                      ),
                      controller.selectedIndustryStrength.isNotEmpty
                          ?Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child:  Wrap(
                        spacing: 6.0,
                        runSpacing: 8.0,
                        children: controller.selectedIndustryStrength.map((filter) {
                          return commonButtonFilters(
                            appColors.buttonStateDisabled,
                            appColors.contentPrimary,
                            fontSize: 14,
                                () {
                              controller.selectedIndustryStrength.remove(filter);
                            },
                            hint: filter,
                            borderColor: appColors.contentPrimary,
                          );
                        }).toList(),
                          ),)
                          : const SizedBox(),
                      controller.industrySearchFocusNode.value.hasFocus
                          ? commonDropdown(appStrings.searchIndustryChoices,controller.getIndustryMetaData.value.data?.docs,controller.selectedIndustryStrength,(controller.getIndustryMetaData.value.data?.docs?.length??0)<=5?5:0)
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Text(
                        appStrings.strengths,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      commonSearchField(
                        controller.strengthSearchController.value,
                        controller.strengthSearchFocusNode.value,
                        w,
                        (value) {},
                        hint: appStrings.searchStrengths,
                        contentPadding: 14,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          RemoveTrailingPeriodsFormatter(),
                          SpecialCharacterValidator(),
                          EmojiInputFormatter(),
                          LengthLimitingTextInputFormatter(30)
                        ],
                      ),
                      controller.selectedSelectStrength.isNotEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Wrap(
                                                    spacing: 6.0,
                                                    runSpacing: 8.0,
                                                    children: controller.selectedSelectStrength.map((filter) {
                            return commonButtonFilters(
                              appColors.buttonStateDisabled,
                              appColors.contentPrimary,
                              fontSize: 14,
                                  () {
                                controller.selectedSelectStrength.remove(filter);
                              },
                              hint: filter,
                              borderColor: appColors.contentPrimary,
                            );
                                                    }).toList(),
                            ),
                          )
                          : const SizedBox(),
                      controller.strengthSearchFocusNode.value.hasFocus
                          ? commonDropdown(appStrings.searchStrengths,controller.getStrengthMetaData.value.data?.docs,controller.selectedSelectStrength,(controller.getStrengthMetaData.value.data?.docs?.length??0)<=5?5:0)
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Text(
                        appStrings.softSkills,
                        style: TextStyle(
                            color: appColors.contentPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      commonSearchField(
                        controller.skillSearchController.value,
                        controller.skillSearchFocusNode.value,
                        w,
                        (value) {},
                        hint: appStrings.searchSoftSkills,
                        contentPadding: 14,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          RemoveTrailingPeriodsFormatter(),
                          SpecialCharacterValidator(),
                          EmojiInputFormatter(),
                          LengthLimitingTextInputFormatter(30)
                        ],
                      ),
                      controller.selectedSkillStrength.isNotEmpty
                          ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Wrap(
                        spacing: 6.0,
                        runSpacing: 8.0,
                        children: controller.selectedSkillStrength.map((filter) {
                          return commonButtonFilters(
                            appColors.buttonStateDisabled,
                            appColors.contentPrimary,
                            fontSize: 14,
                                () {
                              controller.selectedSkillStrength.remove(filter);
                            },
                            hint: filter,
                            borderColor: appColors.contentPrimary,
                          );
                        }).toList(),
                          ),)
                          : const SizedBox(),
                      controller.skillSearchFocusNode.value.hasFocus
                          ? commonDropdown(appStrings.searchSoftSkills,controller.getSoftSkillMetaData.value.data?.docs,controller.selectedSkillStrength,(controller.getSoftSkillMetaData.value.data?.docs?.length??0)<=5?5:0)
                          : const SizedBox(),
                      SizedBox(
                        height: h * 0.15,
                      ),
                      commonButton(double.infinity, 50,
                          appColors.contentAccent, Colors.white,
                          hint: appStrings.submit, () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return RoadMapDialogBox(
                              title: appImages.introductionVideo,
                              message: appStrings.privacyPolicy,
                              hintButton: appStrings.uploadResult,
                              height: h,
                              hintCompleteButton: appStrings.markAsComplete,
                              onComplete: () {},
                              openVideo: () {},
                              icon: appImages.inHouseVideo,
                            );
                          },
                        );
                      }),
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

  Widget commonDropdown(String title,hint,selected,int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    color: appColors.contentPrimary,
                    fontFamily: appFonts.NunitoRegular,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 1.5,
              height: 1.5,
              color: appColors.border,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                appStrings.coachRecommendation,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: appFonts.NunitoBold,
                    color: appColors.contentAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              child: Wrap(
                spacing: 6.0,
                runSpacing: -2.0,
                children: List.generate(number, (index) {
                  return commonButtonWithoutWidth(
                    Colors.white,
                    appColors.contentPrimary,
                        () {
                      if (!selected.contains(hint[index].name)) {
                        selected.add(hint[index].name);
                      }
                    },
                    radius: 8,
                    padding: 0,
                    fontSize: 15,
                    borderColor: appColors.border,
                    hint: hint[index].name,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 5),
            Divider(
              thickness: 1.5,
              height: 1.5,
              color: appColors.border,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                appStrings.otherCareerPaths,
                style: TextStyle(
                    fontSize: 14,
                    color: appColors.contentPrimary,
                    fontFamily: appFonts.NunitoRegular,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Wrap(
                spacing: 8.0,
                runSpacing: -2.0,
                children: List.generate(hint.length-number, (index){
                  return commonButtonWithoutWidth(
                    Colors.white, appColors.contentPrimary, () {
                    if (!selected.contains(hint[index+number].name)) {
                      selected.add(hint[index+number].name);
                    }
                  },
                    radius: 8,
                    padding: 0,
                    fontSize: 15,
                    borderColor: appColors.border,
                    hint: hint[index+number].name,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

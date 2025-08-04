import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vroar/common/common_widgets.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/routes/routes_class.dart';

import '../../common/app_constants_list.dart';
import '../../common/common_shimmer.dart';
import '../../common/gradient.dart';
import '../../data/response/status.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';
import '../controller/mentor_schedule_controller.dart';
import '../../utils/sized_box_extension.dart';

class MentorScheduleScreen extends ParentWidget {
  const MentorScheduleScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    MentorScheduleController controller = Get.put(MentorScheduleController());
    return GetBuilder<MentorScheduleController>(
        init: MentorScheduleController(),
        initState: (state) {
          if (state.mounted) controller.getMentorListApi();
        },
        builder: (controller) {
          return  Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            leading: InkWell(onTap: (){
              controller.mainController.selectedIndex.value = 0;
              controller.searchController.value.text="";
            } , child: Icon(Icons.arrow_back_ios, size: 20, color: appColors.contentPrimary)),
            title: Text(appStrings.mentors, style: TextStyle(fontSize: 24, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(controller.applyFilters.value ? 130 : 65),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonSearchField(
                      controller.searchController.value,
                      controller.searchFocusNode.value,
                      double.infinity,
                          (value) {},
                      onChange: (value){
                        controller.searchMentors(value);
                      },
                      hint: appStrings.searchMentor,
                      contentPadding: 14,
                      inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(30)],
                    ),
                    // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    //   commonSearchField(
                    //     controller.searchController.value,
                    //     controller.searchFocusNode.value,
                    //     w * 0.76,
                    //     (value) {},
                    //     onChange: (value){
                    //       controller.searchMentors(value);
                    //     },
                    //     hint: appStrings.searchMentor,
                    //     contentPadding: 14,
                    //     inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(30)],
                    //   ),
                    //   InkWell(
                    //       onTap: () => showFilterDialog(context, w),
                    //       child: Container(
                    //           width: w * 0.145,
                    //           height: 52,
                    //           decoration:
                    //               BoxDecoration(color: controller.applyFilters.value ? appColors.contentPrimary : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: controller.applyFilters.value ? appColors.contentPrimary : appColors.border)),
                    //           child: Icon(Icons.filter_list, color: controller.applyFilters.value ? Colors.white : appColors.contentPrimary, size: 30)))
                    // ]),
                    controller.applyFilters.value
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: controller.selectedFiltersButton.map((filter) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0, bottom: 2.0, top: 15.0),
                                  child: commonButtonFilters(
                                    appColors.buttonStateDisabled,
                                    appColors.contentPrimary,
                                    () {
                                      controller.selectedFilters.remove(filter);
                                      controller.selectedFiltersButton.remove(filter);
                                      if (controller.selectedFilters.isEmpty && controller.selectedFiltersButton.isEmpty) {
                                        controller.applyFilters.value = false;
                                      }
                                    },
                                    hint: filter,
                                    borderColor: appColors.contentPrimary,
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            )),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            // width: w,
            height: h*0.92,
            decoration: BoxDecoration(gradient: AppGradients.customGradient),
            padding: const EdgeInsets.only(top: 18.0, left: 16, right: 16),
            child:controller.mentorListData.value.data==null ?ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(top: 5),
              shrinkWrap: true,
              itemCount:3,
              itemBuilder: (BuildContext context, int index) {
                return mentorCardShimmer(h, w);
              },
            ): ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(top: 5),
              shrinkWrap: true,
              itemCount:controller.filteredMentors.isNotEmpty? controller.filteredMentors.length:1,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {if(controller.rxRequestStatus.value==Status.COMPLETED){
                  Get.toNamed(RoutesClass.mentorDetails,arguments: controller.filteredMentors[index].id);
                }},
                  child:controller.filteredMentors.isNotEmpty?mentorCard(h, w,index):Center(
                    heightFactor: 1.5,
                    child:Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Lottie.asset(appImages.dataNotFound),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );});
  }

  Widget mentorCard(h, w,index) {
    MentorScheduleController controller = Get.put(MentorScheduleController());
    return Obx(()=> Container(
      //constraints: BoxConstraints(minHeight: h * 0.25),
      width: w,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: appColors.border)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipOval(child:controller.filteredMentors[index].avatar?.isNotEmpty??false?Image.network(controller.filteredMentors[index].avatar??"", width: 50, height: 50, fit: BoxFit.contain): Image.asset(appImages.abram, width: 50, height: 50, fit: BoxFit.contain)),
            10.kW,
            Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${controller.filteredMentors[index].firstName??""} ${controller.filteredMentors[index].lastName??""}", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary, fontSize: 16)),
              2.kH,
              Text(controller.filteredMentors[index].designation??"", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 12))
            ])),
            Padding(padding: const EdgeInsets.all(10), child: Icon(Icons.arrow_forward_ios, size: 22, color: appColors.contentSecondary))
          ]),
          10.kH,
          controller.filteredMentors[index].totalExperience!=null?
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SvgPicture.asset(appImages.officeIcon),
            10.kW,
            Text(controller.filteredMentors[index].currentCompany??"", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 12)),
            10.kW,
            SvgPicture.asset(appImages.experienceIcon),
            10.kW,
            Text("${controller.filteredMentors[index].totalExperience??""} yrs", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 12))
          ]):Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SvgPicture.asset(appImages.schoolIcon),
            10.kW,
            Text(controller.filteredMentors[index].currentCompany??"", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 12)),
          ]),
          if(controller.filteredMentors[index].skills?.isNotEmpty??false)...[
          Padding(padding: const EdgeInsets.symmetric(vertical: 5.0), child: Divider(thickness: 1, color: appColors.border)),
          Text(appStrings.topSkills, style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary, fontSize: 12)),
          10.kH,
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                controller.filteredMentors[index].skills?.length??
                    0,
                    (index1) => commonColorTags(
                    AppConstantsList.randomButton[
                    index1 %
                        AppConstantsList
                            .randomButton
                            .length]["light"],
                    AppConstantsList.randomButton[
                    index1 %
                        AppConstantsList
                            .randomButton
                            .length]["dark"],
                    hint: controller.filteredMentors[index].skills?[index1] ??
                        "",
                    radius: 8,
                    padding: 8,),
              )),],
        ],
      ),
    ),);
  }

  void showFilterDialog(context, w) {
    MentorScheduleController controller = Get.put(MentorScheduleController());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: SizedBox(
            width: w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 12),
                  child: Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentPrimary,
                      fontFamily: appFonts.NunitoBold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Divider(thickness: 1, color: appColors.border),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Industry",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentPrimary,
                      fontFamily: appFonts.NunitoRegular,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                            () => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                           controller. toggleFilter(controller. filters[index]);
                          },
                          child: Row(
                            children: [
                              checkBox(
                               controller. selectedFilters.contains(controller.filters[index]),
                                1,
                                4.21,
                                1.3,
                                Colors.white,
                                Colors.black,
                                Colors.white,
                                controller.  selectedFilters.contains(controller. filters[index]) ? Colors.black : appColors.border,
                                    (bool? value) {
                                      controller. toggleFilter(controller. filters[index]);
                                },
                              ),
                              const SizedBox(width: 10),
                              Text(
                                controller.  filters[index],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.contentPrimary,
                                  fontFamily: appFonts.NunitoMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Divider(thickness: 1, color: appColors.border),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Career",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentPrimary,
                      fontFamily: appFonts.NunitoRegular,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                            () => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.  toggleFilter(controller. filters[index + 3]);
                          },
                          child: Row(
                            children: [
                              checkBox(
                                controller.  selectedFilters.contains(controller. filters[index + 3]),
                                1,
                                4.21,
                                1.3,
                                Colors.white,
                                Colors.black,
                                Colors.white,
                                controller.  selectedFilters.contains(controller. filters[index + 3]) ? Colors.black : appColors.border,
                                    (bool? value) {
                                      controller.  toggleFilter(controller. filters[index + 3]);
                                },
                              ),
                              const SizedBox(width: 10),
                              Text(
                                controller.  filters[index + 3],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.contentPrimary,
                                  fontFamily: appFonts.NunitoMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Divider(thickness: 1, color: appColors.border),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonButton(w * 0.23, 45, Colors.white, appColors.contentAccent, hint: "Close", borderColor: appColors.contentAccent, () {
                        Navigator.pop(context);
                      }),
                      commonButton(w * 0.35, 45, appColors.contentAccent, Colors.white, hint: "Apply Filters", () {
                        Navigator.pop(context);
                        if (controller. selectedFilters.isNotEmpty) {
                          controller. selectedFiltersButton.clear();
                          controller. selectedFiltersButton.addAll(controller. selectedFilters);
                          controller. applyFilters.value = true;
                        } else {
                          controller.  applyFilters.value = false;
                        }
                        print(controller. applyFilters.value);
                        print(controller. selectedFilters);
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

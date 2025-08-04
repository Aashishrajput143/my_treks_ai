import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vroar/common/common_shimmer.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../../resources/strings.dart';
import '../controller/courses_controller.dart';

class CoursesScreen extends ParentWidget {
  const CoursesScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    CoursesController controller = Get.put(CoursesController());
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 50,
          title: Text(
            appStrings.courses,
            style: TextStyle(
              fontSize: 24,
              fontFamily: appFonts.NunitoBold,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: GetBuilder<CoursesController>(
            init: CoursesController(),
            initState: (state) {
                controller.getCoursesApi(
                    controller.mainController.getProfileData.value.data?.id,controller.reloadData.value);
            },
            builder: (controller) {
              return Obx(() => SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: RefreshIndicator(
                      color: Colors.brown,
                      onRefresh: controller.coursesRefresh,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: !controller.haveData.value
                            ? Column(
                                children: List.generate(
                                  8,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: shimmerRoundedLine(w, 50),
                                  ),
                                ),
                              )
                            : controller.getAllRoadMapData.value.data?.docs?.isNotEmpty??false
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.getAllRoadMapData
                                            .value.data?.docs?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Obx(() => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              title(
                                                  controller
                                                              .getAllRoadMapData
                                                              .value
                                                              .data
                                                              ?.docs?[index]
                                                              .metadataTags?[0]
                                                              .type ==
                                                          "CAREER"
                                                      ? appImages
                                                          .roadMapCareerIcon
                                                      : controller
                                                                  .getAllRoadMapData
                                                                  .value
                                                                  .data
                                                                  ?.docs?[index]
                                                                  .metadataTags?[
                                                                      0]
                                                                  .type ==
                                                              "STRENGTHS"
                                                          ? appImages
                                                              .roadMapStrengthIcon
                                                          : controller
                                                                      .getAllRoadMapData
                                                                      .value
                                                                      .data
                                                                      ?.docs?[
                                                                          index]
                                                                      .metadataTags?[
                                                                          0]
                                                                      .type ==
                                                                  "INDUSTRY"
                                                              ? appImages
                                                                  .roadMapIndustryIcon
                                                              : appImages
                                                                  .roadMapBottleIcon,
                                                  controller
                                                          .getAllRoadMapData
                                                          .value
                                                          .data
                                                          ?.docs?[index]
                                                          .name ??
                                                      "", () {
                                                controller.activeNodes[index]
                                                        .value =
                                                    !controller
                                                        .activeNodes[index]
                                                        .value;
                                              },
                                                  controller.activeNodes[index]
                                                      .value),
                                              controller
                                                      .activeNodes[index].value
                                                  ? ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                              .getAllRoadMapData
                                                              .value
                                                              .data
                                                              ?.docs?[index]
                                                              .roadmapSteps
                                                              ?.length ??
                                                          0,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              Divider(
                                                        thickness: 1,
                                                        height: 1,
                                                        color: appColors.border,
                                                      ),
                                                      itemBuilder:
                                                          (context, ind) {
                                                        return content(
                                                          false,
                                                          ind + 1,
                                                          controller
                                                                  .getAllRoadMapData
                                                                  .value
                                                                  .data
                                                                  ?.docs?[index]
                                                                  .roadmapSteps?[
                                                                      ind]
                                                                  .name ??
                                                              "",
                                                        );
                                                      },
                                                    )
                                                  : const SizedBox(),
                                              if (index !=
                                                  (controller
                                                              .getAllRoadMapData
                                                              .value
                                                              .data
                                                              ?.docs
                                                              ?.length ??
                                                          0) -
                                                      1)
                                                Divider(
                                                  thickness: 1.5,
                                                  height: 1.5,
                                                  color: appColors.border,
                                                ),
                                            ],
                                          ));
                                    },
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: h * 0.05),
                                    child: Column(
                                      children: [
                                        Lottie.asset(appImages.noData),
                                        Text(
                                          appStrings.coursesNotFound,
                                          style: TextStyle(
                                            fontSize: 27,
                                            color: appColors.contentAccent,
                                            fontFamily: appFonts.NunitoBold,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        8.kH,
                                        Text(
                                          appStrings.coursesDesc,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: appColors.contentPrimary,
                                            fontFamily: appFonts.NunitoMedium,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                      ),
                    ),
                  ));
            }
            //progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
            // internetException(
            //     controller.rxRequestStatus.value == Status.ERROR &&
            //         controller.error.value.toString() == "No internet",
            //         () {}),
            // generalException(
            //     controller.rxRequestStatus.value == Status.ERROR &&
            //         controller.error.value.toString() != "No internet",
            //         () {}),
            ));
  }

  Widget title(String icon, String title, void Function()? onTap, bool open) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          splashColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(icon),
          title: Text(
            title,
            style: TextStyle(
              fontSize:Get.height>=677? 20:16,
              color: appColors.contentPrimary,
              fontFamily: appFonts.NunitoBold,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing:
              Icon(open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
          onTap: onTap),
    );
  }

  Widget content(bool isDocs, int title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListTile(
        leading: Container(
            width: 50, // Adjust size as needed
            height: 50,
            decoration: BoxDecoration(
              color: appColors.coursesContentColor, // Circle color
              shape: BoxShape.circle, // Makes it a circle
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 12, bottom: 12),
              child: SvgPicture.asset(
                isDocs ? appImages.document : appImages.playIcon,
                width: 15,
                height: 15,
              ),
            )),
        title: Text(
          "Tile $title",
          style: TextStyle(
            fontSize: 17,
            color: appColors.contentAccent,
            fontFamily: appFonts.NunitoBold,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: appColors.contentPrimary,
            fontFamily: appFonts.NunitoMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/sized_box_extension.dart';
import '../../../resources/colors.dart';
import '../../../resources/font.dart';
import '../../../resources/images.dart';
import '../../../utils/utils.dart';
import '../../controller/roadmap_controllers/roadmap_controller.dart';

class RoadMapPathToggleBox extends StatelessWidget {
  const RoadMapPathToggleBox({super.key});

  @override
  Widget build(BuildContext context) {
    final RoadmapController roadmapController = Get.put(RoadmapController());
    Widget title(String icon, String title, void Function()? onTap, bool isOpen) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
          child: ListTile(
              splashColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(icon),
              title: Text(title, style: TextStyle(fontSize: 20, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500)),
              trailing: Icon(isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: appColors.contentAccent, size: 35),
              onTap: onTap));
    }

    Widget content(String score, String title, void Function()? onTap) {
      return GestureDetector(
          onTap: onTap,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Flexible(child: Text(title, style: TextStyle(fontSize: 17, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500))),
                16.kW,
                Text(score, style: TextStyle(fontSize: 17, color: appColors.contentAccent, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500))
              ])));
    }

    final keys = roadmapController.filteredData.keys.toList();

    String getTitleText(String key) {
      switch (key) {
        case "CAREER":
          return "Career Path";
        case "INDUSTRY":
          return "Industry Exploration";
        case "STRENGTHS":
          return "Strengths";
        case "SOFT SKILLS":
          return "Soft Skills";
        default:
          return "";
      }
    }

    return Stack(children: [
      Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: const EdgeInsets.only(bottom: 180, left: 10, right: 10),
          backgroundColor: Colors.transparent,
          child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                maxWidth: MediaQuery.of(context).size.width * 0.92,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white, border: Border.all(color: appColors.contentAccent, width: 3)),
              //width: 380,
              child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: keys.length,
                      itemBuilder: (BuildContext context, int index) {
                        final key = keys[index];
                        Utils.printLog(key);
                        final items = roadmapController.filteredData[key]!;
                        Utils.printLog(roadmapController.filteredData.length);
                        return Obx(() => Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              title(
                                  key == "INDUSTRY"
                                      ? appImages.roadMapIndustryIcon
                                      : key == "CAREER"
                                          ? appImages.roadMapCareerIcon
                                          : key == "STRENGTHS"
                                              ? appImages.roadMapStrengthIcon
                                              : appImages.roadMapBottleIcon,
                                  getTitleText(key), () {
                                if (roadmapController.activeNodes[index].value == true) {
                                  roadmapController.activeNodes[index].value = !roadmapController.activeNodes[index].value;
                                } else {
                                  for (int i = 0; i < roadmapController.activeNodes.length; i++) {
                                    roadmapController.activeNodes[i].value = (i == index);
                                  }
                                }
                              }, roadmapController.activeNodes[index].value),
                              roadmapController.activeNodes[index].value
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: items.length ?? 0,
                                          separatorBuilder: (context, ind) {
                                            if (ind == items.length - 1) {
                                              return const SizedBox();
                                            }
                                            return Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: appColors.border,
                                            );
                                          },
                                          itemBuilder: (context, ind) {
                                            final item = items[ind];
                                            return content("(${item["completed"]}/${item["totalStep"]})", item["name"] ?? "", () {
                                              Get.back();
                                              roadmapController.currRoadmapId.value = item["id"] ?? "";
                                              roadmapController.currRoadmapJourneyId.value = item["journeyId"] ?? "";
                                              roadmapController.currRoadmapCompeletedSteps.value = item["completed"] ?? 0;
                                              roadmapController.currRoadmapMetadata.value = key;
                                              roadmapController.getRoadmapApi(isChangeRoadmap: true);
                                              Utils.printLog("trackLevel.value==currRoadmapLevelLength.value===>${item["completed"] == item["totalStep"]}");
                                              if (item["completed"] == item["totalStep"]) {
                                                roadmapController.isRoadMapCompleted.value = true;
                                              }
                                              // roadmapController.switchRoadmap(item["id"]);
                                            });
                                          }))
                                  : const SizedBox(),
                              index != (roadmapController.filteredData.length) - 1 ? Divider(thickness: 1.5, height: 1.5, color: appColors.border) : const SizedBox()
                            ]));
                      })))),
      Positioned(
          right: 25,
          bottom: 93,
          child: GestureDetector(onTap: () => Get.back(), child: Container(width: 65, height: 65, decoration: BoxDecoration(color: appColors.contentAccent, borderRadius: const BorderRadius.all(Radius.circular(50))), child: const Icon(Icons.close, color: Colors.white, size: 30))))
    ]);
  }
}

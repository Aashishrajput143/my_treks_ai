import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/font.dart';

import '../../common/tab_indicator.dart';
import '../../main.dart';
import '../../resources/colors.dart';
import '../controller/common_screen_controller.dart';

class CommonScreen extends ParentWidget {
  const CommonScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    CommonScreenController controller = Get.put(CommonScreenController());
    return controller.role.value == "PARENT" ? controller.parentPages[controller.selectedIndex.value] : controller.pages[controller.selectedIndex.value];
  }

  @override
  Widget build(BuildContext context) {
    CommonScreenController controller = Get.put(CommonScreenController());
    return Obx(
      () => Scaffold(
        // backgroundColor: controller.selectedIndex.value == 1 || controller.selectedIndex.value == 16 ? Colors.lightGreen : Colors.white,
        body: super.build(context),
        bottomNavigationBar: Stack(clipBehavior: Clip.antiAlias, children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 4, offset: const Offset(0, -2))]),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: Theme(
                data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashFactory: NoSplash.splashFactory),
                child: BottomNavigationBar(
                  items: controller.role.value == "PARENT" ? controller.parentBottomNavigationItems : controller.bottomNavigationItems,
                  currentIndex: controller.role.value == "PARENT" ? controller.changeParentIndex() : controller.changeIndex(),
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: TextStyle(fontSize: 12, color: appColors.contentAccent, fontFamily: appFonts.NunitoBold),
                  iconSize: 28,
                  selectedIconTheme: IconThemeData(size: 28, color: appColors.contentAccent),
                  unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: appFonts.NunitoRegular, color: appColors.buttonTextStateDisabled),
                  selectedItemColor: appColors.contentAccent,
                  onTap: (index) {
                    if (controller.getProfileData.value.data?.email?.isNotEmpty ?? false) {
                      controller.selectedIndex.value = index;
                    }
                  },
                  elevation: 0.0,
                ),
              ),
            ),
          ),
          TabIndicators(
              onTap: (index) {
                controller.selectedIndex.value = index;
              },
              activeIdx: controller.role.value == "PARENT" ? controller.changeParentIndex() : controller.changeIndex(),
              activeColor: appColors.contentAccent,
              numTabs: controller.role.value == "PARENT" ? 3 : 5,
              padding: 8,
              height: 30)
        ]),
      ),
    );
  }
}

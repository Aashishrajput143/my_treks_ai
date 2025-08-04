import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vroar/modules/screen/roadmap/roadmap_screen.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';

import '../../../resources/images.dart';
import '../../controller/roadmap_controllers/roadmap_showcase_controller.dart';

class RoadmapShowcase extends StatelessWidget {
  const RoadmapShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final RoadmapShowcaseController controller = Get.put(RoadmapShowcaseController());
    return Scaffold(
        body: ShowCaseWidget(
          hideFloatingActionWidgetForShowcase: [controller.lastShowcaseWidget],
          globalFloatingActionWidget: (showcaseContext) => controller.isShowcasingList[0].value? FloatingActionWidget(
            left:140,
            top: 90,
            child: SvgPicture.asset(
              appImages.handLeft,
              width: 100,
              height: 100,
            ),
          ):controller.isShowcasingList[1].value?FloatingActionWidget(
            right:100,
            top: 90,
            child: SvgPicture.asset(
              appImages.handRight,
              width: 100,
              height: 100,
            ),
          ):FloatingActionWidget(
            right:70,
            bottom: 50,
            child: SvgPicture.asset(
              appImages.handRight,
              width: 100,
              height: 100,
            ),
          ),
          onStart: (index, key) {
            log('onStart: $index, $key');
            controller.isShowcasingList[index??0].value=true;
          },
          onComplete: (index, key) {
            log('onComplete: $index, $key');
            controller.isShowcasingList[index??0].value=false;
            if (index == 4) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.light.copyWith(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
              );
            }
          },
          blurValue: 0.1,
          autoPlayDelay: const Duration(seconds: 3),
          builder: (context) => const RoadmapScreen(),
          globalTooltipActionConfig: const TooltipActionConfig(
            position: TooltipActionPosition.inside,
            alignment: MainAxisAlignment.end,
            gapBetweenContentAndAction: 10,
            actionGap: 20,
          ),
          globalTooltipActions: [
            // Here we don't need previous action for the first showcase widget
            // so we hide this action for the first showcase widget
            // TooltipActionButton(
            //   name: "Skip",
            //   type: TooltipDefaultActionType.previous,
            //   backgroundColor: Colors.white,
            //   leadIcon: ActionButtonIcon(icon: Icon(
            //     Icons.arrow_back_ios,
            //     size: 14,
            //     color: appColors.contentAccent,
            //   ),),
            //   textStyle:  TextStyle(
            //     color: appColors.contentAccent,
            //     fontWeight: FontWeight.w600,
            //     fontFamily: appFonts.NunitoBold,
            //     fontSize: 14,
            //   ),
            //   hideActionWidgetForShowcase: [controller.firstShowcaseWidget],
            // ),
            // Here we don't need next action for the last showcase widget so we
            // hide this action for the last showcase widget
            TooltipActionButton(
              name: "Skip",
              type: TooltipDefaultActionType.next,
              backgroundColor: Colors.white,
              tailIcon: ActionButtonIcon(icon: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: appColors.contentAccent,
              ),),
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:appColors.contentAccent,
                fontFamily: appFonts.NunitoBold,
              ),
              hideActionWidgetForShowcase: [controller.lastShowcaseWidget],
            ),
          ],
        ),
    );
  }
}
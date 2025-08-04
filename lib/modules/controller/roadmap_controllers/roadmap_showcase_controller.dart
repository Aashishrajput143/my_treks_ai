import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vroar/modules/controller/roadmap_controllers/roadmap_controller.dart';

class RoadmapShowcaseController extends GetxController {
  final GlobalKey firstShowcaseWidget = GlobalKey();
  final GlobalKey lastShowcaseWidget = GlobalKey();
  var isShowcasingList = List.generate(4, (_) => false.obs).obs;

  Future<void> checkAndShowShowcase(BuildContext context, RoadmapController roadmapController) async {
     final prefs = await SharedPreferences.getInstance();
     final hasShown = prefs.getBool('hasShownShowcase') ?? false;
    //const hasShown = false;

    if (!hasShown) {
      // Delay to ensure the widget tree is fully built
      WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context).startShowCase([
          firstShowcaseWidget,
          roadmapController.two,
          roadmapController.three,
          roadmapController.four,
          lastShowcaseWidget
        ]),
      );
      await prefs.setBool('hasShownShowcase', true);
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/strings.dart';

import '../../../common/common_methods.dart';
import '../../../resources/validator.dart';
import '../common_screen_controller.dart';
import 'roadmap_controller.dart';

class WriteAssignmentController extends GetxController {
  RxBool showLoader = false.obs;
  var descriptionController = TextEditingController().obs;
  var descriptionFocusNode = FocusNode().obs;
  final RoadmapController roadmapController = Get.put(RoadmapController());
  final CommonScreenController mainController = Get.put(CommonScreenController());

  onSubmit() async {
    showLoader.value = true;
    update();
    if (Validator.validateInput(descriptionController.value.text) == null && descriptionController.value.text.length > 10) {
      var markCompleted = await roadmapController.markLevelCompleted(roadmapController.currIndex.value, roadmapController.currStepId.value, roadmapController.currRoadmapId.value, answer: descriptionController.value.text);
      // mainController.selectedIndex.value = 1;
      if (markCompleted) {
        showLoader.value = false;
        roadmapController.openRoadmapOnScreenSchnge();
        descriptionController.value.text = '';
        update();
      } else {
        showLoader.value = false;
        update();
      }
      roadmapController.changeRoadMap(roadmapController.trackLevel.value,roadmapController.currRoadmapLevelLength.value);
      // Get.back(closeOverlays: true);
    } else {
      showLoader.value = false;
      update();
      CommonMethods.showToast(descriptionController.value.text.length < 10 ? appStrings.assignmentTextLenthError : appStrings.writeAssignmentText);
    }
  }
}

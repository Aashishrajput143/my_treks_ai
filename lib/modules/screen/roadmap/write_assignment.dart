import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/my_utils.dart';

import '../../../main.dart';
import '../../../resources/colors.dart';
import '../../../resources/font.dart';
import '../../../utils/sized_box_extension.dart';
import '../../../common/common_widgets.dart';
import '../../../resources/strings.dart';
import '../../controller/roadmap_controllers/write_assignment_controller.dart';

class WriteAssignmentScreen extends ParentWidget {
  const WriteAssignmentScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    WriteAssignmentController controller = Get.put(WriteAssignmentController());
    return Obx(() {
      return Stack(children: [
        Scaffold(
          appBar: AppBar(
              surfaceTintColor: Colors.white,
              automaticallyImplyLeading: true,
              centerTitle: true,
              toolbarHeight: 80,
              title: Text(appStrings.writeAssignmentHere, style: TextStyle(fontSize: 24, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              leading: InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios, size: 20, color: appColors.contentPrimary))),
          body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                  width: w,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    commonDescriptionTextField(controller.descriptionController.value, controller.descriptionFocusNode.value, w, (value) {}, hint: appStrings.typeYourAssignment, maxLines: 22, minLines: 13),
                    26.kH,
                  ]))),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 90,
            child: Column(
              children: [
                commonButton(double.infinity, h * 0.05, appColors.contentAccent, Colors.white, hint: appStrings.submit, () => controller.onSubmit()),
              ],
            ),
          ),
        ),
        progressBar(controller.showLoader.isTrue, h, w),
        // internetException(
        //     controller.rxRequestStatus.value == Status.ERROR &&
        //         controller.error.value.toString() == "No internet",
        //         () {}),
        // generalException(
        //     controller.rxRequestStatus.value == Status.ERROR &&
        //         controller.error.value.toString() != "No internet",
        //         () {}),
      ]);
    });
  }
}

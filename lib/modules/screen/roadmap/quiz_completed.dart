import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/roadmap_controllers/quiz_completed_controller.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/routes/routes_class.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../../../common/common_widgets.dart';
import '../../../common/my_utils.dart';
import '../../../data/response/status.dart';
import '../../../resources/strings.dart';
import '../../controller/roadmap_controllers/roadmap_controller.dart';

class QuizCompletedScreen extends ParentWidget {
  const QuizCompletedScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final QuizCompletedController quizCompletedController = Get.put(QuizCompletedController());
    final RoadmapController roadmapController = Get.put(RoadmapController());
    return Obx(() => Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: quizCompletedController.rxRequestStatus.value == Status.COMPLETED
                  ? SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: w,
                          height: h * 0.54,
                          decoration: BoxDecoration(
                            image: DecorationImage(alignment: Alignment.center, image: AssetImage(appImages.assessmentBackground), fit: BoxFit.fill),
                            boxShadow: const [BoxShadow(color: Colors.white, spreadRadius: 30, blurRadius: 50, offset: Offset(3, 3))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              h <= 677 ? 20.kH : 70.kH,
                              Text(
                                appStrings.quizCompleted,
                                style: TextStyle(fontSize: 32, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentAccent),
                              ),
                              h <= 677 ? 20.kH : 40.kH,
                              Center(
                                child: Lottie.asset(appImages.trophy, height: h * 0.2, repeat: false),
                              ),
                            ],
                          ),
                        ),
                        h <= 677 ? 0.kH : 40.kH,
                        Text(
                          appStrings.congratulations,
                          style: TextStyle(fontSize: 32, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentAccent),
                        ),
                        10.kH,
                        if (quizCompletedController.quizResultData.value.data?.quizResult?[0].questionType != "Subjective") ...[
                          Text(
                            appStrings.yourScore,
                            style: TextStyle(fontSize: 24, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentSecondary),
                          ),
                          10.kH,
                          Text(
                            "${quizCompletedController.correctAnswer.value}/${quizCompletedController.totalQuestion.value}",
                            style: TextStyle(fontSize: 44, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentAccent),
                          ),
                        ],
                        if (quizCompletedController.quizResultData.value.data?.quizResult?[0].questionType == "Subjective") ...[
                          Text(
                            appStrings.yourAnswerSubmitted,
                            style: TextStyle(fontSize: 24, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        10.kH,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                          child: commonButton(double.infinity, 55, Colors.white, appColors.contentAccent, borderColor: appColors.contentAccent, hint: appStrings.moveToNextLevelButton, () {
                            Get.back(closeOverlays: true);
                            Get.back();
                            roadmapController.changeRoadMap(roadmapController.trackLevel.value,roadmapController.currRoadmapLevelLength.value);
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                          child: commonButton(double.infinity, 55, appColors.contentAccent, Colors.white, hint: (quizCompletedController.quizResultData.value.data?.quizResult?[0].questionType == "Subjective") ? appStrings.reviewAnswersButton : appStrings.reviewAllAnswersButton,
                              () {
                            Get.toNamed(RoutesClass.quizAnswersScreen, arguments: quizCompletedController.quizId.value);
                          }),
                        )
                      ],
                    ),
                  )
                  : Container(height: h, width: w, color: Colors.white),
            ),
            customProgressBarTransparent(quizCompletedController.rxRequestStatus.value == Status.LOADING, h, w)
          ],
        ));
  }
}

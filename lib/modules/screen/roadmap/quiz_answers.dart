import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/utils/sized_box_extension.dart';

import '../../../common/common_widgets.dart';
import '../../../common/my_utils.dart';
import '../../../data/response/status.dart';
import '../../../resources/strings.dart';
import '../../controller/roadmap_controllers/quiz_answers_controller.dart';

class QuizAnswersScreen extends ParentWidget {
  const QuizAnswersScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    QuizAnswersController controller = Get.put(QuizAnswersController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              centerTitle: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: RichText(
                text: TextSpan(
                  text: "${((controller.currentIndex.value) + 1).toString().padLeft(2, '0')} ",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: appFonts.NunitoMedium,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: appColors.contentAccent,
                  ),
                  children: [
                    TextSpan(
                      text: " of  ${(controller.quizResultData.value.data?.quizResult?.length ?? 0).toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: appFonts.NunitoMedium,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: appColors.buttonTextStateDisabled,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressBar(
                    maxSteps: controller.quizResultData.value.data?.quizResult?.length ?? 1,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: controller.currentIndex.value + 1,
                    progressColor: appColors.contentAccent,
                    backgroundColor: appColors.buttonStateDisabled,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  10.kH,
                  Container(
                    height: h * 0.68,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            controller.quizResultData.value.data?.quizResult?[controller.currentIndex.value].questionText ?? "",
                            style: TextStyle(fontSize: 20, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
                          ),
                          const SizedBox(height: 20),
                          controller.quizResultData.value.data?.quizResult?[controller.currentIndex.value].questionType != "Subjective"
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.quizResultData.value.data?.quizResult?[controller.currentIndex.value].selectedOptions?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return radioButtonAnswersObjective(
                                      controller.quizResultData.value.data?.quizResult?[controller.currentIndex.value].selectedOptions?[index].isSelected ?? false,
                                      controller.quizResultData.value.data?.quizResult?[controller.currentIndex.value].selectedOptions?[index].isCorrect ?? false,
                                      controller.quizResultData.value.data?.quizResult?[controller.currentIndex.value].selectedOptions?[index].optionText ?? "",
                                    );
                                  },
                                )
                              : Text(
                                  textAlign: TextAlign.start,
                                  "Answer : ${controller.quizResultData.value.data?.quizResult?[controller.currentIndex.value].answerText ?? ""}",
                                  style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
                                ),
                        ],
                      ),
                    ),
                  ),
                  16.kH,
                  if (controller.currentIndex.value == 0) ...[
                    Align(
                        alignment: Alignment.bottomRight,
                        child: commonButtonIcon(w * 0.43, 55, appColors.contentAccent, Colors.white, () {
                          if ((controller.quizResultData.value.data?.quizResult?.length ?? 2) - 1 != controller.currentIndex.value) {
                            controller.forwardPage();
                          } else {
                            Get.back();
                            // controller.currentIndex.value = 0;
                          }
                        }, hint: controller.currentIndex.value == ((controller.quizResultData.value.data?.quizResult?.length ?? 0) - 1) ? appStrings.exit : appStrings.nextButton))
                  ],
                  if ((controller.currentIndex.value > 0 && (controller.currentIndex.value) <= (controller.quizResultData.value.data?.quizResult?.length ?? 2) - 1)) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonButtonIcon(w * 0.43, 55, Colors.white, appColors.contentAccent, () {
                          controller.backPage();
                        }, hint: appStrings.previous, icon: Icons.arrow_back_ios, forward: false, borderColor: appColors.contentAccent),
                        commonButtonIcon(w * 0.43, 55, appColors.contentAccent, Colors.white, () {
                          if ((controller.quizResultData.value.data?.quizResult?.length ?? 2) - 1 != controller.currentIndex.value) {
                            controller.forwardPage();
                          } else {
                            Get.back();
                            // controller.currentIndex.value = 0;
                          }
                        }, hint: (controller.quizResultData.value.data?.quizResult?.length ?? 2) - 1 != controller.currentIndex.value ? appStrings.nextButton : appStrings.exit)
                      ],
                    )
                  ],
                ],
              ),
            ),
          ),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w)
        ],
      ),
    );
  }
}

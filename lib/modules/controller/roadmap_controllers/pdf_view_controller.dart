import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../routes/routes_class.dart';
import '../common_screen_controller.dart';
import '../../../modules/controller/roadmap_controllers/roadmap_controller.dart';

class PdfViewController extends GetxController {
  dynamic arguments = Get.arguments;
  final Completer<PDFViewController> controller = Completer<PDFViewController>();
  CommonScreenController commonScreenController = Get.put(CommonScreenController());
  RoadmapController roadmapController = Get.put(RoadmapController());
  late PDFViewController pdfViewController;
  RxInt? pages = 0.obs;
  RxInt? currentPage = 0.obs;
  RxBool isReady = false.obs;
  RxBool isFullScreen = false.obs;
  RxString errorMessage = ''.obs;
  RxString localFilePath = ''.obs;
  RxString fileUrl = ''.obs;
  RxString quizId = ''.obs;
  RxString journeyId = ''.obs;
  RxString roadmapId = ''.obs;
  RxString title = ''.obs;
  RxBool isQuizEnable = false.obs;
  RxBool isQuizCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPdfFile();
  }

  Future<void> loadPdfFile() async {
    try {
      if (fileUrl.isEmpty || fileUrl.value.isEmpty) {
        errorMessage.value = "Invalid PDF path";
        update();
        return;
      }

      final response = await http.get(Uri.parse(fileUrl.value));

      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = '${tempDir.path}/downloaded.pdf';
        final File file = File(tempPath);

        await file.writeAsBytes(response.bodyBytes);

        localFilePath.value = file.path;
        isReady.value = true;
        isQuizEnable.value = (roadmapController.getRoadmapData.value.data?.roadmapSteps?[roadmapController.currIndex.value].content?.quizEnabled ?? false) ? true : false;
        quizId.value = (roadmapController.getRoadmapData.value.data?.roadmapSteps?[roadmapController.currIndex.value].content?.quiz?.id ?? '');
        journeyId.value = roadmapController.currRoadmapJourneyId.value;
        roadmapId.value = roadmapController.currRoadmapId.value;
        update();
      } else {
        errorMessage.value = "Failed to download PDF (Status: ${response.statusCode})";
        update();
      }
    } catch (e) {
      errorMessage.value = "Error downloading PDF: $e";
      update();
    }
  }

  onRender(pagesCount) {
    pages?.value = pagesCount;
    isReady.value = true;
    update();
  }

  onError(error) {
    errorMessage.value = error.toString();
    update();
  }

  onPageError(page, error) {
    errorMessage.value = '$page: ${error.toString()}';
    update();
  }

  onViewCreated(PDFViewController vc) {
    if (!controller.isCompleted) controller.complete(vc);
    // update();
  }

  onViewCreatedFullScreen(PDFViewController vc) {
    controller.complete(vc);
    // update();
  }

  onPageChanged(int? page, int? total) {
    currentPage?.value = page ?? 0;
    update();
  }

  togglefullScreen() {
    isFullScreen.value = !isFullScreen.value;
    update();
  }

  onBackTap() {
    // roadmapController.needToCallApi.value = false;
    commonScreenController.selectedIndex.value = 1;
    update();
    Get.delete<PDFViewController>();
  }

  onNextClick() async {
    await roadmapController.markLevelCompleted(roadmapController.currIndex.value, roadmapController.currStepId.value, roadmapController.getRoadmapData.value.data?.id ?? '', isPDF: true);
    // onBackTap();
    Get.back(closeOverlays: true);
    roadmapController.changeRoadMap(roadmapController.trackLevel.value, roadmapController.currRoadmapLevelLength.value);
  }

  onClickTakeQuiz() {
    Get.offNamed(RoutesClass.quizScreen, arguments: [
      {"quizId": quizId.value},
      {"journeyId": roadmapId.value}
    ]);
    Get.delete<PDFViewController>();
  }

  onlyLoadtoNextLevel() {
    Get.back(closeOverlays: true);
    roadmapController.loadLastUnlockedLevel(roadmapId.value);
  }
}

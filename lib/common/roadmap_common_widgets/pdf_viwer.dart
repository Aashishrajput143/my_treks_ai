import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import './../../resources/images.dart';
import '../../utils/sized_box_extension.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import '../common_widgets.dart';
import '../../modules/controller/roadmap_controllers/pdf_view_controller.dart';
import '../my_utils.dart';

class PDFScreen extends StatefulWidget {
  final String? path; //Users/himanshurajput/Library/Developer/CoreSimulator/Devices/6245A090-06FD-425E-B867-FB8F6D22A2AA/data/Containers/Data/Application/C1A026D1-9E50-4439-B428-E8EAE929CF22/tmp/file-sample_150kB.pdf

  const PDFScreen({super.key, this.path});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final PdfViewController pdfController = Get.put(PdfViewController());
    return GetBuilder<PdfViewController>(
      init: PdfViewController(),
      initState: (state) {
        if (state.mounted) {
          pdfController.loadPdfFile();
        }
      },
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              extendBodyBehindAppBar: controller.isFullScreen.isTrue ? true : false,
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios, size: 24, color: controller.isFullScreen.isTrue ? Colors.white : Colors.black)),
                ),
                title: Text(
                  controller.title.isEmpty ? 'View Pdf' : controller.title.value,
                  style: TextStyle(color: controller.isFullScreen.isTrue ? Colors.white : Colors.black),
                ),
                automaticallyImplyLeading: true,
                surfaceTintColor: controller.isFullScreen.isTrue ? const Color.fromARGB(0, 79, 69, 69) : Colors.white,
                backgroundColor: controller.isFullScreen.isTrue ? Colors.black12 : null,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                child: FutureBuilder(
                    future: controller.loadPdfFile(),
                    builder: (context, snapShot) {
                      if (controller.localFilePath.value.isNotEmpty) {
                        return controller.isFullScreen.isFalse
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  height: controller.isFullScreen.isFalse ? Get.size.height * 0.75 : null,
                                  // padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(width: 1.1, color: const Color.fromARGB(31, 227, 227, 227))),
                                  child: PDFView(
                                    filePath: controller.localFilePath.value,
                                    enableSwipe: true,
                                    // swipeHorizontal: true,
                                    autoSpacing: true,
                                    pageFling: false,
                                    pageSnap: false,
                                    defaultPage: controller.currentPage?.value ?? 0,
                                    fitEachPage: true,
                                    fitPolicy: FitPolicy.WIDTH,
                                    preventLinkNavigation: false,
                                    backgroundColor: Colors.white60,
                                    onRender: (pagesCount) => controller.onRender(pagesCount),
                                    onError: (error) => controller.onError(error),
                                    onPageError: (page, error) => controller.onPageError(page, error),
                                    onViewCreated: (PDFViewController vc) => controller.onViewCreated(vc),
                                    onPageChanged: (int? page, int? total) => controller.onPageChanged(page, total),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 45),
                                child: PDFView(
                                  filePath: controller.localFilePath.value,
                                  enableSwipe: true,
                                  // swipeHorizontal: true,
                                  autoSpacing: false,
                                  pageFling: false,
                                  pageSnap: false,
                                  defaultPage: controller.currentPage?.value ?? 0,
                                  // fitEachPage: true,
                                  fitPolicy: FitPolicy.WIDTH,
                                  preventLinkNavigation: false,
                                  backgroundColor: Colors.white60,
                                  onRender: (pagesCount) => controller.onRender(pagesCount),
                                  onError: (error) => controller.onError(error),
                                  onPageError: (page, error) => controller.onPageError(page, error),
                                  onViewCreated: (PDFViewController vc) => controller.onViewCreated(vc),
                                  onPageChanged: (int? page, int? total) => controller.onPageChanged(page, total),
                                ),
                              );
                      } else if (controller.isReady.isFalse) {
                        return Center(child: Text(appStrings.pdfloading, style: const TextStyle(color: Colors.red)));
                      } else if (controller.errorMessage.isNotEmpty) {
                        return Center(child: Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)));
                      }
                      return progressBar(controller.isReady.isFalse ? true : false, Get.height, Get.width);
                    }),
              ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => controller.togglefullScreen(),
                    child: Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12)), boxShadow: [
                        BoxShadow(spreadRadius: 0.89, color: Color.fromARGB(66, 159, 159, 159), offset: Offset(-1.1, 1.1)),
                        BoxShadow(spreadRadius: 0.89, color: Color.fromARGB(66, 159, 159, 159), offset: Offset(1.1, -1.1)),
                      ]),
                      child: Center(
                        child: Image.asset(controller.isFullScreen.isFalse ? appImages.roadMapFullScreenViewIcon : appImages.roadMapExitFullScreenIcon),
                      ),
                    ),
                  ),
                  // FutureBuilder<PDFViewController>(
                  //   future: controller.controller.future,
                  //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
                  //     if (snapshot.hasData && controller.pages?.value != null) {
                  //       return FloatingActionButton.extended(
                  //         label: Text("Go to ${(controller.pages?.value ?? 0) ~/ 2}"),
                  //         onPressed: () async {
                  //           await snapshot.data!.setPage((controller.pages?.value ?? 0) ~/ 2);
                  //         },
                  //       );
                  //     }
                  //     return Container();
                  //   },
                  // ),
                  30.kH,
                  commonButton(Get.size.width * 0.91, 40, appColors.contentAccent, Colors.white,
                      hint: controller.isQuizCompleted.isTrue
                          ? appStrings.continueToNextLvlButton
                          : controller.isQuizEnable.isTrue && controller.isQuizCompleted.isFalse
                              ? appStrings.takeQuizButton
                              : controller.title.value == appStrings.viewAssignment
                                  ? appStrings.uploadWriteAssignment
                                  : controller.title.value == appStrings.viewArticleInstruction
                                      ? appStrings.writeArticle
                                      : appStrings.continueToNextLvlButton, () async {
                    // Get.back();
                    controller.isQuizCompleted.isTrue
                        ? controller.onlyLoadtoNextLevel()
                        : controller.isQuizEnable.isTrue
                            ? controller.onClickTakeQuiz()
                            : controller.title.value == appStrings.viewAssignment || controller.title.value == appStrings.viewArticleInstruction
                                ? Get.back() //controller.onBackTap()
                                : controller.onNextClick();
                  }),
                  10.kH
                ],
              ),
            ),
            progressBar(controller.isReady.isFalse ? true : false, Get.height, Get.width),
          ],
        );
      },
    );
  }
}

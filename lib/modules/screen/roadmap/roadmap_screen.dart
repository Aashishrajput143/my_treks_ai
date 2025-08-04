import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../utils/sized_box_extension.dart';
import '../../../utils/utils.dart';
import '../../../common/my_utils.dart';
import '../../../common/roadmap_common_widgets/video_player.dart';
import '../../../main.dart';
import '../../../common/common_widgets.dart';
import '../../../common/roadmap_common_widgets/roadmap_dailogs.dart';
import '../../../data/response/status.dart';
import '../../../models/roadmap_model.dart';
import '../../../modules/screen/roadmap/roadmap_path_toggle_screen.dart';
import '../../../routes/routes_class.dart';
import '../../../resources/strings.dart';
import '../../../utils/roadmap_enums.dart';
import '../../controller/roadmap_controllers/pdf_view_controller.dart';
import '../../controller/roadmap_controllers/roadmap_controller.dart';
import '../../../resources/colors.dart';
import '../../../resources/font.dart';
import '../../../resources/images.dart';
import '../../controller/roadmap_controllers/roadmap_showcase_controller.dart';

class RoadmapScreen extends ParentWidget {
  const RoadmapScreen({super.key});

  // final RoadmapController roadmapController = Get.put(RoadmapController());
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final RoadmapController roadmapController = Get.put(RoadmapController());
    final RoadmapShowcaseController showcaseController = Get.put(RoadmapShowcaseController());
    return Stack(
      children: [
        Image.asset(appImages.roadMapDemoImage, height: Get.size.height, width: Get.size.width, fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: GetBuilder<RoadmapController>(
              init: RoadmapController(),
              initState: (state) async {
                if (state.mounted) {
                  if (roadmapController.isIntLoadDone.isTrue) {
                    roadmapController.openRoadmapOnScreenSchnge();
                  }
                  roadmapController.setRxRequestStatus(Status.LOADING);
                }
              },
              builder: (controller) {
                return Obx(() => Stack(
                      children: [
                        controller.isImageLoaded.isTrue // Only show UI after image loads
                            ? StreamBuilder<RoadmapJourneyModel>(
                                stream: controller.roadmapStream,
                                builder: (context, snapshot) {
                                  if (roadmapController.rxRequestStatus.value == Status.LOADING && roadmapController.isAnimationPlaying.isTrue || roadmapController.isAnimationPlaying.isTrue) {
                                    return SizedBox(height: Get.size.height, width: Get.size.width, child: Lottie.asset(appImages.cloudTransition, reverse: true, repeat: true, fit: BoxFit.cover));
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text("Error: ${snapshot.error}"));
                                  } else if (!snapshot.hasData) {
                                    return const Center(child: Text(""));
                                  }

                                  // Extract data from snapshot
                                  final roadmapData = snapshot.data!;

                                  if (roadmapController.showCountToggle.value && controller.showCaseView.value) {
                                    showcaseController.checkAndShowShowcase(context, roadmapController);
                                  }

                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    roadmapController.toggleIcon.value = getToggleIcon(roadmapData, roadmapController);
                                  });

                                  return AnimatedOpacity(
                                      duration: const Duration(milliseconds: 8000),
                                      onEnd: () => controller.loadLastUnlockedLevel(controller.currRoadmapId.value),
                                      curve: Curves.fastEaseInToSlowEaseOut,
                                      opacity: roadmapController.rxRequestStatus.value == Status.LOADING ? 0.0 : 1.0,
                                      child: Stack(children: [
                                        Positioned.fill(
                                            top: 0,
                                            child: InteractiveViewer(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                transformationController: controller.transformationController, // Attach controller
                                                // boundaryMargin: const EdgeInsets.all(0), // pass the transformation controller
                                                onInteractionEnd: (details) => controller.onInteractionEnd(),
                                                minScale: 0.8,
                                                maxScale: 6.5,
                                                // panEnabled: true,
                                                constrained: false,
                                                scaleEnabled: false,
                                                child: Stack(children: [
                                                  // _backgroundImage,
                                                  Image.asset(
                                                      // appImages.roadMapSnowBG2Image,
                                                      controller.roadmapThemeImage.isEmpty ? appImages.roadMapSnowBG2Image : controller.roadmapThemeImage.value,
                                                      // width: MediaQuery.of(context).size.width * 4,
                                                      // height: 2102.51,
                                                      fit: BoxFit.fitHeight),
                                                  ..._buildLevelButtons(controller, controller.levelPositions, controller.levelTagColor, controller.lastUnlockedLevel.value, roadmapData)
                                                ])))
                                      ]));
                                })
                            : SizedBox(height: Get.size.height, width: Get.size.width, child: Lottie.asset(appImages.cloudTransition, reverse: true, repeat: true, fit: BoxFit.cover)),
                        //topIconButtonsRow(),
                        controller.coinsReviewController.totalCoinData.value.data?.totalCoinEarn != null
                            ? Positioned(
                                left: 16,
                                top: h <= 677 ? 40 : 70,
                                child: commonShowCase(
                                    showcaseController.firstShowcaseWidget,
                                    'MyTreks Coins${' ' * (w * 0.08).toInt()}1/3',
                                    'Earn coins by completing tasks. Unlock new features and levels',
                                    GestureDetector(
                                        onTap: () => debugPrint('menu button clicked'),
                                        child: InkWell(
                                            onTap: () => controller.onChangeCurrentScreen(2),
                                            child: commonTopIconButton('${(controller.coinsReviewController.totalCoinData.value.data?.totalCoinEarn ?? 0).toString()} Coins', appImages.bigCoins, Colors.white, appColors.contentAccent, appColors.contentAccent, 1.07,
                                                fontSize: 16.0, iconPositionFromLeft: 20.0, textRightPadding: 6.0, textLeftPadding: 18.0, height: 50, conWidth: 120.0, mainWidth: 140.0))),
                                    1))
                            : const SizedBox(),

                        roadmapController.showCountToggle.value
                            ? Positioned(
                                top: h <= 677 ? 40 : 70,
                                right: 8,
                                child: commonShowCase(
                                    roadmapController.two,
                                    "Total Tiles${' ' * (w * 0.09).toInt()}2/3",
                                    'Track your progress here',
                                    commonTopIconButton('${roadmapController.totalCompletedSteps.value}/${roadmapController.totalSteps.value}', appImages.roadMapNewTrackerIcon, appColors.roadmapGreyColorButton, appColors.roadmapGreyColorButton, Colors.white, 1.07,
                                        imagePosition: 0.0, fontSize: 16.0, textRightPadding: 6.0, textLeftPadding: 18.0, bold: true, iconPositionFromLeft: 13.0),
                                    2))
                            : const SizedBox(),
                        roadmapController.showCountToggle.value
                            ? Positioned(
                                right: 25,
                                bottom: 25,
                                child: commonShowCase(roadmapController.three, "Section Selector${' ' * (w * 0.04).toInt()}3/3", 'Here you can switch to the desired section',
                                    GestureDetector(onTap: () => debugPrint('menu button clicked'), child: strengthButton(context, h, roadmapController.toggleIcon.value)), 3),
                              )
                            : const SizedBox(),
                        customProgressBarTransparent((roadmapController.showLoader.value), h, w)
                      ],
                    ));
              }),
        ),
      ],
    );
  }

  String getToggleIcon(roadmapData, RoadmapController roadmapController) {
    final RoadmapMetaDataTags? metaDataTypeEnum = roadmapController.getEnumFromMetaDataValue((roadmapData.data?.metadataTags?.isNotEmpty ?? false ? (roadmapData.data?.metadataTags?[0].type) : "STRENGTHS") ?? "STRENGTHS");
    switch (metaDataTypeEnum) {
      case RoadmapMetaDataTags.career:
        return appImages.roadMapCareerIcon;
      case RoadmapMetaDataTags.industry:
        return appImages.roadMapIndustryIcon;
      case RoadmapMetaDataTags.strength:
        return appImages.roadMapStrengthIcon;
      case RoadmapMetaDataTags.softSkills:
        return appImages.roadMapBottleIcon;
      default:
        return appImages.roadMapStrengthIcon; // Fallback animation
    }
  }

  Widget commonShowCase(key, String title, String description, Widget child, step) {
    return Showcase(
        targetPadding: step == 3 ? const EdgeInsets.all(10) : const EdgeInsets.only(top: 10, left: 3, right: 5),
        overlayOpacity: 0.55,
        key: key,
        disableBarrierInteraction: true,
        tooltipPadding: const EdgeInsets.all(16),
        title: title,
        titleAlignment: Alignment.topLeft,
        descriptionAlignment: Alignment.topLeft,
        description: description,
        descTextStyle: TextStyle(color: appColors.contentSecondary, fontWeight: FontWeight.w600, fontFamily: appFonts.NunitoRegular, fontSize: 14),
        titleTextStyle: TextStyle(color: appColors.contentAccent, fontWeight: FontWeight.w600, fontSize: 18),
        targetShapeBorder: const CircleBorder(),
        child: child);
  }

  List<Widget> _buildLevelButtons(RoadmapController roadmapController, List<Offset> levelPositions, levelTagColor, int lastUnlockedLevel, RoadmapJourneyModel roadmapItems) {
    var sortedSteps = <dynamic>[];
    if (roadmapItems.data?.roadmapSteps != null) {
      sortedSteps = List.from(roadmapItems.data!.roadmapSteps!);
      sortedSteps.sort((a, b) => a.sequenceNo!.compareTo(b.sequenceNo!));
    }
    return List.generate(levelPositions.length, (index) {
      Offset position = levelPositions[index];
      var step = index < sortedSteps.length ? sortedSteps[index] : null;

      // If step is null, either return an empty container or handle it appropriately
      if (step == null) {
        return Positioned(left: position.dx, top: position.dy, child: Container());
      }

      return Positioned(
          left: position.dx,
          top: position.dy,
          child: FutureBuilder<bool>(
              future: levelTagColor(roadmapItems.data?.id, index),
              builder: (context, snapshot) {
                bool isCompleted = step.status == "COMPLETED";
                bool isCurrent = index == lastUnlockedLevel;
                Color buttonColor = isCompleted ? Colors.green : (isCurrent ? AppColors().contentAccent : Colors.grey);
                String getLottieAnimation() {
                  final RoadMapContentType? contentTypeEnum = roadmapController.getEnumFromValue(step.content?.contentType ?? '');
                  switch (contentTypeEnum) {
                    case RoadMapContentType.assignment:
                      return appImages.assessmentLottie;
                    case RoadMapContentType.articlePdf:
                      return appImages.article;
                    case RoadMapContentType.youtubeVideoLink:
                      return appImages.youtubeVideo;
                    case RoadMapContentType.nativeVideoLink:
                      return appImages.inHouseVideo;
                    case RoadMapContentType.journalLink:
                      return appImages.journal;
                    case RoadMapContentType.articleLink:
                      return appImages.journal;
                    default:
                      return 'assets/lottie/default.json'; // Fallback animation
                  }
                }

                // Get the correct Lottie icon
                String icon = getLottieAnimation();

                void handleTap() {
                  if (isCurrent || step.status == "COMPLETED") {
                    roadmapController.handleAction(step, isCurrent, index, roadmapItems.data?.id, context);
                  }
                }

                return GestureDetector(
                    onTap: handleTap,
                    child: isCompleted
                        ? Stack(children: [
                            Image.asset(appImages.roadMapTileBlue, fit: BoxFit.cover, scale: 1.15),
                            Positioned(top: 11.4, left: index < 9 ? 28 : 21, child: Text("${index + 1}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontFamily: appFonts.NunitoBold, fontSize: 28))),
                            Positioned(right: 0, child: Image.asset(appImages.roadMapTileGreenCheckMark, scale: 1.0))
                          ])
                        : isCurrent && (icon != 'assets/lottie/default.json')
                            ? SizedBox(height: 90, child: Lottie.asset(icon, repeat: true, fit: BoxFit.fitHeight))
                            : Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: buttonColor, border: Border.all(color: Colors.white, width: 6.02)),
                                child: Center(
                                    child: isCurrent || isCompleted ? Text("${index + 1}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontFamily: appFonts.NunitoBold, fontSize: 28)) : Image.asset(appImages.roadMapLockIcon, fit: BoxFit.none, scale: 1.0))));
              }));
    });
  }

  Widget topIconButtonsRow() {
    return Container(
        height: 102,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              commonTopIconButton('25 Coins', appImages.bigCoins, Colors.white, appColors.contentAccent, appColors.contentAccent, 1.0, fontSize: 15.0, textRightPadding: 9.0, iconPositionFromLeft: 20.0, height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                commonTopIconButton('2/9', appImages.roadMapCareerIcon, appColors.roadmapGreyColorButton, appColors.roadmapGreyColorButton, Colors.white, 1.11, imagePosition: 0.0, fontSize: 16.0, bold: true, height: 45),
                //commonTopIconButton('4/25', appImages.roadMapIndustryIcon, Colors.white, appColors.contentAccent, appColors.contentAccent, 1.0, fontSize: 16.0, bold: true,height: 50),
                commonTopIconButton('0/10', appImages.roadMapStrengthIcon, appColors.roadmapGreyColorButton, appColors.roadmapGreyColorButton, Colors.white, 1.13, imagePosition: 0.0, fontSize: 16.0, iconPositionFromLeft: 15.0, bold: true, height: 60),
              ])
            ])));
  }

  Widget strengthButton(context, h, String icon) {
    return InkWell(
        onTap: () => strengthDialog(),
        child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(50)), border: Border.all(color: appColors.contentAccent, width: 4)),
            child: Padding(
                padding: icon == appImages.roadMapCareerIcon
                    ? edgeInsetsOnly(top: 10)
                    : icon == appImages.roadMapBottleIcon
                        ? edgeInsetsAll(all: 6)
                        : icon == appImages.roadMapIndustryIcon
                            ? edgeInsetsOnly(top: 4, right: 4, bottom: 8)
                            : edgeInsetsOnly(top: 10),
                child: SvgPicture.asset(icon == "STRENGTHS" ? appImages.roadMapStrengthIcon : icon, fit: BoxFit.fitHeight))));
  }

  strengthDialog() {
    return Get.dialog(barrierDismissible: true, barrierColor: Colors.transparent, transitionCurve: Curves.easeOutBack, const RoadMapPathToggleBox());
  }

  void showBottomDrawer(BuildContext context, double h, double w) {
    RoadmapController controller = Get.put(RoadmapController());
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(16),
              height: h,
              width: w,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16), child: Text(appStrings.uploadAssignment, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary))),
                8.kH,
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          controller.onClickUploadButton();
                        },
                        child: Row(children: [
                          SvgPicture.asset(appImages.fileBlackIcon, width: 25, height: 25),
                          10.kW,
                          Text(appStrings.uploadFileFromPhone, style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary))
                        ]))),
                20.kH,
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                          controller.onClickTakeButton();
                        },
                        child: Row(children: [
                          Image.asset(appImages.cameraIcon, width: 25, height: 25),
                          const SizedBox(width: 10),
                          Text(appStrings.clickAPhoto, style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary))
                        ]))),
                20.kH
              ]));
        });
  }

  assignmentDialog(context, PdfViewController pdfViewController, pdfLink) {
    RoadmapController roadmapController = Get.put(RoadmapController());
    Utils.printLog(roadmapController.showContinueBtn.value);
    Utils.printLog(roadmapController.showUploadBtn.value);
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapAssignmentDialogBox(
            height: Get.size.height * 1.22,
            title: appStrings.assignmentText,
            titleColor: appColors.contentPrimary,
            hintButton3: appStrings.writeAssignmentHere,
            isDuration: true,
            coins: (roadmapController.getRoadmapData.value.data?.roadmapSteps?[roadmapController.currIndex.value].points ?? "0").toString(),
            time: (roadmapController.getRoadmapData.value.data?.roadmapSteps?[roadmapController.currIndex.value].time ?? "0").toString(),
            isCoin: false,
            validation: "Require PDF document to complete the process",
            icon: appImages.assessmentLottie,
            titleImage: appImages.assignment,
            backgroundIcon: appImages.assessmentBackground,
            isHeader: true,
            showAllBtn: true,
            message: appStrings.assignmentSubText,
            hintButton: appStrings.submit,
            hintButton2: appStrings.uploadAssignment,
            onClickUploadBtn: () => showBottomDrawer(context, 200, Get.width),
            showContinueBtn: roadmapController.showContinueBtn.value,
            showUploadBtn: roadmapController.showUploadBtn.value,
            showWriteBtn: roadmapController.showWriteAssBtn.value,
            isLastButtonHide: true,
            onChanged: () => roadmapController.onClickSubmitAssignment(),
            navigate: () {
              // Get.back();
              Get.toNamed(RoutesClass.articleWriteup);
              // Future.delayed(const Duration(milliseconds: 50), () {
              //   roadmapController.commonScreenController.selectedIndex.value = 17;
              // });
            },
            onComplete: () => roadmapController.openPDFScreen(pdfViewController, roadmapController.currIndex.value, roadmapController.currStepId.value, pdfLink, appStrings.viewAssignment)));
  }

  assignmentCompletedDialog(PdfViewController pdfViewController, pdfLink) {
    RoadmapController roadmapController = Get.put(RoadmapController());
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapAssignmentDialogBox(
            height: Get.size.height * 1.22,
            title: appStrings.assignmentText,
            titleColor: appColors.contentPrimary,
            hintButton3: "Close",
            isCoin: false,
            icon: appImages.assessmentCompleted,
            titleImage: appImages.assignment,
            backgroundIcon: appImages.assessmentBackground,
            isHeader: true,
            message: appStrings.assignmentSubText,
            hintButton: appStrings.submit,
            hintButton2: appStrings.uploadAssignment,
            showContinueBtn: false,
            showUploadBtn: false,
            showWriteBtn: false,
            showAllBtn: false,
            isLastButtonHide: false,
            onChanged: () => Get.back(),
            navigate: () => Get.back(),
            onComplete: () => roadmapController.openPDFScreen(pdfViewController, roadmapController.currIndex.value, roadmapController.currStepId.value, pdfLink, appStrings.viewAssignment, isTileCompleted: true)));
  }

  roadMapCompletedDialog(w, h) {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen ?? false) Get.back();
    });
    return Get.dialog(
      barrierDismissible: true,
      transitionCurve: Curves.easeOutBack,
      RoadMapTransparentDialogBox(width: w, height: h, title: appStrings.roadmapCompleted, icon: appImages.roadmapCompleted, titleImage: appImages.congratulations, backgroundIcon: appImages.assessmentBackground, message: appStrings.roadmapCompletedDesc, titleCenter: true),
    );
  }

  roadMapWriteUpDialog(VoidCallback? onComplete, bool completed, PdfViewController pdfViewController, {pdfLink, message = ""}) {
    RoadmapController roadmapController = Get.put(RoadmapController());
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapAssessmentDialogBox(
          height: 860,
          title: "Article Write Up",
          isCoin: false,
          icon: completed ? appImages.assessmentCompleted : appImages.assessmentLottie,
          titleImage: appImages.assessment,
          backgroundIcon: appImages.assessmentBackground,
          isHeader: false,
          message: message,
          hintButton: completed ? "Close" : "Write Article Here",
          onComplete: onComplete,
          openPdf: () => roadmapController.openPDFScreen(pdfViewController, roadmapController.currIndex.value, roadmapController.currStepId.value, pdfLink, appStrings.viewArticleInstruction),
        ));
  }

  openVideoDialog(VoidCallback? onComplete, VoidCallback? openVideo, String? title, {message = "", coins = '', time = '', isTakeQuiz = false, quizId = '0', journeyId = "0", isCorrectPdfLink = false}) {
    return Get.dialog(
        barrierDismissible: false,
        transitionCurve: Curves.easeOutBack,
        RoadMapDialogBox(
            height: 458.0,
            title: title == "youtube" ? appImages.youtubeVideoTitle : appImages.videoTitle,
            icon: title == "youtube" ? appImages.youtubeVideo : appImages.inHouseVideo,
            hintCompleteButton: "Mark as Complete",
            message: message,
            hintButton: 'Open Video',
            onComplete: onComplete,
            openVideo: openVideo,
            isDuration: true,
            coins: coins,
            time: time,
            isTakeQuiz: isTakeQuiz,
            takeQuiz: appStrings.takeQuizButton,
            takeQuizAction: () {
              Get.back();
              Get.toNamed(RoutesClass.quizScreen, arguments: [
                {"quizId": quizId},
                {"journeyId": journeyId}
              ]);
            }));
  }

  videoCompleteDialog(url, String? title, index, stepId) {
    final RoadmapController roadmapController = Get.put(RoadmapController());
    return Get.dialog(
        barrierDismissible: false,
        transitionCurve: Curves.easeOutBack,
        RoadMapDialogBox(
            height: 458.0,
            title: title == "youtube" ? appImages.youtubeVideoTitle : appImages.videoTitle,
            icon: title == "youtube" ? appImages.youtubeVideoCompleted : appImages.inHouseVideoCompleted,
            message: "Fantastic job! You've successfully completed this level",
            hintCompleteButton: "Close",
            hintButton: 'Open Video',
            onComplete: () {
              Get.back();
            },
            openVideo: () {
              Get.back();
              print("url====>$url");
              if (title == "youtube") {
                roadmapController.playVideo(url);
                roadmapController.playYtVideo(url, index, stepId);
              } else {
                roadmapController.playVideo(url);
                playVideoInPopUp(url);
              }

              //playVideoInPopUp(url);
              // playVideoInPopUp(url);
            }));
  }

  playVideoInPopUp(url) {
    final RoadmapController roadmapController = Get.put(RoadmapController());
    // return Stack(
    //   children: [VideoPlayerWidget(videoUrl: url, screenHeight: Get.size.height, screenWidth: Get.size.width, onClose: () => roadmapController.hideVideoPlayWidget)],
    // );
    Get.to(() => VideoPlayerWidget(
        videoUrl: url,
        screenHeight: Get.size.height,
        screenWidth: Get.size.width,
        onClose: () {
          roadmapController.hideVideoPlayWidget();
        }));
  }

  commonContentDialog(String buttonText, String iconName, imageTitle, String message, String completeBtnText, PdfViewController pdfViewController, String pdfLink, void Function() onComplete,
      {coins = '', time = '', isTakeQuiz = false, quizId = '0', journeyId = "0", title = 'View Pdf', isCorrectPdfLink = false, isTileCompleted = false}) {
    RoadmapController roadmapController = Get.put(RoadmapController());
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapDialogBox(
            height: Get.size.height * 1.22,
            title: imageTitle,
            icon: iconName,
            message: message,
            hintButton: buttonText,
            hintCompleteButton: completeBtnText,
            onComplete: onComplete,
            isDuration: true,
            coins: coins,
            time: time,
            isTakeQuiz: isTakeQuiz,
            takeQuiz: appStrings.takeQuizButton,
            takeQuizAction: () {
              Get.back();
              Get.toNamed(RoutesClass.quizScreen, arguments: [
                {"quizId": quizId},
                {"journeyId": journeyId}
              ]);
            },
            openVideo: () {
              if (isCorrectPdfLink) {
                roadmapController.openPDFScreen(pdfViewController, roadmapController.currIndex.value, roadmapController.currStepId.value, pdfLink, title, isTileCompleted: isTileCompleted);
              } else {
                roadmapController.jounralUrl(pdfLink);
              }
            }));
  }

  Widget commonTopIconButton(text, image, bgColor, borderColor, textColor, imageScale,
      {borderRadius = 24.0,
      imagePosition = 0.0,
      textLeftPadding = 11.0,
      textRightPadding = 11.0,
      fontSize = 17.0,
      bold = false,
      iconPositionFromLeft = 10.0,
      iconPositionFromTop = 5.0,
      mainWidth = 120.0,
      contHeight = 30.0,
      conWidth = 100.0,
      bool bar = false,
      barSteps = 0,
      barCurrentStep = 0,
      double height = 35}) {
    return SizedBox(
      height: 50.0,
      width: mainWidth,
      child: Stack(
        children: [
          Positioned(
            top: iconPositionFromTop,
            left: iconPositionFromLeft,
            child: bar
                ? SizedBox(
                    width: conWidth,
                    child: Stack(children: [
                      LinearProgressBar(
                          maxSteps: barSteps, progressType: LinearProgressBar.progressTypeLinear, currentStep: barCurrentStep, progressColor: appColors.contentAccent, backgroundColor: bgColor, minHeight: contHeight, borderRadius: BorderRadius.circular(borderRadius)),
                      Positioned(left: 25, child: Text(text, style: TextStyle(color: textColor, fontFamily: appFonts.NunitoRegular, fontWeight: bold ? FontWeight.bold : FontWeight.w700, fontSize: fontSize), textAlign: TextAlign.center))
                    ]))
                : Container(
                    height: contHeight,
                    width: conWidth,
                    padding: EdgeInsets.only(left: textLeftPadding, right: textRightPadding, top: 1.7, bottom: 1.7),
                    decoration: BoxDecoration(color: bgColor, border: Border.all(width: 1.3, color: borderColor), borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                    child: Text(
                      text,
                      style: TextStyle(color: textColor, fontFamily: appFonts.NunitoRegular, fontWeight: bold ? FontWeight.bold : FontWeight.w700, fontSize: fontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          Positioned(left: imagePosition, child: SvgPicture.asset(image, width: height, height: height))
        ],
      ),
    );
  }

  Widget levelTiles(index, buttonColor) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: buttonColor, border: Border.all(color: Colors.white, width: 2)),
        child: Center(
          child: Text("${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ));
  }
}

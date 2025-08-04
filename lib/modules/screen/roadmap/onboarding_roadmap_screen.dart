import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vroar/common/roadmap_common_widgets/video_player.dart';
import 'package:vroar/resources/strings.dart';

import '../../../common/my_utils.dart';
import '../../../common/roadmap_common_widgets/roadmap_dailogs.dart';
import '../../../data/response/status.dart';
import '../../../models/oboarding_roadmap_models.dart';
import '../../controller/roadmap_controllers/onboarding_roadmap_controller.dart';
import '../../../routes/routes_class.dart';
import '../../../resources/colors.dart';
import '../../../resources/font.dart';
import '../../../main.dart';
import '../../../resources/images.dart';

class OnBoardingRoadmapScreen extends ParentWidget {
  const OnBoardingRoadmapScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final OnBoardingRoadmapController roadmapController = Get.put(OnBoardingRoadmapController());
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      // appBar: AppBar(
      //   // forceMaterialTransparency: true,
      //   backgroundColor: Colors.white,
      //   elevation: 3,
      //   excludeHeaderSemantics: true,
      //   title: Row(children: [const Text('Hello, '), Text(roadmapController.userName, style: TextStyle(color: appColors.contentAccent))]),
      //   actions: [],
      //   centerTitle: false,
      //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
      //   bottom: PreferredSize(
      //       preferredSize: const Size.fromHeight(1),
      //       child: Container(decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(12))))),
      // ),
      body: GetBuilder<OnBoardingRoadmapController>(
          init: OnBoardingRoadmapController(),
          initState: (state) {
            if (state.mounted) {
              roadmapController.getOnBoardingRoadmapApi();
              // roadmapController.generateLevelPositions(roadmapController.totalLevels);
              roadmapController.initializeLevelPositions();
              roadmapController.loadLastUnlockedLevel();
            }
          },
          builder: (controller) {
            return Obx(() => Stack(
                  children: [
                    controller.isImageLoaded.isTrue // Ensure image is loaded before showing UI
                        ? StreamBuilder<OnBoardingRoadmapJourneyModel>(
                            stream: controller.roadmapStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return progressBar(true, h, w);
                              } else if (snapshot.hasError) {
                                return Center(child: Text("Error: ${snapshot.error}"));
                              } else if (!snapshot.hasData) {
                                return const Center(child: Text("No data available"));
                              }

                              // Extract data from snapshot
                              final roadmapData = snapshot.data!;
                              return Stack(
                                children: [
                                  Stack(
                                    children: [
                                      Positioned.fill(
                                        top: 0,
                                        child: InteractiveViewer(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          transformationController: controller.transformationController,
                                          onInteractionEnd: (details) => controller.onInteractionEnd(),
                                          minScale: 1.0,
                                          maxScale: 2.5,
                                          constrained: false,
                                          scaleEnabled: false,
                                          child: Stack(
                                            children: [
                                              Image.asset(appImages.roadMapDemo2Image, fit: BoxFit.cover),
                                              ..._buildLevelButtons(controller.levelPositions, controller.levelTagColor, controller.markLevelCompleted, controller.lastUnlockedLevel, controller.scrollToLastUnlockedLevel, roadmapData, w, h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  progressBar((controller.rxRequestStatus.value == Status.LOADING) ? true : false, h, w),
                                  // Visibility(
                                  //     visible: controller.showInHouseVideo.isTrue,
                                  //     child: VideoPlayerWidget(
                                  //         videoUrl: controller.inHouseVideoUrl.toString(),
                                  //         screenHeight: Get.size.height,
                                  //         screenWidth: Get.size.width,
                                  //         onClose: () {
                                  //           roadmapController.hideVideoPlayWidget();
                                  //         }))
                                ],
                              );
                            },
                          )
                        :
                        // const Center(child: CircularProgressIndicator())
                        progressBar(true, h, w),
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   height: 74,
                    //   decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(bottom: Radius.circular(12))),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [Text('Hello, ', style: TextStyle(fontSize: 24, fontFamily: appFonts.NunitoBold)), Text(roadmapController.userName.value, style: TextStyle(color: appColors.contentAccent, fontSize: 24, fontFamily: appFonts.NunitoBold))],
                    //       ),
                    //       Center(
                    //         child: InkWell(
                    //           // onTap: () => controller.onChangeCurrentScreen(4),
                    //           onTap: () => Get.back(),
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(50),
                    //             child: controller.userImage.value.isNotEmpty
                    //                 ? Image.network(
                    //                     controller.userImage.value,
                    //                     fit: BoxFit.cover,
                    //                     width: 45,
                    //                     height: 45,
                    //                   )
                    //                 : Image.asset(
                    //                     appImages.jhony,
                    //                     width: 42,
                    //                     height: 42,
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ));
          }),
    );
  }

  List<Widget> _buildLevelButtons(levelPositions, levelTagColor, markLevelCompleted, lastUnlockedLevel, scrolToNextLevel, OnBoardingRoadmapJourneyModel roadmapItems, w, h) {
    final OnBoardingRoadmapController roadmapController = Get.put(OnBoardingRoadmapController());
    return List.generate(levelPositions.length, (index) {
      Offset position = levelPositions[index];
      return Positioned(
        left: position.dx,
        top: position.dy,
        child: Visibility(
          visible: roadmapItems.data?.onboardingSteps?.isNotEmpty ?? false,
          child: FutureBuilder<bool>(
              future: levelTagColor(index), // (index + 1 ) for level start from 1
              builder: (context, snapshot) {
                Color buttonColor = Colors.grey; // Default: Locked level (upcoming)
                // bool isCompleted = snapshot.hasData && snapshot.data == true;
                bool isCurrent = index == lastUnlockedLevel.value; // Current unlocked level

                // if (isCompleted) {
                //   buttonColor = Colors.green; // Completed levels
                // } else
                if (isCurrent) {
                  buttonColor = AppColors().contentAccent; // Current unlocked level
                }
                return GestureDetector(
                  onTap: () {
                    //isCurrent &&
                    if (isCurrent && roadmapItems.data != null && roadmapItems.data?.onboardingSteps != null) {
                      roadmapController.handleAction(
                          roadmapItems.data?.onboardingSteps?[index].type.toString() ?? 'ONBOARD_VIDEO',
                          isCurrent,
                          roadmapItems.data?.onboardingSteps?[index].contentType,
                          roadmapItems.data?.onboardingSteps?[index].status == 'COMPLETED' ? true : false,
                          roadmapItems.data?.onboardingSteps?[index].contentLink.toString() ?? '',
                          roadmapItems.data?.onboardingSteps?[index].contentLink,
                          int.parse(roadmapItems.data?.onboardingSteps?[index].id ?? '0'),
                          roadmapItems.data?.onboardingSteps?[index].assessment?.id ?? '0',
                          index,
                          w,
                          h);
                    } else if (roadmapItems.data != null && roadmapItems.data!.onboardingSteps != null && roadmapItems.data?.onboardingSteps?[index].status == "COMPLETED") {
                      roadmapController.handleAction(
                          roadmapItems.data?.onboardingSteps?[index].type.toString() ?? 'ONBOARD_VIDEO',
                          isCurrent,
                          roadmapItems.data?.onboardingSteps?[index].contentType,
                          roadmapItems.data?.onboardingSteps?[index].status == 'COMPLETED' ? true : false,
                          roadmapItems.data?.onboardingSteps?[index].contentLink.toString() ?? '',
                          roadmapItems.data?.onboardingSteps?[index].contentLink,
                          int.parse(roadmapItems.data?.onboardingSteps?[index].id ?? '0'),
                          roadmapItems.data?.onboardingSteps?[index].assessment?.id ?? '0',
                          index,
                          w,
                          h);
                    }
                    print(roadmapItems.data?.onboardingSteps?[index].type.toString());
                  },
                  child: (roadmapItems.data?.onboardingSteps?[index].status == 'COMPLETED' ? true : false)
                      ? Stack(
                          children: [
                            Stack(
                              children: [
                                Image.asset(appImages.roadMapTileBlue, fit: BoxFit.cover, scale: 1.15),
                                Positioned(top: 11.4, left: index < 9 ? 28 : 13, child: Text("$index", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontFamily: appFonts.NunitoBold, fontSize: 28))),
                              ],
                            ),
                            Positioned(right: 0, child: Image.asset(appImages.roadMapTileGreenCheckMark, scale: 1.0))
                          ],
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: buttonColor, border: Border.all(color: Colors.white, width: 6.02)),
                          child: Center(
                            child: isCurrent || (roadmapItems.data?.onboardingSteps?[index].status == 'COMPLETED' ? true : false)
                                ? Text("$index", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontFamily: appFonts.NunitoBold, fontSize: 28))
                                : Image.asset(appImages.roadMapLockIcon, fit: BoxFit.none, scale: 1.0),
                          ),
                        ),
                );
              }),
        ),
      );
    });
  }

  openVideoDialog(VoidCallback? onComplete, VoidCallback? openVideo, String? title) {
    return Get.dialog(
        barrierDismissible: false,
        transitionCurve: Curves.easeOutBack,
        RoadMapDialogBox(
            height: 458.0,
            title: title == "youtube" ? appImages.youtubeVideoTitle : appImages.videoTitle,
            icon: title == "youtube" ? appImages.youtubeVideo : appImages.inHouseVideo,
            hintCompleteButton: "Mark as Complete",
            message: 'Introductory video to show a glimpse of how the application will work for the student',
            hintButton: 'Open Video',
            onComplete: onComplete,
            openVideo: openVideo));
  }

  openSessionCompleteDialog() {
    return Get.dialog(
        barrierDismissible: false,
        transitionCurve: Curves.easeOutBack,
        RoadMapSessionCompleteDialogBox(
            height: 380.0,
            title: "Mark Your Session as Complete",
            level: "Level 4",
            subtitle: "Please confirm that your session with the coach is completed. Once marked as complete, you can proceed further before going to ",
            hintButton: "Mark as Completed",
            onChanged: () {
              Get.toNamed(RoutesClass.selectPath);
            }));
  }

  playVideoInPopUp(url) {
    final OnBoardingRoadmapController roadmapController = Get.put(OnBoardingRoadmapController());
    Get.to(() => VideoPlayerWidget(
        videoUrl: url,
        screenHeight: Get.size.height,
        screenWidth: Get.size.width,
        onClose: () {
          roadmapController.hideVideoPlayWidget();
        }));
  }

  videoCompleteDialog(url, String? title) {
    final OnBoardingRoadmapController roadmapController = Get.put(OnBoardingRoadmapController());
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
              roadmapController.playVideo(url);
              title == "youtube" ? roadmapController.playYtVideo(url) : playVideoInPopUp(url);
              // playVideoInPopUp(url);
            }));
    // RoadMapOneButtonDialogBox(
    //     height: 458.0,
    //     title: appImages.videoTitle,
    //     icon: appImages.inHouseVideoCompleted,
    //     message: "Fantastic job! You've successfully completed this level",
    //     hintButton: 'Close',
    //     onComplete: () {
    //       Get.back();
    //     }));
  }

  resultUploadDialog(contentLink) {
    final OnBoardingRoadmapController roadmapController = Get.put(OnBoardingRoadmapController());
    roadmapController.revertBack();
    return Get.dialog(
        barrierDismissible: false,
        transitionCurve: Curves.easeIn,
        Obx(() => RoadMapUploadResultCouponDialogBox(
            height: 330,
            title: 'Coupon Code!',
            validation: "Require PDF document to complete the process",
            code: contentLink ?? 'G7XF9TNB4PB9F8PJ',
            message: 'Navigate to the GSF platform to redeem your coupon, take the Assigment.',
            hintButton: 'Upload Result',
            goToWebsite: "Go to Website",
            hintButton2: appStrings.continueButton,
            onChanged: () async {
              Get.back();
              await roadmapController.uploadFileApi().then((vall) => Get.toNamed(RoutesClass.strengthScreen));
            },
            navigateGoToWebsite: () async {
              const url = "https://my.gallup.com/_Home/RedeemAccessCode";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
            onClickUploadBtn: () => roadmapController.onClickUploadButton(),
            showContinueBtn: roadmapController.showContinueBtn.value,
            showUploadBtn: roadmapController.showUploadBtn.value)));
  }

  resultUploadCompletedDialog(contentLink) {
    return Get.dialog(
        barrierDismissible: false,
        transitionCurve: Curves.easeIn,
        RoadMapUploadResultCouponDialogBox(
            height: 330,
            title: 'Coupon Code!',
            validation: "Require PDF document to complete the process",
            code: contentLink ?? 'ANUKM178S',
            message: 'Navigate to the GSF platform to redeem your coupon, take the Assigment.',
            hintButton: 'Close',
            goToWebsite: "Go to Website",
            hintButton2: appStrings.continueButton,
            onChanged: () async => Get.back(),
            navigateGoToWebsite: () async {
              const url = "https://my.gallup.com/_Home/RedeemAccessCode";
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
            onClickUploadBtn: () => Get.back(),
            showContinueBtn: false,
            showUploadBtn: true));
  }

  assignmentDialog(VoidCallback? onComplete) {
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapSoftSkillDialogBox(
            title: appImages.assessmentOnboarding,
            subtitle: "Let's Get to Know You! ",
            icon: appImages.quiz,
            message: 'Before we start this journey, we want to understand you-your interests, experiences, and what excites you!',
            message1: "This will help us personalize your experience and guide you toward opportunities that match who you are.",
            message2: "Take a few minutes to answer these questions as best as you can. There are no right or wrong answers-just be yourself!",
            hintButton: 'Start',
            paddingGap: 16,
            onComplete: onComplete,
            hasMarkComp: false));
  }

  assignmentCompletedDialog(VoidCallback? onComplete) {
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapSoftSkillDialogBox(
          title: appImages.assessmentOnboarding,
          subtitle: "Let's Get to Know You! ",
          icon: appImages.quizCompleted,
          message: 'Before we start this journey, we want to understand you-your interests, experiences, and what excites you!',
          message1: "This will help us personalize your experience and guide you toward opportunities that match who you are.",
          message2: "Take a few minutes to answer these questions as best as you can. There are no right or wrong answers-just be yourself!",
          hintButton: 'Close',
          paddingGap: 16,
          onComplete: onComplete,
          hasMarkComp: false,
        ));
  }

  assignmentOnBoardingDialog(VoidCallback? onComplete, bool title) {
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapSoftSkillDialogBox(
          title: appImages.introspect,
          subtitle: "Let's Get to Know You! ",
          icon: appImages.flagLottie,
          message: 'This short self-assessment is a way for you to reflect on your strengths and areas where you might want to grow. ',
          message1: "It's not a test-there are no right or wrong answers. ",
          message2: "The goal is to help you understand yourself better and start building the skills that will help you succeed in school, life, and your future career. ",
          hintButton: 'Start',
          paddingGap: 16,
          onComplete: onComplete,
          hasMarkComp: false,
        ));
  }

  assignmentOnBoardingCompletedDialog(VoidCallback? onComplete, bool title) {
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapSoftSkillDialogBox(
          title: appImages.introspect,
          subtitle: "Let's Get to Know You! ",
          icon: appImages.flagLottie,
          message: 'This short self-assessment is a way for you to reflect on your strengths and areas where you might want to grow. ',
          message1: "It's not a test-there are no right or wrong answers. ",
          message2: "The goal is to help you understand yourself better and start building the skills that will help you succeed in school, life, and your future career. ",
          hintButton: 'Close',
          paddingGap: 16,
          onComplete: onComplete,
          hasMarkComp: false,
        ));
  }

  onBoardingCouponCodeCompletedDialog(w, h) {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen ?? false) {
        Get.back(); // Closes the dialog
      }
    });
    return Get.dialog(
      barrierDismissible: false,
      transitionCurve: Curves.easeOutBack,
      RoadMapTransparentDialogBox(
        width: w,
        height: h,
        title: appStrings.unLockExperience,
        icon: appImages.unlock,
        titleImage: appImages.congratulations,
        backgroundIcon: appImages.assessmentBackground,
        message: "",
        titleCenter: true,
      ),
    );
  }

  strengthCoachingDialog(VoidCallback? onComplete, VoidCallback? markCompleted) {
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapSoftSkillDialogBox(
          title: appImages.strengthCoaching,
          isLottie: false,
          subtitle: "It's Time to connect with your coach",
          icon: appImages.calender,
          message: "You've got talents waiting to be unleashed-and this session is where it all begins.",
          message1: "Whether you're chasing big goals or just figuring things out, your coach is here to help you unlock what makes you powerful.",
          message2: "Ready to take the first step?",
          message3: "Book your session now and let's make things happen.",
          hintButton: 'Book Session',
          onComplete: onComplete,
          hasMarkComp: true,
          markCompleted: markCompleted,
          hintCompleteButton: "Mark As Completed",
        ));
  }

  strengthCoachingCompletedDialog(VoidCallback? onComplete) {
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionCurve: Curves.easeOutBack,
        RoadMapSoftSkillDialogBox(
          title: appImages.strengthCoaching,
          isLottie: false,
          subtitle: "It's Time to connect with your coach",
          icon: appImages.calender,
          message: "You've got talents waiting to be unleashed-and this session is where it all begins.",
          message1: "Whether you're chasing big goals or just figuring things out, your coach is here to help you unlock what makes you powerful.",
          message2: "Ready to take the first step?",
          message3: "Book your session now and let's make things happen.",
          hintButton: 'Close',
          paddingGap: 16,
          onComplete: onComplete,
          hasMarkComp: false,
        ));
  }
}

  // Future<void> handleAction(String type, bool isCurrent, String contentType, bool isCompleted, String inHouseVideoUrl, String? contentLink, int stepId, String assessmentId, int index) async {
  //   OnBoardingRoadMapContentType? onContentType = roadmapController.getEnumFromValue(type);
  //   switch (onContentType) {
  //     case OnBoardingRoadMapContentType.onBoardVideo:
  //       OnBoardingRoadMapContentType? onContentType = roadmapController.getEnumFromValue(contentType);
  //       switch (onContentType) {
  //         case OnBoardingRoadMapContentType.nativeVideo:
  //           isCurrent && !isCompleted ? openVideoDialog(contentLink, stepId) : videoCompleteDialog();
  //           break;
  //         case OnBoardingRoadMapContentType.youtubeVideo:
  //           isCurrent && !isCompleted ? roadmapController.playYtVideo(contentLink, index, stepId) : videoCompleteDialog();
  //           break;
  //         default:
  //           Utils.printLog("Unsupported video content type: $contentType");
  //       }
  //     case OnBoardingRoadMapContentType.assessment:
  //       Get.toNamed(RoutesClass.questionAnswer, arguments: [
  //         {'stepId': stepId},
  //         {'assessmentId': assessmentId},
  //         {'currentLevel': index},
  //         {'assessmentType': 'ASSESSMENT'}
  //       ]);
  //       break;
  //     case OnBoardingRoadMapContentType.softSkillAssessment:
  //       Get.toNamed(RoutesClass.questionAnswer, arguments: [
  //         {'stepId': stepId},
  //         {'assessmentId': assessmentId},
  //         {'currentLevel': index},
  //         {'assessmentType': 'SOFT_SKILL_ASSESSMENT'}
  //       ]);
  //       // Handle assessment logic (assuming there's an assessment dialog)
  //       // openAssessmentDialog();
  //       break;

  //     case OnBoardingRoadMapContentType.gallupVideo:
  //       OnBoardingRoadMapContentType? onContentType = roadmapController.getEnumFromValue(contentType);
  //       switch (onContentType) {
  //         case OnBoardingRoadMapContentType.nativeVideo:
  //           playVideoInPopUp(contentLink);
  //           break;
  //         case OnBoardingRoadMapContentType.youtubeVideo:
  //           roadmapController.markLevelCompleted(index, stepId);
  //           roadmapController.playYtVideo(contentLink, index, stepId);
  //           break;
  //         default:
  //           Utils.printLog("Unsupported video content type: $contentType");
  //       }
  //       break;
  //     case OnBoardingRoadMapContentType.coachVideo:
  //       OnBoardingRoadMapContentType? onContentType = roadmapController.getEnumFromValue(contentType);
  //       switch (onContentType) {
  //         case OnBoardingRoadMapContentType.nativeVideo:
  //           roadmapController.markLevelCompleted(index, stepId);
  //           playVideoInPopUp(contentLink);
  //           break;
  //         case OnBoardingRoadMapContentType.youtubeVideo:
  //           roadmapController.markLevelCompleted(index, stepId);
  //           roadmapController.playYtVideo(contentLink, index, stepId);
  //           break;
  //         default:
  //           Utils.printLog("Unsupported video content type: $contentType");
  //       }
  //       break;

  //     case OnBoardingRoadMapContentType.userInviteGallupCode:
  //       // openSessionCompleteDialog();
  //       roadmapController.updateCurrIndexStepId(index, stepId);
  //       Get.toNamed(RoutesClass.parentInvite, arguments: [
  //         {'isOnBoarding': true}
  //       ]);
  //       break;

  //     case OnBoardingRoadMapContentType.gallupResult:
  //       roadmapController.updateCurrIndexStepId(index, stepId);
  //       resultUploadDialog();
  //       break;

  //     case OnBoardingRoadMapContentType.scheduleCoachmeeting:
  //       roadmapController.googleMeet(inHouseVideoUrl);
  //       break;

  //     default:
  //       Utils.printLog("Invalid type: $type");
  //   }
  // }

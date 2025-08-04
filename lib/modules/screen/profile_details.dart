import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/get_image_photo_gallery.dart';
import '../../routes/routes_class.dart';
import '../../utils/sized_box_extension.dart';
import '../../common/my_alert_dialog.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/strings.dart';
import '../controller/profile_details_controller.dart';

class ProfileDetailsScreen extends ParentWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ProfileDetailsController controller = Get.put(ProfileDetailsController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
              //resizeToAvoidBottomInset: false,
              body: SizedBox(
                  height: h,
                  width: w,
                  child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(height: h <= 677 ? 0 : 30),
                            InkWell(onTap: () => controller.mainController.selectedIndex.value = 0, child: Image.asset(appImages.home, color: appColors.contentAccent)),
                            20.kH,
                            Center(
                                child: Column(children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: appColors.contentAccent, width: 2.0)),
                                  child: CircleAvatar(
                                      radius: 47,
                                      backgroundColor: appColors.photoBackground,
                                      child: ClipOval(
                                          child: controller.selectedImage.value?.isNotEmpty ?? false
                                              ? Image.file(File(controller.selectedImage.value ?? ""), fit: BoxFit.cover, width: 94, height: 94)
                                              : controller.mainController.getProfileData.value.data?.avatar?.isNotEmpty ?? false
                                                  ? Image.network(controller.mainController.getProfileData.value.data?.avatar ?? "", fit: BoxFit.cover, width: 94, height: 94)
                                                  : Image.asset(appImages.jhony, fit: BoxFit.cover, width: 94, height: 94)))),
                              const SizedBox(height: 10),
                              Text("${controller.mainController.getProfileData.value.data?.firstName ?? ""} ${controller.mainController.getProfileData.value.data?.lastName ?? ""}",
                                  style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        showBottomDrawer(context, 200, w);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), backgroundColor: Colors.white, side: BorderSide(color: appColors.contentAccent), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                      child: Row(mainAxisSize: MainAxisSize.min, children: [SvgPicture.asset(appImages.editIcon), const SizedBox(width: 4), Text(appStrings.editPicture, style: TextStyle(color: appColors.contentAccent, fontSize: 16))])))
                            ])),
                            20.kH,
                            Text(appStrings.profile, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600)),
                            8.kH,
                            commonProfileWidget(appStrings.editProfile, appImages.profileIconDark, appColors.contentPrimary, appColors.accentBlue, () {
                              controller.mainController.role.value == "PARENT" ? controller.mainController.selectedIndex.value = 4 : controller.mainController.selectedIndex.value = 8;
                            }),
                            20.kH,
                            // if (controller.mainController.role.value != "PARENT") ...[
                            //   Text(appStrings.subscription, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600)),
                            //   8.kH,
                            //   commonProfileWidget(appStrings.viewSubscription, appImages.subscription, appColors.contentPrimary, appColors.accentBlue, () {
                            //     // showDialog(
                            //     //   barrierDismissible: false,
                            //     //   context: context,
                            //     //   builder: (context) {
                            //     //     Future.delayed(const Duration(seconds: 2), () {
                            //     //       Navigator.of(context).pop();
                            //     //     });
                            //     //     return RoadMapTransparentDialogBox(width: w, height: h, title: appStrings.badgeEarned, icon: appImages.starBadge, titleImage: appImages.congratulations, backgroundIcon: appImages.assessmentBackground, message: appStrings.badgeEarnedDesc);
                            //     //   },
                            //     // );
                            //     //Get.toNamed(RoutesClass.quizCompleted);
                            //     //Get.toNamed(RoutesClass.quizScreen);
                            //   }),
                            //   20.kH
                            // ],
                            Text(appStrings.supportAndAssistance, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600)),
                            8.kH,
                            // commonProfileWidget(
                            //     appStrings.callSupport,
                            //     appImages.callIcon,
                            //     appColors.contentPrimary,
                            //     appColors.accentBlue, () {
                            //   Future.delayed(const Duration(seconds: 2), () {
                            //     if (Get.isDialogOpen ?? false) {
                            //       Get.back(); // Closes the dialog
                            //     }
                            //   });
                            //   Get.dialog(
                            //     barrierDismissible: false,
                            //     transitionCurve: Curves.easeOutBack,
                            //     RoadMapTransparentDialogBox(
                            //       width: w,
                            //       height: h,
                            //       title: appStrings.roadmapCompleted,
                            //       icon: appImages.roadmapCompleted,
                            //       titleImage: appImages.congratulations,
                            //       backgroundIcon: appImages.assessmentBackground,
                            //       message: appStrings.roadmapCompletedDesc,
                            //       titleCenter: true,
                            //     ),
                            //   );
                            //
                            //   //  Get.dialog(
                            //   //    barrierDismissible: false,
                            //   //    transitionCurve: Curves.easeOutBack,
                            //   //    RoadMapTileInitialDialogBox(title:"Strengths Learning",
                            //   //    tileColor:appColors.contentAccent,
                            //   //    tileLevel:"1",
                            //   //    backgroundColor:appColors.buttonStateDisabled,
                            //   //    subtitle:"Feedback",
                            //   //    message:"Great Essay! Your writing is commendable, and you've done a fantastic job on this essay. To make your work even more impactful and precise, consider focusing more on the effective use of pronouns. Pronouns can help you avoid repetition and make your sentences clearer and more engaging. Keep up the excellent work and continue ",
                            //   //    height:h,
                            //   //    coin:"50"));
                            // }),
                            // 8.kH,
                            commonProfileWidget(appStrings.needHelp, appImages.ticket, appColors.contentPrimary, appColors.accentBlue, () {
                              Get.toNamed(RoutesClass.needAssistance);
                            }),
                            20.kH,
                            Text(appStrings.legals, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600)),
                            8.kH,
                            commonProfileWidgetWithoutIcon(appStrings.termsAndConditions, appColors.contentPrimary, appColors.accentBlue, () {
                              controller.openWebPage("https://www.mytreks.ai/terms-and-conditions");
                              // showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //   builder: (context) {
                              //     return RoadMapDialogBox(
                              //       title: appImages.quizTitle, //appImages.quizTitle,
                              //       message: "Exploration of Elements",
                              //       hintButton: "Open Quiz",
                              //       height: h,
                              //       isDuration: true,
                              //       time: "25",
                              //       coins: "50",
                              //       isTakeQuiz: true,
                              //       takeQuiz: "Take Quiz",
                              //       hintCompleteButton: appStrings.markAsComplete,
                              //       onComplete: () {},
                              //       openVideo: () {},
                              //       takeQuizAction: (){},
                              //       icon: appImages.quiz, //appImages.quizVideo
                              //     );
                              //   },
                              // );
                            }),
                            8.kH,
                            commonProfileWidgetWithoutIcon(appStrings.privacyPolicy, appColors.contentPrimary, appColors.accentBlue, () {
                              controller.openWebPage("https://www.mytreks.ai/privacy-policy");
                              // showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //   builder: (context) {
                              //     return RoadMapAssessmentDialogBox(
                              //         height: h,
                              //         title: appStrings.assessmentTitle,
                              //         isCoin: false,
                              //         icon: appImages.assessmentLottie,
                              //         titleImage: appImages.assessment,
                              //         backgroundIcon: appImages.assessmentBackground,
                              //         isHeader: false,
                              //         message: appStrings.assessmentDesc,
                              //         hintButton: appStrings.openAssessments,
                              //         onComplete: () {});
                              //   },
                              // );
                            }),
                            20.kH,
                            // if (controller.mainController.role.value == "PARENT") ...[
                            //   Text(
                            //     appStrings.preferences,
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       color: appColors.contentPrimary,
                            //       fontFamily: appFonts.NunitoBold,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            //   const SizedBox(
                            //     height: 8,
                            //   ),
                            //   commonProfileNotification(appStrings.pushNotifications, appImages.notificationIcon, appColors.contentAccent, appColors.contentPrimary, controller.toggle.value, appColors.accentBlue, () {}, (value) {
                            //     controller.toggle.value = !controller.toggle.value;
                            //   }),
                            //   20.kH
                            // ],
                            Text(appStrings.account, style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600)),
                            8.kH,
                            commonProfileWidget(appStrings.logout, appImages.logoutIcon, appColors.backgroundNegative, appColors.accentBlue, () {
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return LogoutDialogBox(
                                      width: w,
                                      title: appStrings.logoutTitle,
                                      goBackHint: appStrings.goBackButton,
                                      goBack: () {
                                        Navigator.pop(context);
                                        controller.mainController.selectedIndex.value = 0;
                                      },
                                      logoutHint: appStrings.logoutButton,
                                      logout: () {
                                        controller.getLogoutApi();
                                        Get.back();
                                      },
                                    );
                                  });
                            }),
                            8.kH,
                            commonProfileWidget(appStrings.deleteAccount, appImages.deleteIcon, appColors.backgroundNegative, appColors.accentBlue, () => Get.dialog(deletePopup(w, controller), barrierDismissible: true))
                          ]))))),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          // internetException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() == "No internet",
          //         () {}),
          // generalException(
          //     controller.rxRequestStatus.value == Status.ERROR &&
          //         controller.error.value.toString() != "No internet",
          //         () {}),
        ],
      ),
    );
  }

  Widget deletePopup(w, ProfileDetailsController controller) {
    return DeleteAccountDialogBox(
      width: w,
      title: appStrings.deleteAccountTitle,
      goBackHint: appStrings.goBackButton,
      goBack: () {
        Get.back();
        controller.mainController.selectedIndex.value = 0;
      },
      deleteAccountHint: appStrings.deleteButton,
      deleteAccount: () => controller.deleteAccountApi(),
    );
  }

  void showBottomDrawer(BuildContext context, double h, double w) {
    ProfileDetailsController controller = Get.put(ProfileDetailsController());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: h,
          width: w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Text(
                  appStrings.uploadPhoto,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary),
                ),
              ),
              8.kH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    // controller.pickImageFromGallery();
                    await pickImageFromGallery(controller.selectedImage,true);
                    controller.uploadProfileApi();
                  },
                  child: Row(
                    children: [
                      Image.asset(appImages.imageGalleryIcon, width: 25, height: 25),
                      10.kW,
                      Text(
                        appStrings.viewPhotoLibrary,
                        style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              20.kH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await pickImageFromGallery(controller.selectedImage,false);
                    controller.uploadProfileApi();
                    //controller.takePhoto();
                  },
                  child: Row(
                    children: [
                      Image.asset(appImages.cameraIcon, width: 25, height: 25),
                      10.kW,
                      Text(
                        appStrings.takeAPhoto,
                        style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              20.kH,
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       if (selectedImage.value?.isNotEmpty ?? false) {
              //         Navigator.pop(context);
              //         selectedImage.value = null;
              //       }
              //     },
              //     style: ElevatedButton.styleFrom(
              //       minimumSize: const Size(double.infinity, 50),
              //       backgroundColor: selectedImage.value?.isNotEmpty ?? false ? Colors.white : appColors.buttonStateDisabled,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //         side: BorderSide(
              //           color: selectedImage.value?.isNotEmpty ?? false ? appColors.contentAccent : appColors.buttonStateDisabled,
              //           width: 1.5,
              //         ),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           appImages.deleteIcon,
              //           width: 25,
              //           height: 25,
              //           color: selectedImage.value?.isNotEmpty ?? false ? appColors.contentAccent : appColors.buttonTextStateDisabled,
              //         ),
              //         Text(
              //           appStrings.removePhoto,
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontFamily: appFonts.NunitoMedium,
              //             fontWeight: FontWeight.w600,
              //             color: selectedImage.value?.isNotEmpty ?? false ? appColors.contentAccent : appColors.buttonTextStateDisabled,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  void showPermissionDeniedDialog(String permissionType) {
    ProfileDetailsController controller = Get.put(ProfileDetailsController());
    String title = permissionType == 'photos' ? 'Photos Access Required' : 'Camera Access Required';
    String message = permissionType == 'photos' ? 'This app needs access to your photos to update your profile picture.' : 'This app needs access to your camera to take a profile picture.';

    Get.dialog(AlertDialog(title: Text(title), content: Text(message), actions: [
      TextButton(onPressed: () => Get.back(), child: Text(appStrings.cancel)),
      TextButton(
          onPressed: () {
            Get.back();
            if (permissionType == 'photos') {
              Permission.photos.request().then((status) async {
                if (status.isGranted) {
                  await pickImageFromGallery(controller.selectedImage,true);
                  controller.uploadProfileApi();
                }
              });
            } else {
              Permission.camera.request().then((status) async {
                if (status.isGranted) {
                  await pickImageFromGallery(controller.selectedImage,false);
                  controller.uploadProfileApi();
                }
              });
            }
          },
          child: const Text('Try Again'))
    ]));
  }

  void showPermissionPermanentlyDeniedDialog(String permissionType) {
    String title = permissionType == 'photos' ? 'Permission Required' : 'Permission Required';
    String message = permissionType == 'photos'
        ? 'Photos access has been permanently denied. Please go to app settings and enable the photos permission to use this feature.'
        : 'Camera access has been permanently denied. Please go to app settings and enable the camera permission to use this feature.';

    Get.dialog(AlertDialog(title: Text(title), content: Text(message), actions: [
      TextButton(onPressed: () => Get.back(), child: Text(appStrings.cancel)),
      TextButton(
          onPressed: () {
            Get.back();
            openAppSettings();
          },
          child: const Text('Open Settings'))
    ]));
  }
}

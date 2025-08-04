import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:vroar/common/common_methods.dart';

import '../../modules/controller/roadmap_controllers/onboarding_roadmap_controller.dart';
import '../../modules/controller/roadmap_controllers/roadmap_controller.dart';
import '../../resources/font.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../../utils/sized_box_extension.dart';
import '../common_widgets.dart';

class RoadMapDialogBox extends StatelessWidget {
  final String title;
  final String icon;
  final String message;
  final String? date;
  final String hintButton;
  final double height;
  final String hintCompleteButton;
  final String? takeQuiz;
  final VoidCallback? onComplete;
  final VoidCallback? openVideo;
  final VoidCallback? takeQuizAction;
  final bool isDueDate;
  final bool isDuration;
  final bool isTakeQuiz;
  final String? time;
  final String? coins;
  const RoadMapDialogBox({
    super.key,
    required this.height,
    required this.title,
    required this.icon,
    this.date,
    this.takeQuiz,
    required this.hintCompleteButton,
    required this.message,
    required this.hintButton,
    required this.onComplete,
    this.isTakeQuiz = false,
    required this.openVideo,
    this.takeQuizAction,
    this.time = "0",
    this.coins = "0",
    this.isDueDate = false,
    this.isDuration = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal:Get.height<=677?16:Get.width*0.1),
        backgroundColor: Colors.transparent,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            decoration: BoxDecoration(border: Border.all(color: appColors.contentAccent, width: 1), borderRadius: BorderRadius.circular(22), color: Colors.white),
            //width: 320,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10, 16, 16),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    40.kH,
                    SvgPicture.asset(title),
                    16.kH,
                    Text(message, style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary), textAlign: TextAlign.center),
                    10.kH,
                    if (isDuration)
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: appColors.durationColor),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Column(children: [
                              Text(appStrings.duration.toUpperCase(), style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w700, color: appColors.contentPrimary), textAlign: TextAlign.center),
                              12.kH,
                              Row(children: [
                                Icon(Icons.access_time, color: appColors.contentAccent),
                                4.kW,
                                RichText(
                                    text: TextSpan(
                                        text: time,
                                        style: TextStyle(fontSize: 24, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent),
                                        children: [TextSpan(text: " min", style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent))]))
                              ])
                            ]),
                            SizedBox(height: 70, child: VerticalDivider(color: appColors.contentAccentLinearColor3, thickness: 2, width: 20)),
                            Column(children: [
                              Text(appStrings.coins.toUpperCase(), style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w700, color: appColors.contentPrimary), textAlign: TextAlign.center),
                              12.kH,
                              Row(children: [Image.asset(appImages.roadMapCoinIcon, scale: 1.5), 4.kW, Text("+$coins", style: TextStyle(fontSize: 24, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w700, color: appColors.contentAccent), textAlign: TextAlign.center)])
                            ])
                          ])),
                    6.kH,
                    if (isDueDate) Text("Due Date : December 20, 2024 ", style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent), textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    commonButton(double.infinity, 45.0, Colors.white, appColors.contentAccent, hint: hintCompleteButton, borderColor: appColors.contentAccent, onComplete),
                    12.kH,
                    if (isTakeQuiz) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonButton(MediaQuery.of(context).size.height<=677?MediaQuery.of(context).size.width * 0.35:MediaQuery.of(context).size.width * 0.31, 45.0, appColors.contentAccent, Colors.white, hint: hintButton, openVideo),
                          commonButton(MediaQuery.of(context).size.height<=677?MediaQuery.of(context).size.width * 0.35:MediaQuery.of(context).size.width * 0.31, 45.0, appColors.contentAccent, Colors.white, hint: takeQuiz ?? "", takeQuizAction),
                        ],
                      )
                    ],
                    if (!isTakeQuiz) ...[
                      commonButton(double.infinity, 45.0, appColors.contentAccent, Colors.white, hint: hintButton, openVideo),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              // top: 0,
              right: 0,
              left: 0,
              child: SizedBox(height: 100, child: Lottie.asset(icon, repeat: false, fit: BoxFit.fitHeight))),
          Positioned(
              top: 35,
              right: 0,
              child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: Container(
                      width: 35, // Circle size
                      height: 35,
                      decoration: BoxDecoration(color: appColors.contentAccent, shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.close, color: Colors.white, size: 22)))))
        ]));
  }
}

class RoadMapOneButtonDialogBox extends StatelessWidget {
  final String title;
  final String icon;
  final String message;
  final String? date;
  final String hintButton;
  final double height;
  final VoidCallback? onComplete;
  final bool isDueDate;
  const RoadMapOneButtonDialogBox({super.key, required this.height, required this.title, required this.icon, this.date, required this.message, required this.hintButton, required this.onComplete, this.isDueDate = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            decoration: BoxDecoration(border: Border.all(color: appColors.contentAccent, width: 1), borderRadius: BorderRadius.circular(22), color: Colors.white),
            width: 320,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  40.kH,
                  SvgPicture.asset(title),
                  16.kH,
                  Text(
                    message,
                    style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoLight, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                    textAlign: TextAlign.center,
                  ),
                  // 10.kH,
                  if (isDueDate)
                    Text(
                      "Due Date : December 20, 2024 ",
                      style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent),
                      textAlign: TextAlign.center,
                    ),
                  16.kH,
                  commonButton(double.infinity, 49.0, appColors.contentAccent, Colors.white, hint: hintButton, onComplete),
                ],
              ),
            ),
          ),
          Positioned(
            // top: 0,
            right: 0,
            left: 0,
            child: SizedBox(height: 100, child: Lottie.asset(icon, repeat: false, fit: BoxFit.fitHeight)),
          ),
          Positioned(
              top: 35,
              right: 0,
              child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: Container(
                      width: 35, // Circle size
                      height: 35,
                      decoration: BoxDecoration(color: appColors.contentAccent, shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.close, color: Colors.white, size: 22)))))
        ]));
  }
}

class RoadMapSoftSkillDialogBox extends StatelessWidget {
  final String title;
  final String icon;
  final String message;
  final String? subtitle;
  final String? message1;
  final String? message2;
  final String? message3;
  final String? date;
  final double? paddingGap;
  final String hintButton;
  final String? hintCompleteButton;
  final VoidCallback? onComplete;
  final VoidCallback? markCompleted;
  final bool isLottie;
  final bool hasMarkComp;
  const RoadMapSoftSkillDialogBox(
      {super.key,
      this.markCompleted,
      this.hintCompleteButton,
      required this.hasMarkComp,
      this.subtitle,
        this.paddingGap=6,
      this.message1,
      this.message2,
        this.message3,
      required this.title,
      required this.icon,
      this.date,
      required this.message,
      required this.hintButton,
      required this.onComplete,
      this.isLottie = true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
            decoration: BoxDecoration(border: Border.all(color: appColors.contentAccent, width: 1), borderRadius: BorderRadius.circular(22), color: Colors.white),
            width: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10, 16, 16),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    40.kH,
                    SvgPicture.asset(title),
                    12.kH,
                    Text(
                      subtitle ?? "",
                      style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w800, color: appColors.contentAccent),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: paddingGap,),
                    Text(
                      message,
                      style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: paddingGap,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        message1 ?? "",
                        style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: paddingGap,),
                    Text(
                      message2 ?? "",
                      style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                      textAlign: TextAlign.center,
                    ),
                    message3?.isNotEmpty??false?SizedBox(height: paddingGap,):const SizedBox(),
                    Text(
                      message3 ?? "",
                      style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                      textAlign: TextAlign.center,
                    ),
                    message3?.isNotEmpty??false?6.kH:0.kH,
                    hasMarkComp ? commonButton(double.infinity, 40.0, Colors.white, appColors.contentAccent, hint: hintCompleteButton ?? "", borderColor: appColors.contentAccent, markCompleted) : const SizedBox(),
                    hasMarkComp ? 6.kH : 0.kH,
                    commonButton(double.infinity, 40.0, appColors.contentAccent, Colors.white, hint: hintButton, onComplete),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 0,
            left: 0,
            child: SizedBox(height: 100, width: 50, child: isLottie ? Lottie.asset(icon, width: 50, height: 200, fit: BoxFit.fitHeight, repeat: false) : Image.asset(icon, width: 50, height: 200, fit: BoxFit.fitHeight)),
          ),
          Positioned(
              top: 60,
              right: 13,
              child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: Container(
                      width: 35, // Circle size
                      height: 35,
                      decoration: BoxDecoration(color: appColors.contentAccent, shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.close, color: Colors.white, size: 22)))))
        ]));
  }
}

class RoadMapAssessmentDialogBox extends StatelessWidget {
  final String title;
  final String icon;
  final String titleImage;
  final String backgroundIcon;
  final String message;
  final String hintButton;
  final double height;
  final VoidCallback? onComplete;
  final VoidCallback? openPdf;
  final bool isHeader;
  final bool isCoin;
  const RoadMapAssessmentDialogBox(
      {super.key, required this.height, required this.title, required this.icon, required this.titleImage, required this.backgroundIcon, required this.isHeader, required this.message, required this.hintButton, required this.isCoin, required this.onComplete, this.openPdf});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
            decoration: BoxDecoration(border: Border.all(color: appColors.contentAccent, width: 2), borderRadius: BorderRadius.circular(22), color: Colors.white),
            width: 370,
            height: height * 0.47,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(alignment: Alignment.topLeft, image: AssetImage(backgroundIcon)),
                boxShadow: const [
                  BoxShadow(color: Colors.white, blurStyle: BlurStyle.solid, offset: Offset(0, 0), blurRadius: 1.0, spreadRadius: -50.0),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
              child: Stack(children: [
                Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent),
                      textAlign: TextAlign.center,
                    ),
                    5.kH,
                    Text(message, style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary), textAlign: TextAlign.center),
                    20.kH,
                    Container(
                      // width: 220,
                      height: 45,
                      decoration: BoxDecoration(color: appColors.tertiary, borderRadius: const BorderRadius.all(Radius.circular(12))),
                      child: ListTile(
                        minTileHeight: 4,
                        leading: Container(width: 35, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Image.asset(appImages.roadMapFileIcon)),
                        title: Text(appStrings.viewArticleInstruction.toString(), style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 16, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis)),
                        // subtitle: Text('', style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 12, fontWeight: FontWeight.w400)),
                        trailing: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: openPdf,
                          child: const SizedBox(
                            width: 30,
                            height: 40,
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 10, child: Icon(Icons.visibility, color: Colors.black, size: 22))]),
                          ),
                        ),
                      ),
                    ),
                    10.kH,
                    commonButton(double.infinity, height * 0.048, appColors.contentAccent, Colors.white, hint: hintButton, onComplete),
                  ],
                ),
                Positioned(
                  left: 90,
                  right: 90,
                  top: 50,
                  child: Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        margin: const EdgeInsets.all(30),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: isCoin ? Colors.white : appColors.contentAccent),
                        child: const SizedBox(),
                      ),
                      Positioned(left: -4, right: 0, top: -10, child: Lottie.asset(icon, repeat: false)),
                    ],
                  ),
                )
              ]),
            ),
          ),
          isHeader
              ? Positioned(
                  top: 27,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    margin: EdgeInsets.symmetric(horizontal: height * 0.07),
                    decoration: BoxDecoration(color: appColors.contentAccentLightButton, border: Border.all(color: appColors.contentAccent, width: 2), borderRadius: const BorderRadius.all(Radius.circular(44))),
                    height: height * 0.06,
                    child: SvgPicture.asset(titleImage),
                  ))
              : const SizedBox(),
          Positioned(
              top: height * 0.04,
              right: 0,
              child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 35, // Circle size
                      height: 35,
                      decoration: BoxDecoration(color: appColors.contentAccent, shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.close, color: Colors.white, size: 22)))))
        ],
      ),
    );
  }
}

class RoadMapAssignmentDialogBox extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final String icon;
  final String titleImage;
  final String backgroundIcon;
  final String message;
  final String hintButton;
  final String? validation;
  final double height;
  final VoidCallback? onComplete;
  final VoidCallback? navigate;
  final bool isHeader;
  final bool isCoin;
  final String hintButton2;
  final String hintButton3;
  final VoidCallback? onChanged;
  final VoidCallback? onClickUploadBtn;
  final bool showUploadBtn;
  final bool showContinueBtn;
  final bool showWriteBtn;
  final bool showAllBtn;
  final bool isLastButtonHide;
  final String? time;
  final String? coins;
  final bool isDuration;
  const RoadMapAssignmentDialogBox(
      {super.key,
      required this.height,
      required this.title,
      required this.icon,
      required this.titleImage,
      required this.backgroundIcon,
      this.navigate,
      this.time,
      this.coins,
      required this.showAllBtn,
      required this.isHeader,
      this.validation,
      this.titleColor,
      required this.isLastButtonHide,
      required this.message,
      required this.hintButton3,
      required this.hintButton,
      required this.isCoin,
      required this.onComplete,
      required this.hintButton2,
      this.onChanged,
      this.onClickUploadBtn,
      required this.showContinueBtn,
      required this.showWriteBtn,
      this.isDuration = false,
      required this.showUploadBtn});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Dialog(
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.only(left: 10, right: 10),
        backgroundColor: Colors.transparent,
        child: GetBuilder<RoadmapController>(
            init: RoadmapController(),
            initState: (_) {},
            builder: (controller) {
              return Stack(children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: isLastButtonHide
                        ? controller.showContinueBtn.value
                            ? Platform.isIOS
                                ? 615
                                : 555
                            : Platform.isIOS
                                ? 620
                                : 635
                        : showAllBtn
                            ? 522
                            : 498,
                    maxWidth: MediaQuery.of(context).size.width * 0.92,
                  ),
                  margin: const EdgeInsets.fromLTRB(12, 22, 12, 12),
                  decoration: BoxDecoration(border: Border.all(color: appColors.contentAccent, width: 2), borderRadius: BorderRadius.circular(22), color: Colors.white),
                  width: 370,
                  child: Container(
                    decoration: BoxDecoration(image: DecorationImage(alignment: Alignment.topLeft, image: AssetImage(backgroundIcon)), boxShadow: const [BoxShadow(color: Colors.white, blurStyle: BlurStyle.solid, offset: Offset(0, 0), blurRadius: 1.0, spreadRadius: -50.0)]),
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 6),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Stack(
                            children: [
                              Container(width: 90, height: 90, margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 16), decoration: BoxDecoration(shape: BoxShape.circle, color: isCoin ? Colors.white : appColors.contentAccent), child: const SizedBox()),
                              Positioned(left: -4, right: 0, top: 0, child: Lottie.asset(icon, repeat: false)),
                            ],
                          ),
                          Container(
                              height: 120,
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: ScrollbarTheme(
                                  data: ScrollbarThemeData(thumbColor: WidgetStateProperty.all(appColors.contentAccent), thickness: WidgetStateProperty.all(4), radius: const Radius.circular(8)),
                                  child: Scrollbar(
                                      controller: scrollController,
                                      thumbVisibility: true,
                                      scrollbarOrientation: ScrollbarOrientation.right,
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        physics: const ClampingScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(title, style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: titleColor ?? appColors.contentAccent), textAlign: TextAlign.center),
                                              12.kH,
                                              Text(message, style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary), textAlign: TextAlign.center),
                                            ],
                                          ),
                                        ),
                                      )))),
                          10.kH,
                          if (isDuration)
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: appColors.durationColor),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Column(children: [
                                    Text(appStrings.duration.toUpperCase(), style: TextStyle(fontSize: 13, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w700, color: appColors.contentPrimary), textAlign: TextAlign.center),
                                    2.kH,
                                    Row(children: [
                                      Icon(Icons.access_time, color: appColors.contentAccent),
                                      4.kW,
                                      RichText(
                                          text: TextSpan(
                                              text: time,
                                              style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent),
                                              children: [TextSpan(text: " min", style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent))]))
                                    ])
                                  ]),
                                  SizedBox(height: 70, child: VerticalDivider(color: appColors.contentAccentLinearColor3, thickness: 2, width: 20)),
                                  Column(children: [
                                    Text(appStrings.coins.toUpperCase(), style: TextStyle(fontSize: 13, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w700, color: appColors.contentPrimary), textAlign: TextAlign.center),
                                    2.kH,
                                    Row(children: [
                                      Image.asset(appImages.roadMapCoinIcon, scale: 1.5),
                                      4.kW,
                                      Text("+$coins", style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w700, color: appColors.contentAccent), textAlign: TextAlign.center)
                                    ])
                                  ])
                                ])),
                          10.kH,
                          Container(
                            // width: 220,
                            height: 60,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: appColors.tertiary, borderRadius: const BorderRadius.all(Radius.circular(12))),
                            child: ListTile(
                              minTileHeight: 4,
                              leading: Container(width: 35, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Image.asset(appImages.roadMapFileIcon)),
                              title: Text(appStrings.viewAssignment.toString(), style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 16, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis)),
                              // subtitle: Text('', style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 12, fontWeight: FontWeight.w400)),
                              trailing: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: onComplete,
                                child: const SizedBox(
                                  width: 30,
                                  height: 40,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 10, child: Icon(Icons.visibility, color: Colors.black, size: 22))]),
                                ),
                              ),
                            ),
                          ),
                          10.kH,
                          controller.showUploadBtn.isTrue
                              ? Text(validation ?? "", style: TextStyle(fontSize: 13, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary), textAlign: TextAlign.center)
                              : controller.showSelectedfile.isTrue
                                  ? Container(
                                      // width: 220,
                                      height: 55,
                                      decoration: BoxDecoration(color: appColors.tertiary, borderRadius: const BorderRadius.all(Radius.circular(12))),
                                      child: ListTile(
                                          minTileHeight: 5,
                                          leading: Container(width: 40, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Image.asset(appImages.roadMapFileIcon)),
                                          title: Text(controller.selectedFile.value.toString(), style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 14, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis)),
                                          subtitle: Text(controller.selectedFileSize.value.toString(), style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 12, fontWeight: FontWeight.w400)),
                                          trailing: InkWell(
                                              highlightColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onTap: () => controller.revertBack(),
                                              child: const SizedBox(width: 30, height: 40, child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [SizedBox(width: 10, child: Icon(Icons.close, color: Colors.black, size: 22))])))))
                                  : const SizedBox(),
                          if (showAllBtn) ...[
                            10.kH,
                            if (controller.showWriteAssBtn.value) ...[
                              commonButton(double.infinity, 45, Colors.white, appColors.contentAccent, borderColor: appColors.contentAccent, hint: hintButton3, navigate),
                            ],
                            8.kH,
                            isLastButtonHide
                                ? controller.showUploadBtn.value
                                    ? commonButton(double.infinity, 45, appColors.contentAccent, Colors.white, hint: hintButton2, onClickUploadBtn)
                                    : const SizedBox()
                                : const SizedBox(),
                            if (controller.showContinueBtn.value) ...[commonButton(double.infinity, 45, appColors.contentAccent, Colors.white, hint: hintButton, onChanged)],
                            10.kH,
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
                isHeader
                    ? Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                            padding: const EdgeInsets.all(11),
                            margin: EdgeInsets.symmetric(horizontal: height * 0.07),
                            decoration: BoxDecoration(color: appColors.contentAccentLightButton, border: Border.all(color: appColors.contentAccent, width: 2), borderRadius: const BorderRadius.all(Radius.circular(44))),
                            height: height * 0.05,
                            child: SvgPicture.asset(titleImage)))
                    : const SizedBox(),
                Positioned(
                    top: height * 0.01,
                    right: 0,
                    child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => Get.back(),
                        child: Container(
                            width: 35, // Circle size
                            height: 35,
                            decoration: BoxDecoration(color: appColors.contentAccent, shape: BoxShape.circle),
                            child: const Center(child: Icon(Icons.close, color: Colors.white, size: 22)))))
              ]);
            }));
  }
}

class RoadMapTransparentDialogBox extends StatelessWidget {
  final String title;
  final String icon;
  final String titleImage;
  final bool titleCenter;
  final String backgroundIcon;
  final String message;
  final double height;
  final double width;
  const RoadMapTransparentDialogBox({
    super.key,
    required this.height,
    required this.title,
    required this.icon,
    required this.titleCenter,
    required this.titleImage,
    required this.backgroundIcon,
    required this.width,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: height * 0.1),
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(0.8)], begin: Alignment.center, end: Alignment.center, stops: const [0.7, 1.0]),
          image: DecorationImage(alignment: Alignment.topCenter, colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.modulate), fit: BoxFit.fitWidth, image: AssetImage(backgroundIcon)),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.01), blurRadius: 50, spreadRadius: 5, offset: const Offset(0, 4))],
        ),
        child:SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!titleCenter) ...[
                SvgPicture.asset(titleImage),
                SizedBox(height: height * 0.17),
              ],
              Lottie.asset(icon, height: 280, repeat: false),
              SizedBox(height: height * 0.05),
              if (titleCenter) ...[
                SvgPicture.asset(titleImage),
                SizedBox(height: height * 0.05),
              ],
              SizedBox(
                width: width * 0.88,
                child: Text(title, style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center),
              ),
              12.kH,
              SizedBox(
                width: width * 0.7,
                child: Text(message, style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoadMapThreeDialogBox extends StatelessWidget {
  final String title;
  final String icon;
  final String titleImage;
  final String backgroundIcon;
  final String hintButton;
  final VoidCallback? onComplete;
  final String message;
  final double height;
  final double width;
  const RoadMapThreeDialogBox({
    super.key,
    required this.height,
    required this.title,
    required this.icon,
    required this.titleImage,
    required this.backgroundIcon,
    required this.width,
    required this.message,
    required this.hintButton,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.2),
            ],
            begin: Alignment.center,
            end: Alignment.center,
            stops: const [0.7, 1.0],
          ),
          image: DecorationImage(
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.2),
              BlendMode.modulate,
            ),
            fit: BoxFit.fitWidth,
            image: AssetImage(backgroundIcon),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.01),
              blurRadius: 50,
              spreadRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.15),
            SvgPicture.asset(titleImage),
            SizedBox(height: height * 0.09),
            SizedBox(
              width: width * 0.65,
              height: height * 0.28,
              child: Lottie.asset(icon, repeat: false),
            ),
            SizedBox(height: height * 0.05),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: appFonts.NunitoBold,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: width * 0.7,
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: appFonts.NunitoBold,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: width * 0.8,
              child: commonButton(double.infinity, height * 0.06, appColors.contentAccent, Colors.white, hint: hintButton, onComplete),
            ),
          ],
        ),
      ),
    );
  }
}

class RoadMapUploadResultCouponDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final String code;
  final String? goToWebsite;
  final String? validation;
  final String? upload;
  final double height;
  final String hintButton;
  final String hintButton2;

  final VoidCallback? onChanged;
  final VoidCallback? navigateGoToWebsite;
  final VoidCallback? onClickUploadBtn;
  final bool showUploadBtn;
  final bool showContinueBtn;
  const RoadMapUploadResultCouponDialogBox(
      {super.key,
      required this.height,
      required this.title,
      required this.code,
      this.validation,
      this.upload,
      this.goToWebsite,
      this.navigateGoToWebsite,
      required this.message,
      required this.hintButton,
      required this.hintButton2,
      required this.onChanged,
      required this.showContinueBtn,
      required this.showUploadBtn,
      this.onClickUploadBtn});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: GetBuilder<OnBoardingRoadmapController>(
        init: OnBoardingRoadmapController(),
        initState: (_) {},
        builder: (controller) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(border: Border.all(color: appColors.contentAccent, width: 1), borderRadius: BorderRadius.circular(22), color: Colors.white),
                width: 330,
                height: height,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 30, 16, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 25, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        message,
                        style: TextStyle(fontSize: 13, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                        textAlign: TextAlign.center,
                      ),
                      // 16.kH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            code,
                            style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                            textAlign: TextAlign.center,
                          ),
                          16.kW,
                          InkWell(splashColor: Colors.transparent,highlightColor: Colors.transparent, onTap: () async => {await Clipboard.setData(ClipboardData(text: code)), CommonMethods.showToastSuccess("Copied!")}, child: SvgPicture.asset(appImages.copy))
                        ],
                      ),
                      controller.showUploadBtn.isTrue
                          ? goToWebsite?.isNotEmpty ?? false
                              ? GestureDetector(
                                  onTap: navigateGoToWebsite,
                                  child: Text(
                                    goToWebsite ?? "",
                                    style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent, decoration: TextDecoration.underline, decorationThickness: 2, decorationColor: appColors.contentAccent),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      // 16.kH,
                      controller.showUploadBtn.isTrue
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                validation!,
                                style: TextStyle(fontSize: 13, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(
                              // width: 220,
                              margin: const EdgeInsets.only(bottom: 12),
                              height: 70,
                              decoration: BoxDecoration(
                                color: appColors.tertiary,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: ListTile(
                                minVerticalPadding: 0.1,
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(width: 40, height: 40, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Image.asset(appImages.roadMapFileIcon)),
                                  ],
                                ),
                                title: Text(controller.selectedFile.value.toString(), style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 14, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis)),
                                subtitle: Text(controller.selectedFileSize.value.toString(), style: TextStyle(fontFamily: appFonts.NunitoLight, fontSize: 12, fontWeight: FontWeight.w400)),
                                trailing: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () => controller.revertBack(),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10, child: Icon(Icons.close, color: Colors.black, size: 22)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      Visibility(visible: controller.showUploadBtn.isTrue, child: commonButton(double.infinity, height * 0.16, appColors.contentAccent, Colors.white, hint: hintButton, onClickUploadBtn)),
                      Visibility(
                          visible: controller.showContinueBtn.isTrue, child: commonButton(double.infinity, height * 0.16, ((controller.selectedFile.value?.isEmpty ?? false) ? appColors.buttonStateDisabled : appColors.contentAccent), Colors.white, hint: hintButton2, onChanged))
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: Container(
                    width: 35, // Circle size
                    height: 35,
                    decoration: BoxDecoration(color: appColors.contentAccent, shape: BoxShape.circle),
                    child: const Center(
                      child: Icon(Icons.close, color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RoadMapSessionCompleteDialogBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String level;
  final double height;
  final String hintButton;
  final VoidCallback? onChanged;
  const RoadMapSessionCompleteDialogBox({super.key, required this.height, required this.title, required this.level, required this.subtitle, required this.hintButton, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GetBuilder<OnBoardingRoadmapController>(
        init: OnBoardingRoadmapController(),
        initState: (_) {},
        builder: (controller) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(border: Border.all(color: appColors.contentAccent, width: 1), borderRadius: BorderRadius.circular(22), color: Colors.white),
                width: 320,
                height: 310,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 30, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 25, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentAccent),
                        textAlign: TextAlign.center,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: appFonts.NunitoBold,
                            fontWeight: FontWeight.w600,
                            color: appColors.contentSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: level,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: appFonts.NunitoBold,
                                fontWeight: FontWeight.w600,
                                color: appColors.contentAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.kH,
                      commonButton(double.infinity, height * 0.13, appColors.contentAccent, Colors.white, hint: hintButton, onChanged)
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: Container(
                    width: 35, // Circle size
                    height: 35,
                    decoration: BoxDecoration(color: appColors.contentAccent, shape: BoxShape.circle),
                    child: const Center(
                      child: Icon(Icons.close, color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RoadMapMetaDataDialogBox extends StatelessWidget {
  final String title;
  final String centerIcon;
  final Color color;
  final Color backgroundColor;
  final String subtitle;
  final String description;
  final String hintButton;
  final double? centerIconHeight;
  final double? centerIconTop;
  final double? centerIconRight;

  final double height;
  final VoidCallback? onComplete;
  final VoidCallback? onClose;
  const RoadMapMetaDataDialogBox(
      {super.key,
      required this.height,
      required this.title,
      this.centerIconHeight,
      this.centerIconTop,
      this.centerIconRight,
      required this.centerIcon,
      required this.subtitle,
      required this.color,
      required this.backgroundColor,
      required this.description,
      required this.hintButton,
      required this.onComplete,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),
              width: 320,
              child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                10.kH,
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: backgroundColor),
                    child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(padding: const EdgeInsets.all(12), child: Text(title, style: TextStyle(fontSize: 30, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary), textAlign: TextAlign.start)),
                      const Divider(thickness: 3, height: 3, color: Colors.white),
                      16.kH,
                      Container(
                          height: 300,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: ScrollbarTheme(
                              data: ScrollbarThemeData(
                                  thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                    return color;
                                  }),
                                  thickness: WidgetStateProperty.all(4),
                                  radius: const Radius.circular(8)),
                              child: Scrollbar(
                                  thumbVisibility: true,
                                  scrollbarOrientation: ScrollbarOrientation.right,
                                  child: SingleChildScrollView(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(subtitle, style: TextStyle(fontSize: 20, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: color), textAlign: TextAlign.start),
                                    10.kH,
                                    Text(description, style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoLight, fontWeight: FontWeight.w600, color: appColors.contentPrimary), textAlign: TextAlign.start)
                                  ]))))),
                      16.kH,
                    ])),
                10.kH,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [commonButton(40, 40.0, Colors.white, appColors.contentSecondary, borderColor: appColors.contentSecondary, hint: "X", onClose), commonButton(230, 40.0, appColors.contentAccent, Colors.white, hint: hintButton, onComplete)])
              ])),
          Positioned(top: centerIconTop ?? -10, right: centerIconRight ?? 10, left: 0, child: SizedBox(height: centerIconHeight ?? 100, child: Image.asset(centerIcon, fit: BoxFit.contain)))
        ]));
  }
}

class RoadMapMetaDataStrengthDialogBox extends StatelessWidget {
  final String title;
  final String centerIcon;
  final Color color;
  final Color backgroundColor;
  final String subtitle;
  final String description;
  final String hintButton;
  final double? centerIconHeight;
  final double? centerIconTop;
  final double? centerIconRight;

  final double height;
  final VoidCallback? onComplete;
  final VoidCallback? onClose;
  const RoadMapMetaDataStrengthDialogBox(
      {super.key,
      required this.height,
      required this.title,
      this.centerIconHeight,
      this.centerIconTop,
      this.centerIconRight,
      required this.centerIcon,
      required this.subtitle,
      required this.color,
      required this.backgroundColor,
      required this.description,
      required this.hintButton,
      required this.onComplete,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.kH,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 30, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Divider(
                        thickness: 3,
                        height: 3,
                        color: Colors.white,
                      ),
                      16.kH,
                      Container(
                        height: 300,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ScrollbarTheme(
                          data: ScrollbarThemeData(
                            thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                              return color;
                            }),
                            thickness: WidgetStateProperty.all(4),
                            radius: const Radius.circular(8),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            scrollbarOrientation: ScrollbarOrientation.right,
                            child: SingleChildScrollView(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(5, (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subtitle, // Use dynamic data
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: appFonts.NunitoBold,
                                        fontWeight: FontWeight.w600,
                                        color: color,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    10.kH,
                                    Text(
                                      description, // Use dynamic data
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: appFonts.NunitoLight,
                                        fontWeight: FontWeight.w600,
                                        color: appColors.contentPrimary,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    10.kH,
                                  ],
                                );
                              }),
                            )),
                          ),
                        ),
                      ),
                      16.kH,
                    ],
                  ),
                ),
                10.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonButton(40, 40.0, Colors.white, appColors.contentSecondary, borderColor: appColors.contentSecondary, hint: "X", onClose),
                    commonButton(230, 40.0, appColors.contentAccent, Colors.white, hint: hintButton, onComplete),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: centerIconTop ?? -10,
            right: centerIconRight ?? 10,
            left: 0,
            child: SizedBox(height: centerIconHeight ?? 100, child: Image.asset(centerIcon, fit: BoxFit.contain)),
          ),
        ],
      ),
    );
  }
}

class RoadMapTileInitialDialogBox extends StatelessWidget {
  final String title;
  final Color? tileColor;
  final String tileLevel;
  final Color? backgroundColor;
  final String? subtitle;
  final String message;
  final double height;
  final String coin;
  const RoadMapTileInitialDialogBox({
    super.key,
    required this.height,
    required this.title,
    this.tileColor,
    this.backgroundColor,
    this.subtitle,
    required this.tileLevel,
    required this.message,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: Colors.white),
            width: 370,
            //height: height * 0.47,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, height * 0.08, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: appFonts.NunitoBold,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  12.kH,
                  Divider(
                    thickness: 1.5,
                    height: 1.5,
                    color: appColors.border,
                  ),
                  8.kH,
                  Text(
                    "Rewarded",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: appFonts.NunitoMedium,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  8.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(appImages.roadMapCoinIcon),
                      Icon(
                        Icons.add,
                        size: 35,
                        color: appColors.contentAccent,
                      ),
                      RichText(
                        text: TextSpan(
                          text: coin,
                          style: TextStyle(
                            fontSize: 40,
                            color: appColors.contentAccent,
                            fontFamily: appFonts.NunitoBold,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: appStrings.pTS,
                              style: TextStyle(
                                fontSize: 16,
                                color: appColors.contentAccent,
                                fontFamily: appFonts.NunitoBold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  12.kH,
                  Divider(
                    thickness: 1.5,
                    height: 1.5,
                    color: appColors.border,
                  ),
                  8.kH,
                  Text(
                    subtitle ?? "Feedback",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: appFonts.NunitoBold,
                      fontWeight: FontWeight.w600,
                      color: appColors.contentAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  6.kH,
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: backgroundColor),
                    child: commonReadMoreText(message),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tileColor ?? appColors.contentAccent,
                border: Border.all(color: Colors.white, width: 10.02),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(tileLevel, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: appFonts.NunitoBold, fontSize: 42)),
              ),
            ),
          ),
          Positioned(
            top: height * 0.04,
            right: 2,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 35, // Circle size
                height: 35,
                decoration: BoxDecoration(
                  color: appColors.contentAccent,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

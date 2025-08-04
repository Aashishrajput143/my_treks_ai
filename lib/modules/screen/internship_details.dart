import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/gradient.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../utils/sized_box_extension.dart';
import '../../common/app_constants_list.dart';
import '../../common/common_widgets.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/font.dart';
import '../../resources/strings.dart';
import '../controller/internship_details_controller.dart';

class InternshipDetailsScreen extends ParentWidget {
  const InternshipDetailsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    InternshipDetailsController controller = Get.put(InternshipDetailsController());
    return Obx(() => Stack(children: [
          Scaffold(
              appBar: AppBar(surfaceTintColor: Colors.white, centerTitle: true, toolbarHeight: 50, leading: InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios, size: 20, color: appColors.contentPrimary))),
              //resizeToAvoidBottomInset: false,
              body: Container(
                  decoration: BoxDecoration(gradient: AppGradients.customGradient),
                  height: h,
                  width: w,
                  child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: controller.getInternshipDetailData.value.data?.companyName?.isNotEmpty ?? false
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Center(
                                    child: Column(children: [
                                  Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: appColors.border, width: 4.0)),
                                      child: CircleAvatar(
                                          radius: 47,
                                          backgroundColor: Colors.transparent,
                                          child: ClipOval(
                                              child: controller.getInternshipDetailData.value.data?.companyLogo?.isNotEmpty ?? false
                                                  ? Image.network(controller.getInternshipDetailData.value.data?.companyLogo ?? "",
                                                      width: 117, height: 117, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Image.asset(appImages.defaultCompanylogo, width: 50, height: 50, fit: BoxFit.cover))
                                                  : SvgPicture.asset(appImages.googleIcon, fit: BoxFit.cover, width: 117, height: 117)))),
                                  10.kH,
                                  Text(controller.getInternshipDetailData.value.data?.companyName ?? "", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary, fontSize: 16)),
                                  2.kH,
                                  Text(controller.getInternshipDetailData.value.data?.title ?? "", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 14))
                                ])),
                                16.kH,
                                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                  SvgPicture.asset(appImages.timer, width: 20, height: 20),
                                  10.kW,
                                  Text(controller.getInternshipDetailData.value.data?.duration ?? "", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 12)),
                                  10.kW,
                                  // SvgPicture.asset(appImages.money, width: 20, height: 20),
                                  // 10.kW,
                                  // Text(controller.getInternshipDetailData.value.data?.stipend ?? '', style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 12))
                                ]),
                                20.kH,
                                commonReadMoreText(controller.getInternshipDetailData.value.data?.description ?? "", trimLine: 3),
                                10.kH,
                                SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: List.generate(
                                            controller.getInternshipDetailData.value.data?.skills?.length ?? 0,
                                            (index1) => Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: commonColorTags(AppConstantsList.randomButton[index1 % AppConstantsList.randomButton.length]["light"], AppConstantsList.randomButton[index1 % AppConstantsList.randomButton.length]["dark"],
                                                    hint: controller.getInternshipDetailData.value.data?.skills?[index1] ?? "", radius: 8, padding: 8))))),
                                Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                                    child: Row(children: [SvgPicture.asset(appImages.documentSummary), 10.kW, Text(appStrings.internshipSummary, style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600))])),
                                Padding(
                                  padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5, bottom: 5),
                                  child: commonReadMoreText(controller.getInternshipDetailData.value.data?.internshipSummary ?? ""),
                                ),
                                Divider(thickness: 1, color: appColors.border),
                                Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                                    child: Row(children: [
                                      SvgPicture.asset(appImages.description, width: 22, height: 22, fit: BoxFit.fill),
                                      10.kW,
                                      Text(appStrings.jobDescription, style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600))
                                    ])),
                                Padding(padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5, bottom: 5), child: commonReadMoreText(controller.getInternshipDetailData.value.data?.jobDescription ?? "")),
                                Divider(thickness: 1, color: appColors.border),
                                Padding(
                                    padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                                    child: Row(children: [SvgPicture.asset(appImages.circleTick), 10.kW, Text(appStrings.eligibility, style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600))])),
                                Padding(padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5, bottom: 5), child: commonReadMoreText(controller.getInternshipDetailData.value.data?.eligibility ?? "")),
                                26.kH,
                                // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [commonButton(w * 0.44, 50,appColors.contentAccent,Colors.white,hint:controller.express.value?"Marked as Interested!": appStrings.expressInterest, () {
                                //       if(!controller.express.value) {controller.savedInternshipInterestApi();}}),
                                //     commonButton(w * 0.44, 50, Colors.white,appColors.contentAccent,borderColor: appColors.contentAccent,hint: appStrings.applyNow, () {CommonMethods.comingSoon(context,w);}),],),
                                controller.express.value
                                    ? commonOverlayButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: "Marked as Interested!", () {})
                                    : commonButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: appStrings.expressInterest, () {
                                        if (!controller.express.value) {
                                          controller.savedInternshipInterestApi();
                                        }
                                      }),
                                30.kH
                              ]))
                          : const SizedBox()))),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
          // internetException(controller.rxRequestStatus.value == Status.ERROR &&controller.error.value.toString() == "No internet",() {}),generalException(controller.rxRequestStatus.value == Status.ERRORcontroller.error.value.toString() != "No internet",() {}),
        ]));
  }
}

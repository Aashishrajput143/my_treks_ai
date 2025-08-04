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
import '../controller/mentor_details_controller.dart';

class MentorDetailsScreen extends ParentWidget {
  const MentorDetailsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    MentorDetailsController controller = Get.put(MentorDetailsController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 30,
              leading: InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios, size: 20, color: appColors.contentPrimary)),
            ),
            body: Container(
              decoration: BoxDecoration(gradient: AppGradients.customGradient),
              height: h,
              width: w,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: controller.rxRequestStatus.value == Status.COMPLETED
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: appColors.contentAccent, width: 2.0)),
                                    child: CircleAvatar(radius: 47, backgroundColor: Colors.transparent, child: ClipOval(child:controller.mentorData.value.data?.avatar?.isNotEmpty??false?Image.network(controller.mentorData.value.data?.avatar??"", fit: BoxFit.cover, width: 124, height: 124): Image.asset(appImages.abram, fit: BoxFit.cover, width: 124, height: 124))),
                                  ),
                                  10.kH,
                                  Text(controller.mentorData.value.data?.name ?? "", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentPrimary, fontSize: 16)),
                                  2.kH,
                                  Text(controller.mentorData.value.data?.title ?? "", style: TextStyle(fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.contentSecondary, fontSize: 14))
                                ],
                              ),
                            ),
                            20.kH,
                            commonReadMoreText(controller.mentorData.value.data?.description ?? ""),
                            16.kH,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                      controller.mentorData.value.data?.topSkills?.length ?? 0,
                                      (index1) => Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: commonButtonWithoutWidth(
                                              AppConstantsList.randomButton[index1 % AppConstantsList.randomButton.length]["light"],
                                              AppConstantsList.randomButton[index1 % AppConstantsList.randomButton.length]["dark"],
                                              hint: controller.mentorData.value.data?.topSkills?[index1] ?? "",
                                              radius: 8,
                                              () {})))),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(appImages.ticket),
                            //       10.kW,
                            //       Text(
                            //         controller.mentorData.value.data?.contact?.email??"",
                            //         style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoMedium, fontSize: 14, fontWeight: FontWeight.w600),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Divider(
                            //   thickness: 1,
                            //   color: appColors.border,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(appImages.callIcon),
                            //       10.kW,
                            //       Text(
                            //         controller.mentorData.value.data?.contact?.phone??"",
                            //         style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoMedium, fontSize: 14, fontWeight: FontWeight.w600),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Divider(
                            //   thickness: 1,
                            //   color: appColors.border,
                            // ),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                            //     child: Row(children: [
                            //       SvgPicture.asset(appImages.topicsIcon),
                            //       10.kW,
                            //       Text(
                            //         appStrings.topics,
                            //         style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600),
                            //       )
                            //     ])),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5, bottom: 5),
                            //   child: Wrap(
                            //       spacing: 8,
                            //       runSpacing: -4,
                            //       children: List.generate(
                            //           controller.mentorData.value.data?.interests?.length ?? 0,
                            //           (index) => Padding(
                            //               padding: const EdgeInsets.only(right: 8.0),
                            //               child: commonButtonBlack(appColors.buttonStateDisabled, appColors.contentPrimary, () {}, hint: controller.mentorData.value.data?.interests?[index] ?? "", borderColor: appColors.contentPrimary)))),
                            // ),
                            // Divider(thickness: 1, color: appColors.border),
                            Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                                child: Row(children: [
                                  SvgPicture.asset(appImages.experienceIcon2),
                                  10.kW,
                                  Text(
                                    appStrings.professionalBackground,
                                    style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600),
                                  )
                                ])),
                            Padding(
                              padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5),
                              child: Column(
                                children: [
                                  if (controller.mentorData.value.data?.professionalBackground != null)
                                    ...List.generate(
                                      controller.mentorData.value.data!.professionalBackground!.length,
                                      (index) {
                                        final background = controller.mentorData.value.data!.professionalBackground![index];
                                        return Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                                child: Text("${background.position ?? ""} at ${background.company ?? ""}, ${background.location ?? ""} ${background.period ?? ""}, ${background.description ?? ""}",
                                                    style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoMedium, fontSize: 14, fontWeight: FontWeight.w600))),
                                            // Show divider only if it's not the last item
                                            if (index != controller.mentorData.value.data!.professionalBackground!.length - 1) Divider(thickness: 1, color: appColors.border)
                                          ],
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                            Divider(thickness: 1, color: appColors.border),
                            Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                                child: Row(children: [
                                  SvgPicture.asset(appImages.academicIcon),
                                  10.kW,
                                  Text(
                                    appStrings.academicBackground,
                                    style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600),
                                  )
                                ])),
                            Padding(
                              padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5),
                              child: Column(
                                children: [
                                  if (controller.mentorData.value.data?.education != null)
                                    ...List.generate(
                                      controller.mentorData.value.data!.education!.length,
                                      (index) {
                                        final background = controller.mentorData.value.data!.education![index];
                                        return Column(children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                                              child: Text("${background.degree ?? ""} in ${background.fieldOfStudy ?? ""}, ${background.institution ?? ""} (${background.year ?? ""})",
                                                  style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoMedium, fontSize: 14, fontWeight: FontWeight.w600))),
                                          // Show divider only if it's not the last item
                                          if (index != controller.mentorData.value.data!.education!.length - 1) Divider(thickness: 1, color: appColors.border)
                                        ]);
                                      },
                                    ),
                                ],
                              ),
                            ),
                            // Divider(thickness: 1, color: appColors.border),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                            //     child: Row(children: [
                            //       SvgPicture.asset(appImages.skillsIcon),
                            //       10.kW,
                            //       Text(
                            //         appStrings.skills,
                            //         style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600),
                            //       )
                            //     ])),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5, bottom: 5),
                            //   child: Wrap(
                            //       spacing: 8,
                            //       runSpacing: -4,
                            //       children: List.generate(
                            //           controller.mentorData.value.data?.skills?.primary?.length ?? 0,
                            //           (index) => Padding(
                            //               padding: const EdgeInsets.only(right: 8.0),
                            //               child: commonButtonBlack(appColors.buttonStateDisabled, appColors.contentPrimary, () {}, hint: controller.mentorData.value.data?.skills?.primary?[index] ?? "", borderColor: appColors.contentPrimary)))),
                            // ),
                            // Divider(
                            //   thickness: 1,
                            //   color: appColors.border,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(appImages.skillsIcon),
                            //       10.kW,
                            //       Text(
                            //         appStrings.otherSkills,
                            //         style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5, bottom: 5),
                            //   child: Wrap(
                            //     spacing: 8,
                            //     runSpacing: -4,
                            //     children: List.generate(
                            //       controller.mentorData.value.data?.skills?.other?.length??
                            //           0,
                            //           (index) => Padding(
                            //         padding: const EdgeInsets.only(right: 8.0),
                            //         child: commonButtonBlack(
                            //           appColors.buttonStateDisabled,
                            //           appColors.contentPrimary,
                            //               () {},
                            //           hint: controller.mentorData.value.data?.skills?.other?[index]??"",
                            //           borderColor: appColors.contentPrimary,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Divider(thickness: 1, color: appColors.border),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                            //     child: Row(children: [
                            //       SvgPicture.asset(appImages.careerIcon),
                            //       10.kW,
                            //       Text(
                            //         appStrings.careerSummary,
                            //         style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600),
                            //       )
                            //     ])),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5, bottom: 5),
                            //   child: commonReadMoreText(controller.mentorData.value.data?.summary ?? "", trimLine: 5),
                            // ),
                            // Divider(
                            //   thickness: 1,
                            //   color: appColors.border,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(appImages.achievementsIcon),
                            //       10.kW,
                            //       Text(
                            //         appStrings.achievements,
                            //         style: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold, fontSize: 18, fontWeight: FontWeight.w600),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 46.0, right: 16, top: 5,bottom: 5),
                            //   child:
                            //   ReadMoreText(
                            //     controller.mentorData.value.data?.rawData?.achievements??"",
                            //     style:TextStyle(
                            //       color: Colors.black,
                            //       fontFamily: appFonts.NunitoMedium,
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w600,
                            //     ) ,
                            //     trimLines: controller.line.value,
                            //     trimMode: TrimMode.Line,
                            //     colorClickableText: appColors.contentAccent,
                            //     trimCollapsedText: appStrings.trimCollapsedText,
                            //     textAlign: TextAlign.justify,
                            //     trimExpandedText: appStrings.trimExpandedText,
                            //     delimiter: '',
                            //     moreStyle: TextStyle(
                            //       color: appColors.contentAccent,
                            //       fontFamily: appFonts.NunitoBold,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //     lessStyle: TextStyle(
                            //       color: appColors.contentAccent,
                            //       fontFamily: appFonts.NunitoBold,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                            // Divider(
                            //   thickness: 1,
                            //   color: appColors.border,
                            // ),

                            26.kH,
                            commonButton(double.infinity, 50, appColors.contentAccent, Colors.white, hint: appStrings.requestASession, () async {
                              //controller.mainController.selectedIndex.value = 11;
                              controller.onClickReqSession();
                            }),
                            10.kH, // Bottom spacing
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
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
}

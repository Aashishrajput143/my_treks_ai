import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';
import 'package:vroar/utils/sized_box_extension.dart';
import '../../common/common_widgets.dart';
import '../../common/gradient.dart';
import '../../common/my_utils.dart';
import '../../data/response/status.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';
import '../controller/book_session_controller.dart';

class BookSessionScreen extends ParentWidget {
  const BookSessionScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    BookSessionController controller = Get.put(BookSessionController());
    return Obx(
      () => Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppGradients.customGradient),
            padding: EdgeInsets.only(bottom: h <= 677 ? 0 : 22),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                centerTitle: true,
                toolbarHeight: 50,
                leading: InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back_ios,
                      size: 20, color: appColors.contentPrimary),
                ),
                title: Text(
                  appStrings.bookSession,
                  style: TextStyle(
                      fontSize: 24,
                      color: appColors.contentPrimary,
                      fontFamily: appFonts.NunitoBold,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              body: SizedBox(
                // decoration: BoxDecoration(gradient: AppGradients.customGradient),
                height: h,
                width: w,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   appStrings.preferredTime,
                        //   style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        // 8.kH,
                        // dropdownButton(
                        //   controller.selectTime,
                        //   controller.selectedSessionType.value,
                        //   w,
                        //   50,
                        //   Colors.white,
                        //   hint: appStrings.selectTime,
                        //   (newValue) {
                        //     controller.selectedSessionType.value = newValue!;
                        //   },
                        // ),
                        // 16.kH,
                        Text(
                          appStrings.sessionAgenda,
                          style: TextStyle(
                              color: appColors.contentPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        8.kH,
                        commonTextField(
                          controller.agendaDescriptionController.value,
                          controller.agendaDescriptionFocusNode.value,
                          w,
                          (value) {
                            if (value.isNotEmpty) {
                              controller.isAgenda.value = true;
                            } else {
                              controller.isAgenda.value = false;
                            }
                          },
                          onChange: (value) {
                            if (value.isNotEmpty) {
                              controller.isAgenda.value = true;
                            } else {
                              controller.isAgenda.value = false;
                            }
                          },
                          hint: appStrings.sessionAgendaDesc,
                          maxLines: h <= 677 ? 6 : 12,
                          maxLength: 1000,
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                            RemoveTrailingPeriodsFormatter(),
                            SpecialCharacterValidator(),
                            EmojiInputFormatter(),
                            LengthLimitingTextInputFormatter(1000)
                          ],
                        ),
                        // 16.kH,
                        // Text(appStrings.careerPaths, style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                        // 8.kH,
                        // commonTextField(
                        //   controller.careerDescriptionController.value,
                        //   controller.careerDescriptionFocusNode.value,
                        //   w,
                        //   (value) {},
                        //   hint: appStrings.careerPathsDesc,
                        //   maxLines: 7,
                        //   maxLength: 1000,
                        //   inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(1000)],
                        // ),
                        SizedBox(height: Platform.isIOS ? 50 : 20),
                        // 20.kH,
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: commonButton(
                  double.infinity,
                  50,
                  controller.isAgenda.value
                      ? appColors.contentAccent
                      : appColors.buttonStateDisabled,
                  controller.isAgenda.value
                      ? Colors.white
                      : appColors.buttonTextStateDisabled,
                  hint: appStrings.requestASession,
                  () =>  controller.isAgenda.value
                      ? controller.bookMentorSessionApi()
                      : null
                  //=> controller.mainController.selectedIndex.value = 12
                  ,
                ),
              ),
            ),
          ),
          progressBar(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }
}

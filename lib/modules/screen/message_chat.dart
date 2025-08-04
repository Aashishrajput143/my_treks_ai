import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/message_chat_controller.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';

import '../../common/common_widgets.dart';
import '../../resources/images.dart';

class MessageChatScreen extends ParentWidget {
  const MessageChatScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    MessageChatController controller = Get.put(MessageChatController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h * 0.1),
        child: Container(
          padding: EdgeInsets.only(top: h * 0.03),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 5,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.mainController.selectedIndex.value = 3;
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: appColors.contentPrimary,
                    ),
                  ),
                  SizedBox(width: w * 0.05),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          appImages.abram,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: w * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Abram Stanton",
                        style: TextStyle(
                          fontFamily: appFonts.NunitoBold,
                          fontWeight: FontWeight.w600,
                          color: appColors.contentPrimary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Active Now",
                        style: TextStyle(
                          fontFamily: appFonts.NunitoRegular,
                          fontWeight: FontWeight.w600,
                          color: appColors.buttonTextStateDisabled,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 3.0),
                    child: PopupMenuButton<int>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded border
                      ),
                      padding: const EdgeInsets.all(8),
                      offset: const Offset(0, 50),
                      onSelected: (value) {
                        if (value == 1) {
                          // Handle Profile Click
                        } else if (value == 2) {
                          // Handle Report Issue Click
                        } else if (value == 3) {
                          // Handle Mute Notification Click
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.perm_identity, size: 25, color: appColors.contentPrimary),
                                    const SizedBox(width: 10),
                                    Text("Profile", style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary)),
                                  ],
                                ),
                              ),
                              Divider(
                                color: appColors.border,
                                thickness: 1.5,
                              ), // Underline separator
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.report_problem_outlined, size: 25, color: appColors.contentPrimary),
                                    const SizedBox(width: 10),
                                    Text("Report Issue", style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary)),
                                  ],
                                ),
                              ),
                              Divider(
                                color: appColors.border,
                                thickness: 1.5,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.notifications_outlined, size: 25, color: appColors.contentPrimary),
                                    const SizedBox(width: 10),
                                    Text("Mute Notification", style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: w,
        height: h,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            children: [
              Image.asset(
                appImages.messageBackground,
                width: w,
                height: h * 0.82,
                fit: BoxFit.cover,
              ),
              Container(
                width: w,
                height: h * 0.82,
                color: appColors.accentBlue.withOpacity(0.75),
              ),
              Positioned.fill(
                bottom: Platform.isIOS ? h * 0.2 : h * 0.133,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: w * 0.72,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: appColors.contentAccent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Hi Abram Stanton!\nI'm looking to schedule a session.\n\n"
                              "Preferred time: Friday at 2:00 PM.\n\n"
                              "Session Agenda: Project management strategies and effective team communication.\n\n"
                              "Career paths: I'm currently pursuing a career in software development and project management.\n\n"
                              "Thank you!",
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0), // Adjust as needed
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "4:45 pm",
                            style: TextStyle(
                              color: appColors.contentPrimary,
                              fontFamily: appFonts.NunitoRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: w * 0.72,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: appColors.contentAccent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Hi Abram Stanton!\nI'm looking to schedule a session.\n\n"
                              "Preferred time: Friday at 2:00 PM.\n\n"
                              "Session Agenda: Project management strategies and effective team communication.\n\n"
                              "Career paths: I'm currently pursuing a career in software development and project management.\n\n"
                              "Thank you!",
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0), // Adjust as needed
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "4:47 pm",
                            style: TextStyle(
                              color: appColors.contentPrimary,
                              fontFamily: appFonts.NunitoRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: w * 0.72,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: appColors.contentAccent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Hi Abram Stanton!\nI'm looking to schedule a session.\n\n"
                              "Preferred time: Friday at 2:00 PM.\n\n"
                              "Session Agenda: Project management strategies and effective team communication.\n\n"
                              "Career paths: I'm currently pursuing a career in software development and project management.\n\n"
                              "Thank you!",
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0), // Adjust as needed
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "4:50 pm",
                            style: TextStyle(
                              color: appColors.contentPrimary,
                              fontFamily: appFonts.NunitoRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: Platform.isIOS ? h * 0.1 : h * 0.05,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      commonChatField(controller.messageController.value, controller.messageFocusNode.value, w * 0.8, () {
                        showMenu(
                          menuPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Rounded border
                          ),
                          context: context,
                          position: RelativeRect.fromLTRB(50, h * 0.67, 40, 0),
                          items: [
                            PopupMenuItem(
                              value: 'document',
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.insert_drive_file_outlined),
                                    title: Text(
                                      'Document',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Divider(
                                    color: appColors.border,
                                    thickness: 1.5,
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'image',
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.image_outlined),
                                title: Text(
                                  'Image',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ).then((value) {
                          if (value != null) {
                            // Handle the selected item
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Selected: $value")),
                            );
                          }
                        });
                      }, (value) {}, hint: "Type here"),
                      const SizedBox(width: 10),
                      Material(
                        color: appColors.accentGreen,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(appImages.sendIcon),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

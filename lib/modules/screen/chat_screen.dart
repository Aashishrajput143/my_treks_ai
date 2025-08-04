import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vroar/common/common_widgets.dart';
import 'package:vroar/main.dart';
import 'package:vroar/modules/controller/chat_screen_controller.dart';
import 'package:vroar/resources/colors.dart';
import 'package:vroar/resources/font.dart';

import '../../common/gradient.dart';
import '../../resources/formatter.dart';
import '../../resources/strings.dart';

class ChatScreen extends ParentWidget {
  const ChatScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ChatScreenController controller = Get.put(ChatScreenController());
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: w,
          height: h * 0.92,
          decoration: BoxDecoration(gradient: AppGradients.customGradient),
          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.07),
              Text(
                appStrings.messages,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: appFonts.NunitoBold,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h * 0.02),
              commonSearchField(
                controller.searchController.value,
                controller.searchFocusNode.value,
                w,
                (value) {},
                hint: appStrings.searchByName,
                contentPadding: 14,
                inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(30)],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  commonButtonWithoutWidth(controller.buttonType.value ? appColors.primaryColorVariable : Colors.white, controller.buttonType.value ? appColors.contentAccent : appColors.contentPrimary,
                      hint: appStrings.all, radius: 40, borderColor: controller.buttonType.value ? appColors.contentAccent : appColors.border, () {
                    controller.buttonType.value = true;
                  }),
                  const SizedBox(width: 6),
                  commonButtonWithoutWidth(controller.buttonType.value ? Colors.white : appColors.primaryColorVariable, controller.buttonType.value ? appColors.contentPrimary : appColors.contentAccent,
                      hint: appStrings.unRead, radius: 40, borderColor: controller.buttonType.value ? appColors.border : appColors.contentAccent, () {
                    controller.buttonType.value = false;
                  }),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: Platform.isIOS ? h * 0.6 : h * 0.643,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.chatData.length,
                  itemBuilder: (context, index) {
                    final chat = controller.chatData[index];
                    return InkWell(
                      onTap: () {},
                      // onTap: () => controller.mainController.selectedIndex.value = 12,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(chat['image']),
                                ),
                                if (chat['online'])
                                  Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 1),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: Text(
                              chat['name'],
                              style: TextStyle(color: appColors.contentPrimary, fontSize: 16),
                            ),
                            subtitle: Text(
                              chat['message'],
                              style: TextStyle(color: appColors.buttonTextStateDisabled),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  chat['time'],
                                  style: TextStyle(color: appColors.buttonTextStateDisabled, fontSize: 12),
                                ),
                                const SizedBox(height: 5),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.green,
                                  child: Text(
                                    '${chat['unread']}',
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          index < controller.chatData.length - 1 ? Divider(color: appColors.border, thickness: 1.2) : const SizedBox(height: 6),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

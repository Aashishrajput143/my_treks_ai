import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_screen_controller.dart';

class MessageChatController extends GetxController {
  var messageController = TextEditingController().obs;
  var messageFocusNode = FocusNode().obs;

  get rxRequestStatus => null;
  final CommonScreenController mainController = Get.put(CommonScreenController());
}

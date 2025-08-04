import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/images.dart';

import 'common_screen_controller.dart';

class ChatScreenController extends GetxController {
  var searchController = TextEditingController().obs;
  var searchFocusNode = FocusNode().obs;
  var buttonType = true.obs;

  final List<Map<String, dynamic>> chatData = [
    {'name': 'Patel Vishal', 'message': 'Hello 👋', 'time': '4:05pm', 'image': appImages.thompson, 'unread': 3, 'online': true},
    {'name': 'Emery', 'message': 'Hello 👋', 'time': '3:05pm', 'image': appImages.jhony, 'unread': 3, 'online': false},
    {'name': 'Zain', 'message': 'Hello 👋', 'time': '2:10pm', 'image': appImages.thompson, 'unread': 3, 'online': false},
    {'name': 'Ahmad', 'message': 'Hello 👋', 'time': 'Yesterday', 'image': appImages.avatar, 'unread': 3, 'online': true},
    {'name': 'Corey', 'message': 'Hello 👋', 'time': 'Yesterday', 'image': appImages.jhony, 'unread': 3, 'online': false},
    {'name': 'Schleifer', 'message': 'Hello 👋', 'time': '24/11/24', 'image': appImages.thompson, 'unread': 3, 'online': false},
    {'name': 'Tester', 'message': 'Hello 👋', 'time': '24/11/24', 'image': appImages.avatar, 'unread': 3, 'online': false}
  ];

  final CommonScreenController mainController = Get.put(CommonScreenController());
}

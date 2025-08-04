import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MentorSignUpController extends GetxController {
  var role = "".obs;

  @override
  void onInit() {
    super.onInit();
    role.value = Get.arguments ?? "";
  }

  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
}

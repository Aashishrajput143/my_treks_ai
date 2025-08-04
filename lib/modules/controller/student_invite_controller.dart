import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/app_constants_list.dart';

class StudentInviteController extends GetxController {
  var firstNameController = TextEditingController().obs;
  var firstNameFocusNode = FocusNode().obs;
  var lastNameController = TextEditingController().obs;
  var lastNameFocusNode = FocusNode().obs;
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var phoneController = TextEditingController().obs;
  var phoneNumberFocusNode = FocusNode().obs;

  var countryCode = "".obs;
  List<String> gradeOptions = AppConstantsList.gradeOptions;
  var selectedGrade = Rxn<String>();

  get rxRequestStatus => null;
  List<String> relationOptions = AppConstantsList.relationOptions;
  var selectedRelation = Rxn<String>();
}

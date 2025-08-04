import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../common/my_alert_dialog.dart';
import '../../data/response/status.dart';
import '../../models/change_password_model.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/profile_repository.dart';
import 'common_screen_controller.dart';

class ChangePasswordController extends GetxController {
  var currentPasswordController = TextEditingController().obs;
  var currentPasswordFocusNode = FocusNode().obs;
  var passwordController = TextEditingController().obs;
  var passwordFocusNode = FocusNode().obs;
  var cPasswordController = TextEditingController().obs;
  var cPasswordFocusNode = FocusNode().obs;
  var showPassword = true.obs;
  var showCPassword = true.obs;
  var showCurrentPassword = true.obs;
  var inValidCouponCode = Rxn<String>();

  final api = ProfileRepository();

  final CommonScreenController mainController = Get.put(CommonScreenController());

  String? isValidate() {
    if (currentPasswordController.value.text.isEmpty && passwordController.value.text.isEmpty && cPasswordController.value.text.isEmpty) {
      return "please fill All the mandatory Fields";
    } else {
      if (currentPasswordController.value.text.isEmpty) {
        return "please enter the Current Password";
      }
      if (passwordController.value.text.isEmpty) {
        return "please enter the New Password";
      }
      if (cPasswordController.value.text.isEmpty) {
        return "please enter the Confirm Password";
      }
      if (passwordController.value.text != cPasswordController.value.text) {
        return "New Password & Confirm Password Not Match";
      }
    }
    return null;
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final changePasswordData = ChangePasswordModel().obs;
  void setError(String value) => error.value = value;
  var error = RxnString();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setChangePasswordData(ChangePasswordModel value) => changePasswordData.value = value;

  Future<void>changePasswordApi(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "oldPassword": currentPasswordController.value.text,
        "newPassword": passwordController.value.text
      };

      api.changePassword(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setChangePasswordData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        Utils.savePreferenceValues(Constants.accessToken, value.data?.accessToken ?? "");
        redirectData(context);
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            inValidCouponCode.value=errorResponse['message'];
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
        Utils.printLog("stackTrace===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  redirectData(context){
    currentPasswordController.value.text="";
    passwordController.value.text="";
    cPasswordController.value.text="";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Timer(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
          mainController.selectedIndex.value=4;
        });
        return CustomAlertDialog(
          height: 440,
          header: appStrings.passwordUpdated,
          message: appStrings.passwordUpdatedMessage,
        );
      },
    );
  }

}

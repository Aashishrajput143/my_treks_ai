import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vroar/models/forget_email_model.dart';
import 'package:vroar/modules/repository/forget_password_repository.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';

class ForgetPasswordEmailController extends GetxController {
  final _api = ForgetPasswordRepository();
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var isValid = false.obs;
  RxnString errorEmail = RxnString();


  final rxRequestStatus = Status.COMPLETED.obs;
  final forgetEmailData = ForgetEmailModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setForgetEmailData(ForgetEmailModel value) => forgetEmailData.value = value;

  Future<void> forgetEmailApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "email": emailController.value.text
      };
      _api.getForgetEmailApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setForgetEmailData(value);
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        redirect(value.data?.referenceId??"0",emailController.value.text);
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            CommonMethods.showToast(errorResponse['message']);
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

  void redirect(String referenceId, String emailId) {
    Get.toNamed(RoutesClass.verificationCode, arguments: {
      'referenceId': int.parse(referenceId),
      'emailId': emailId,
      'forget': true,
    });
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:vroar/models/forget_password_model.dart';
import 'package:vroar/models/verify_otp_model.dart';
import 'package:vroar/modules/repository/forget_password_repository.dart';

import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../common/my_alert_dialog.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';
import '../repository/signup_repository.dart';

class VerificationCodeController extends GetxController {
  var referenceId = 0.obs;
  var emailId = "".obs;
  var forget=false.obs;
  final _api = SignupRepository();
  final forgetApi = ForgetPasswordRepository();

  var otpController = TextEditingController().obs;

  RxInt seconds = 60.obs;
  Timer _timer = Timer.periodic(const Duration(seconds: 0), (_) {});

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    referenceId.value = arguments['referenceId'];
    emailId.value = arguments['emailId'];
    forget.value = arguments['forget'];
    print(referenceId.value);
  }

  Future<void> _initializeBackgroundExecution() async {
    await FlutterBackground.initialize();
  }

  void startTimer() {
    _initializeBackgroundExecution();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        seconds.value = 60;
        _timer.cancel();
      }
    });
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final verifyOtpData = VerifyOtpModel().obs;
  final verifyForgetOtpData = ForgetPasswordModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setVerifyOtpData(VerifyOtpModel value) => verifyOtpData.value = value;
  void setVerifyForgetOtpData(ForgetPasswordModel value) => verifyForgetOtpData.value = value;

  Future<void> verifyOtpApi(context, h) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"referenceId": referenceId.value, "otp": otpController.value.text};
      _api.verifyOTPApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setVerifyOtpData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        Utils.savePreferenceValues(Constants.accessToken, value.data?.accessToken ?? "");
        Utils.savePreferenceValues(Constants.refreshToken, value.data?.refreshToken ?? "");
        Utils.savePreferenceValues(Constants.role, value.data?.group ?? "");
        print("redirect");
        redirect(context, h, value.data?.group);
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
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> verifyForgetOtpApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"referenceId": referenceId.value, "otp": otpController.value.text};
      forgetApi.getForgetPasswordApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setVerifyForgetOtpData(value);
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        Get.toNamed(RoutesClass.forgetPassword, arguments: {
          'referenceId': referenceId.value,
          'otp': otpController.value.text,
        });
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
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void redirect(context, h, role) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
          role == "STUDENT" ? Get.offAllNamed(RoutesClass.parentInvite, arguments: [{'isOnBoarding': false},{"skip":true}]) : Get.offAllNamed(RoutesClass.studentInvite);
        });
        return CustomAlertDialog(
          message: appStrings.verificationEmailDialog,
          height: 440,
        );
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}

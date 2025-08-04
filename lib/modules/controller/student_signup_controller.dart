import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:vroar/models/verify_email_model.dart';
import 'package:vroar/modules/controller/social_login_controller.dart';

import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/apple_login_model.dart';
import '../../models/google_login_model.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';
import '../repository/login_repository.dart';

class StudentSignUpController extends GetxController {
  final _api = LoginRepository();
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var isValid = false.obs;
  RxnString errorEmail = RxnString();

  SocialLoginController socialLoginController = Get.put(SocialLoginController());


  final rxRequestStatus = Status.COMPLETED.obs;
  final getVerifyEmailData = VerifyEmailModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setVerifyEmailData(VerifyEmailModel value) =>
      getVerifyEmailData.value = value;

  void handleError(error, stackTrace) {
    setError(error.toString());
    setRxRequestStatus(Status.ERROR);
    if (error.toString().contains("{")) {
      final errorResponse = json.decode(error.toString());
      CommonMethods.showToast(
          errorResponse is Map && errorResponse.containsKey('message')
              ? errorResponse['message']
              : "An unexpected error occurred.");
    }
    Utils.printLog("Error===> ${error.toString()}");
    Utils.printLog("stackTrace===> ${stackTrace.toString()}");
  }

  Future<void> verifyEmailApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"email": emailController.value.text};
      _api.verifyEmailApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setVerifyEmailData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        nextPage();
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

  void nextPage() {
    Get.toNamed(
      RoutesClass.signUpDetails,
      arguments: {
        'role': "STUDENT",
        'emailId': emailController.value.text,
      },
    );
  }
}

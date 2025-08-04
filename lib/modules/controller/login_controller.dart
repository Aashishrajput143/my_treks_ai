import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/app_url/app_base_url.dart';
import '../../data/app_url/app_url.dart';
import '../../models/login_model.dart';
import '../../modules/controller/social_login_controller.dart';
import '../../routes/routes_class.dart';
import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final _api = LoginRepository();

  var passwordController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordFocusNode = FocusNode().obs;
  var emailFocusNode = FocusNode().obs;
  var showPassword = true.obs;
  var isEmailValid = false.obs;
  RxnString errorEmail = RxnString();
  var isPasswordValid = false.obs;
  RxnString errorPassword = RxnString();

  SocialLoginController socialLoginController = Get.put(SocialLoginController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final loginData = LoginModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setLoginData(LoginModel value) => loginData.value = value;

  void handleError(error, stackTrace) {
    setError(error.toString());
    setRxRequestStatus(Status.ERROR);
    if (error.toString().contains("{")) {
      final errorResponse = json.decode(error.toString());
      CommonMethods.showToast(errorResponse is Map && errorResponse.containsKey('message') ? errorResponse['message'] : "An unexpected error occurred.");
    }
    Utils.printLog("Error===> ${error.toString()}");
    Utils.printLog("stackTrace===> ${stackTrace.toString()}");
  }

  Future<void> loginApi(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      Map<String, dynamic> data = {
        "email": emailController.value.text,
        "password": passwordController.value.text,
      };
      _api.loginApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setLoginData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        Utils.savePreferenceValues(Constants.accessToken, value.data?.accessToken ?? "");
        Utils.savePreferenceValues(Constants.refreshToken, value.data?.refreshToken ?? "");
        Utils.savePreferenceValues(Constants.role, value.data?.role ?? "");
        debugPrint("redirect");
        redirect(value.data?.role);
      }).onError((error, stackTrace) {
        handleError(error, stackTrace);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void redirect(role) {
    if (role != null && role != "") {
      debugPrint("commonScreen $role");
      role == "STUDENT" ? Get.offAllNamed(RoutesClass.commonScreen, arguments: role) : websiteLaunch();
    }
    print("Login Successful");
  }

  websiteLaunch() {
    var websiteUrl = AppUrl.baseUrl == AppBaseUrl.baseUrlMyTreksDev
        ? 'https://dev.accounts.mytreks.ai/login'
        : AppUrl.baseUrl == AppBaseUrl.baseUrlMyTreksUAT
            ? 'https://uat.accounts.mytreks.ai/login'
            : 'https://accounts.mytreks.ai/login';
    final uri = Uri.parse(websiteUrl);
    Utils.clearPreferenceValues();
    Utils.savePreferenceValues(Constants.isOnBoarding, "No");
    launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}

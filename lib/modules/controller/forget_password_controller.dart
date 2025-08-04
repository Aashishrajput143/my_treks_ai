import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/forget_password_model.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';
import '../repository/forget_password_repository.dart';

class ForgetPasswordController extends GetxController {
  final _api = ForgetPasswordRepository();
  var passwordController = TextEditingController().obs;
  var passwordFocusNode = FocusNode().obs;
  var cPasswordController = TextEditingController().obs;
  var cPasswordFocusNode = FocusNode().obs;
  var showPassword = true.obs;
  var showCPassword = true.obs;
  var otp = "".obs;
  var referenceId = 0.obs;
  var isValid=false.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    referenceId.value = arguments['referenceId'];
    otp.value = arguments['otp'];
    print(referenceId.value);
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final forgetPasswordData = ForgetPasswordModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setForgetPasswordData(ForgetPasswordModel value) => forgetPasswordData.value = value;


  Future<void> forgetPasswordApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"referenceId": referenceId.value, "otp": otp.value,"password":passwordController.value.text};
      _api.getForgetPasswordApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setForgetPasswordData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        Get.toNamed(RoutesClass.forgetPasswordSuccess);
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


}

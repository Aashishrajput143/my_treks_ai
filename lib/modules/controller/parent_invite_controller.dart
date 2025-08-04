import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/app_constants_list.dart';
import 'package:vroar/models/user_invite_model.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../resources/validator.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';
import '../repository/signup_repository.dart';
import '../screen/parent_invitation_sucess.dart';

class ParentInviteController extends GetxController {
  final api = SignupRepository();
  dynamic arguments = Get.arguments;
  var firstNameController = TextEditingController().obs;
  var firstNameFocusNode = FocusNode().obs;
  var lastNameController = TextEditingController().obs;
  var lastNameFocusNode = FocusNode().obs;
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var phoneController = TextEditingController().obs;
  var phoneNumberFocusNode = FocusNode().obs;
  var isSkip = true.obs;
  RxnString errorEmail = RxnString();
  var phoneTotalCount = 10.obs;


  @override
  void onInit() {
    super.onInit();
    isSkip.value = arguments?[1]['skip'] ?? false;
    print(isSkip);
  }

  var countryCode = "+1".obs;

  List<String> relationOptions = AppConstantsList.relationOptions;
  var selectedRelation = Rxn<String>();

  String? isValidate() {
      if (firstNameController.value.text.isEmpty) {
        return "please enter the first name";
      }
      if (lastNameController.value.text.isEmpty) {
        return "please enter the last name";
      }
      if (emailController.value.text.isEmpty) {
        return "please enter the email";
      }
      // if ((Validator.validateEmail(emailFocusNode.value.hasPrimaryFocus ? "" : emailController.value.text)) != null) {
      //   return Validator.validateEmail(emailFocusNode.value.hasPrimaryFocus ? "" : emailController.value.text);
      // }
      if (selectedRelation.value == null) {
        return "please enter the Relation";
      }
    return null;
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final userInviteData = UserInviteModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) {
    rxRequestStatus.value = value;
    update();
  }

  void setUserInviteData(UserInviteModel value) => userInviteData.value = value;

  Future<void> userInviteApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");
    print(arguments);
    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "email": emailController.value.text,
        "firstName": firstNameController.value.text,
        "lastName": lastNameController.value.text,
        if (phoneController.value.text.isNotEmpty) "phoneNo": phoneController.value.text,
        if (phoneController.value.text.isNotEmpty) "countryCode": countryCode.value,
        "relationshipToStudent": selectedRelation.value,
        //"grade": "10th"
      };
      api.userInviteApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setUserInviteData(value);
        // CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        update();
        redirect();
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

  void redirect() {
    setRxRequestStatus(Status.COMPLETED);
    Get.off(() => ParentInvitationSuccessScreen(isOnBoardingRoadmap: arguments[0]['isOnBoarding'] ?? false));
    // Get.toNamed(RoutesClass.parentInviteSuccess);
  }
}

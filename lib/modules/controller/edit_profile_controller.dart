import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/app_constants_list.dart';

import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/update_profile_model.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/signup_repository.dart';
import 'common_screen_controller.dart';

class EditProfileController extends GetxController {
  var firstNameController = TextEditingController().obs;
  var firstNameFocusNode = FocusNode().obs;
  var lastNameController = TextEditingController().obs;
  var lastNameFocusNode = FocusNode().obs;
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var phoneController = TextEditingController().obs;
  var phoneNumberFocusNode = FocusNode().obs;
  final _api = SignupRepository();
  List<String> gradeOptions = AppConstantsList.gradeOptions;
  var selectedGrade = Rxn<String>();
  final CommonScreenController mainController =
      Get.put(CommonScreenController());
  var countryCode = "".obs;
  var isChangePass = false.obs;
  var phoneTotalCount = 10.obs;


  Future<void> change() async {
    //mainController.getProfileApi();
    setData();
    isChangePass.value= (await Utils.getPreferenceValues(Constants.isSocialLogin))==null || (await Utils.getPreferenceValues(Constants.isSocialLogin))=="";

    print("isChangePass${isChangePass.value}");
  }

  void setData(){
    if (mainController.getProfileData.value.data?.firstName?.isNotEmpty ??
        false) {
      firstNameController.value.text =
          mainController.getProfileData.value.data?.firstName ?? "";
    }
    if (mainController.getProfileData.value.data?.lastName?.isNotEmpty ??
        false) {
      lastNameController.value.text =
          mainController.getProfileData.value.data?.lastName ?? "";
    }
    if (mainController.getProfileData.value.data?.email?.isNotEmpty ?? false) {
      emailController.value.text =
          mainController.getProfileData.value.data?.email ?? "";
    }
    if (mainController.getProfileData.value.data?.phoneNo?.isNotEmpty ??
        false) {
      phoneController.value.text =
          mainController.getProfileData.value.data?.phoneNo ?? "";
      phoneTotalCount.value=mainController.getProfileData.value.data?.phoneNo?.length??10;
    }

    if (mainController.getProfileData.value.data?.countryCode?.isNotEmpty ??
        false) {
      countryCode.value =
          mainController.getProfileData.value.data?.countryCode ?? "";
      print("countryCode.value ==>${countryCode.value }");
    }
    if (mainController.getProfileData.value.data?.grade?.isNotEmpty ?? false) {
      selectedGrade.value =
          mainController.getProfileData.value.data?.grade ?? "";
    }
  }

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
      if (selectedGrade.value==null) {
        return "please Select the Grade";
      }
    return null;
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final updateProfileData = UpdateProfileModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setUpdateProfileData(UpdateProfileModel value) =>
      updateProfileData.value = value;

  Future<void> updateProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "firstName": firstNameController.value.text,
        "lastName": lastNameController.value.text,
        if (phoneController.value.text.isNotEmpty) "phoneNo": phoneController.value.text,
        if (phoneController.value.text.isNotEmpty) "countryCode": countryCode.value,
        if (selectedGrade.value?.isNotEmpty ?? false)"grade": selectedGrade.value,
      };
      _api.editProfile(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setUpdateProfileData(value);
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
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
        Utils.printLog("stackTrace===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void redirect() {
    mainController.getProfileApi();

    if(mainController.role.value=="PARENT"){
      mainController.selectedIndex.value = 2;
    }else{
      mainController.selectedIndex.value = 4;
    }
  }
}

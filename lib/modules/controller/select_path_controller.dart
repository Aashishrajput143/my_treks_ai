import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vroar/common/app_constants_list.dart';
import 'package:vroar/models/get_meta_data_model.dart';
import 'package:vroar/modules/repository/meta_data_repository.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';

class SelectPathController extends GetxController {
  final api = MetaDataRepository();

  //List<String> selectStrength = AppConstantsList.selectStrength;
  //List<String> careerStrength = AppConstantsList.careerStrength;
  //List<String> industryStrength = AppConstantsList.industryStrength;
  //List<String> skillStrength = AppConstantsList.skillStrength;

  RxList<String> selectedSelectStrength = <String>[].obs;
  RxList<String> selectedCareerStrength = <String>[].obs;
  RxList<String> selectedIndustryStrength = <String>[].obs;
  RxList<String> selectedSkillStrength = <String>[].obs;

  var careerSearchController = TextEditingController().obs;
  var careerSearchFocusNode = FocusNode().obs;
  var industrySearchController = TextEditingController().obs;
  var industrySearchFocusNode = FocusNode().obs;
  var strengthSearchController = TextEditingController().obs;
  var strengthSearchFocusNode = FocusNode().obs;
  var skillSearchController = TextEditingController().obs;
  var skillSearchFocusNode = FocusNode().obs;

  @override
  void onInit() {
    super.onInit();
    getMetaDataApi(1, 10, "CAREER");
    getMetaDataApi(1, 10, "INDUSTRY");
    getMetaDataApi(1, 10, "STRENGTHS");
    getMetaDataApi(1, 10, "SOFT SKILL");
  }

  var isCareerDropdownVisible = false.obs;
  var isIndustryDropdownVisible = false.obs;
  var isStrengthDropdownVisible = false.obs;
  var isSkillDropdownVisible = false.obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final getCareerMetaData = GetMetaDataModel().obs;
  final getIndustryMetaData = GetMetaDataModel().obs;
  final getStrengthMetaData = GetMetaDataModel().obs;
  final getSoftSkillMetaData = GetMetaDataModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setGetCareerMetaData(GetMetaDataModel value) => getCareerMetaData.value = value;
  void setGetIndustryMetaData(GetMetaDataModel value) => getIndustryMetaData.value = value;
  void setGetStrengthMetaData(GetMetaDataModel value) => getStrengthMetaData.value = value;
  void setGetSoftSkillMetaData(GetMetaDataModel value) => getSoftSkillMetaData.value = value;

  Future<void> getMetaDataApi(page, pageSize, type) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      api.getMetaDataApi(page, pageSize, type).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        switch (type){
          case "CAREER":
            setGetCareerMetaData(value);
            break;
          case "INDUSTRY":
              setGetIndustryMetaData(value);
              break;
          case "STRENGTHS":
            setGetStrengthMetaData(value);
            break;
          case "SOFT SKILL":
            setGetSoftSkillMetaData(value);
            break;
          default :
            setGetCareerMetaData(value);
        }
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
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
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/common/app_constants_list.dart';
import 'package:vroar/models/need_assistance_model.dart';
import 'package:vroar/modules/repository/profile_repository.dart';

import '../../common/common_methods.dart';
import '../../common/my_alert_dialog.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import 'common_screen_controller.dart';

class NeedAssistanceController extends GetxController {
  final api = ProfileRepository();

  var descriptionController = TextEditingController().obs;
  var descriptionFocusNode = FocusNode().obs;

  List<String> issueType = AppConstantsList.issueType;
  var selectedIssueType = Rxn<String>();
  var isValid = false.obs;

  final CommonScreenController mainController = Get.put(CommonScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAssistanceData = NeedAssistanceModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setInternshipListData(NeedAssistanceModel value) =>
      getAssistanceData.value = value;

  Future<void> needAssistanceApi(context,w) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "issueType": selectedIssueType.value,
        "issueDescription": descriptionController.value.text
      };
      api.needAssistance(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setInternshipListData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        redirect(context,w);
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

  redirect(context,w){
    selectedIssueType = Rxn<String>();
    descriptionController.value.text="";
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SuccessDialogBox(
          width: w,
          title: appStrings.requestSubmitted,
          buttonHint: appStrings.buttonGoBackHome,
          onChanged: () {
            Get.back();
            Get.back();
            mainController.selectedIndex.value=0;
          },
          message: appStrings.requestSubmittedDesc,
        );
      },
    );
  }
}

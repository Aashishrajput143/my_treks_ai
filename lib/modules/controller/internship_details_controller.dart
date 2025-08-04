import 'dart:convert';

import 'package:get/get.dart';
import 'package:vroar/models/saved_internship_model.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/get_internship_details_model.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/internship_repository.dart';

class InternshipDetailsController extends GetxController {
  final api = InternshipRepository();
  var internshipId ="0".obs;
  var express = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    internshipId.value = Get.arguments;
    print("internshipId${internshipId.value}");
    getInternshipDetailsApi();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getInternshipDetailData = GetInternshipDetailModel().obs;
  final savedInternshipData = SavedInternshipModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setInternshipDetailData(GetInternshipDetailModel value) =>
      getInternshipDetailData.value = value;
  void setSavedInternshipData(SavedInternshipModel value) =>
      savedInternshipData.value = value;

  Future<void> getInternshipDetailsApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      api.getInternshipDetailApi(internshipId.value).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setInternshipDetailData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        express.value=value.data?.isExpressInterest??false;
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

  Future<void> savedInternshipInterestApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "id": internshipId.value
      };
      api.savedInternshipApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setSavedInternshipData(value);
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        express.value=true;
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

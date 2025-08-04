import 'dart:convert';

import 'package:get/get.dart';
import 'package:vroar/models/get_mentor_details_model.dart';
import 'package:vroar/routes/routes_class.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/mentor_repository.dart';

class MentorDetailsController extends GetxController {
  final _api = MentorRepository();
  var mentorId = "0".obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final mentorData = GetMentorDetailsModel().obs;
  void setError(String value) => error.value = value;
  var error = RxnString();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setEventData(GetMentorDetailsModel value) => mentorData.value = value;

  @override
  void onInit() {
    super.onInit();
    mentorId.value = Get.arguments ?? "0";
    getMentorDetailsApi();
  }

  Future<void> getMentorDetailsApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      _api.getMentorDetails(mentorId.value).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setEventData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> $value");
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

  onClickReqSession() async {
    // const url = "https://calendar.app.google/cyH9wUH6HyJzAUdM8";
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    // } else {
    //   throw 'Could not launch $url';
    // }
    Get.toNamed(RoutesClass.bookSession, arguments: mentorId.value);
  }
}

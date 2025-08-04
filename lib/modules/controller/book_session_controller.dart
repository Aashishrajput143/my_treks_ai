import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/routes/routes_class.dart';
import '../../models/session_book_model.dart';
import '../../common/app_constants_list.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/mentor_repository.dart';
import 'common_screen_controller.dart';

class BookSessionController extends GetxController {
  final _api = MentorRepository();
  var mentorId = "0".obs;
  var agendaDescriptionController = TextEditingController().obs;
  var agendaDescriptionFocusNode = FocusNode().obs;
  var careerDescriptionController = TextEditingController().obs;
  var careerDescriptionFocusNode = FocusNode().obs;
  var isAgenda = false.obs;

  List<String> selectTime = AppConstantsList.sessionTime;
  var selectedSessionType = Rxn<String>();

  final rxRequestStatus = Status.COMPLETED.obs;
  final mentorData = BookSessionModel().obs;
  void setError(String value) => error.value = value;
  var error = RxnString();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBookSessionResponse(BookSessionModel value) => mentorData.value = value;

  final CommonScreenController mainController = Get.put(CommonScreenController());

  @override
  void onInit() {
    super.onInit();
    mentorId.value = Get.arguments ?? "0";
  }

  Future<void>bookMentorSessionApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "sessionDetails": agendaDescriptionController.value.text,
        'mentorId': int.parse(mentorId.value),
      };

      _api.bookSessionApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setBookSessionResponse(value);
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        Get.offAllNamed(RoutesClass.commonScreen);
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
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

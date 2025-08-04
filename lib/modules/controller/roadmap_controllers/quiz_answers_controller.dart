import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/quiz_result_model.dart';
import '../../../common/common_methods.dart';
import '../../../data/response/status.dart';
import '../../../resources/strings.dart';
import '../../../utils/utils.dart';
import '../../repository/roadmap_repository.dart';

class QuizAnswersController extends GetxController {
  var currentIndex = 0.obs;
  final api = RoadmapRepository();
  var quizId = "".obs;
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    quizId.value = Get.arguments;
    getQuizResultApi();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final quizResultData = QuizResultModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setQuizResultData(QuizResultModel value) => quizResultData.value = value;

  Future<void> getQuizResultApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        //id?: number,
        "quizId": quizId.value
      };

      api.getRoadmapQuizResultApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setQuizResultData(value);
        //CommonMethods.showToastSuccess("${value.message}");
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

  void forwardPage() {
    if (currentIndex.value < (quizResultData.value.data?.quizResult?.length ?? 2) - 1) {
      scrollController.jumpTo(0.0);
      currentIndex.value = currentIndex.value + 1;
      print(currentIndex.value);
    }
  }

  void backPage() {
    scrollController.jumpTo(0.0);
    currentIndex.value = currentIndex.value - 1;
    print(currentIndex.value);
  }
}

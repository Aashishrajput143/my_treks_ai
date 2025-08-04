import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';

import '../../../models/quiz_result_model.dart';
import '../../../common/common_methods.dart';
import '../../../data/response/status.dart';
import '../../../resources/strings.dart';
import '../../../utils/utils.dart';
import '../../repository/roadmap_repository.dart';

class QuizCompletedController extends GetxController {
  var currentIndex = 0.obs;
  final api = RoadmapRepository();
  var quizId = "".obs;
  var totalQuestion = 0.obs;
  var correctAnswer = 0.obs;
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
        getData();
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

  void getData() {
    final List<QuizResult>? quizResult = quizResultData.value.data?.quizResult;

    totalQuestion.value = quizResult?.length ?? 0;
    int correctAnswers = 0;

    for (var question in quizResult!) {
      List<SelectedOptions>? selectedOptions = question.selectedOptions;
      for (var option in selectedOptions!) {
        if (option.isSelected == true && option.isCorrect == true) {
          correctAnswers++;
          break;
        }
      }
    }

    correctAnswer.value = correctAnswers;

    print("Total Questions: ${totalQuestion.value}");
    print("Total Correct Answers: ${correctAnswer.value}");
  }
}

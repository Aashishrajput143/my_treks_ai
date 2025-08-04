import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:vroar/models/get_quiz_model.dart';
import 'package:vroar/models/submit_quiz_model.dart';
import 'package:vroar/routes/routes_class.dart';

import '../../../common/common_methods.dart';
import '../../../data/response/status.dart';
import '../../../resources/strings.dart';
import '../../../utils/utils.dart';
import '../../repository/roadmap_repository.dart';
import 'roadmap_controller.dart';

class QuizController extends GetxController {
  dynamic arguments = Get.arguments;
  final api = RoadmapRepository();
  var currentIndex = 0.obs;
  var quizId = "".obs;
  var journeyId = "".obs;
  var isButtonDisabled = false.obs;
  final ScrollController scrollController = ScrollController();

  RxList<TextEditingController> controllers = <TextEditingController>[].obs;
  RxList<FocusNode> focusNodes = <FocusNode>[].obs;
  RxList<Map<String, dynamic>> selectedAnswers = <Map<String, dynamic>>[].obs;
  //RxList<RxList<bool>> selectedLists = <RxList<bool>>[].obs;

  final RxList<Rx<String>> selectedValues = <Rx<String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getQuizApi();
    quizId.value = arguments[0]["quizId"];
    journeyId.value = arguments[1]["journeyId"];
    selectedAnswers.assignAll(List.generate(
      2,
      (index) => {
        "questionId": (index + 1).toString(),
        "answerText": "",
        "selectedOptionIds": <int>[].obs,
      },
    ));
    controllers = List.generate(2, (_) => TextEditingController()).obs;
    focusNodes = List.generate(2, (_) => FocusNode()).obs;
  }

  bool isValidResponse(List<Map<String, dynamic>> responses) {
    for (var response in responses) {
      bool hasSelectedOptions = response.containsKey('selectedOptionIds') && response['selectedOptionIds'] is List && response['selectedOptionIds'].isNotEmpty;

      // Check if 'answerText' is a non-empty string
      bool hasAnswerText = response.containsKey('answerText') && response['answerText'] is String && response['answerText'].trim().isNotEmpty;

      // If both are empty, the response is invalid
      if (!hasSelectedOptions && !hasAnswerText) {
        return false;
      }
    }
    return true;
  }

  bool isResponseValidAtIndex(List<Map<String, dynamic>> responses, int index) {
    if (index < 0 || index >= responses.length) {
      return false;
    }

    final item = responses[index];

    final hasAnswerText = item.containsKey('answerText') && item['answerText'] != null && item['answerText'].toString().trim().isNotEmpty;
    final hasSelectedOptions = item.containsKey('selectedOptionIds') && item['selectedOptionIds'] != null && item['selectedOptionIds'].isNotEmpty;

    return hasAnswerText || hasSelectedOptions;
  }

  void submit() {
    if (getQuizData.value.data?.quizQuestions?[currentIndex.value].questionType == "Subjective") {
      selectedAnswers[currentIndex.value]["answerText"] = controllers[currentIndex.value].value.text;
    }
    if (isValidResponse(selectedAnswers)) {
      currentIndex.value = 0;
      submitQuizApi();
    } else {
      CommonMethods.showToast("Please Answer the Question!");
      //int index=getFirstEmptyResponseIndex(selectedAnswers);
      //currentIndex.value=index;
    }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getQuizData = GetQuizModel().obs;
  final submitQuizData = SubmitQuizModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setQuizData(GetQuizModel value) => getQuizData.value = value;
  void setSubmitQuizData(SubmitQuizModel value) => submitQuizData.value = value;

  Future<void> getQuizApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      api.getQuizApi(quizId.value).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setQuizData(value);
        // CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        setData();
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

  void setData() {
    // selectedLists.addAll(
    //   List.generate(
    //     getQuizData.value.data?.quizQuestions?.length ?? 1,
    //         (page) => List.generate(getQuizData.value.data?.quizQuestions?[page].options?.length ?? 4, (index) => false).obs,
    //   ),
    // );
    selectedValues.addAll(List.generate(getQuizData.value.data?.quizQuestions?.length ?? 2, (_) => "".obs));
    selectedAnswers.assignAll(List.generate(
      getQuizData.value.data?.quizQuestions?.length ?? 2,
      (index) => {
        "questionId": getQuizData.value.data?.quizQuestions?[index].id,
        if (getQuizData.value.data?.quizQuestions?[index].questionType == "Objective") "selectedOptionIds": <int>[].obs,
        if (getQuizData.value.data?.quizQuestions?[index].questionType == "Subjective") "answerText": "",
      },
    ));
    controllers = List.generate(getQuizData.value.data?.quizQuestions?.length ?? 1, (_) => TextEditingController()).obs;
    focusNodes = List.generate(getQuizData.value.data?.quizQuestions?.length ?? 1, (_) => FocusNode()).obs;
  }

  void addOption(index) {
    // int optionId = int.parse(getQuizData.value.data?.quizQuestions?[currentIndex.value].options?[index].id ?? "0");
    // RxList<int> selectedOptions = selectedAnswers[currentIndex.value]["selectedOptionIds"];
    // if (!selectedOptions.contains(optionId)) {
    //   selectedOptions.add(optionId);
    //   print(selectedOptions);
    // } else {
    //   selectedOptions.remove(optionId);
    //   print(selectedOptions);
    // }
    // selectedLists[currentIndex.value][index] = !selectedLists[currentIndex.value][index];
    // selectedAnswers[currentIndex.value]["questionId"] = int.parse(getQuizData.value.data?.quizQuestions?[currentIndex.value].id ?? "0");
    // selectedAnswers.refresh();
    // print(selectedLists);
    // print("length======> ${selectedLists.length}");

    // selectedAnswers[currentIndex.value]["selectedOptionIds"][0] = int.parse(getQuizData.value.data?.quizQuestions?[currentIndex.value].options?[index].id ?? "0");
    // selectedValues[currentIndex.value].value = getQuizData.value.data?.quizQuestions?[currentIndex.value].options?[index].optionText ?? "";
    // print(selectedValues[currentIndex.value]);
    // print(selectedAnswers);

    if (getQuizData.value.data?.quizQuestions?[currentIndex.value].questionType == "Objective") {
      // Clear previous selections to ensure only one option is selected
      selectedAnswers[currentIndex.value]["selectedOptionIds"] = <int>[].obs;

      // Set the new selected option
      selectedAnswers[currentIndex.value]["selectedOptionIds"].add(int.parse(getQuizData.value.data?.quizQuestions?[currentIndex.value].options?[index].id ?? "0"));

      // Store the option text (useful for UI)
      selectedValues[currentIndex.value].value = getQuizData.value.data?.quizQuestions?[currentIndex.value].options?[index].optionText ?? "";

      print("Selected Value: ${selectedValues[currentIndex.value]}");
      print("Selected Answers: $selectedAnswers");
    }
  }

  Future<void> submitQuizApi() async {
    RoadmapController roadmapController = Get.put(RoadmapController());
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"answers": selectedAnswers, "quizId": quizId.value, "journeyId": journeyId.value};

      api.submitQuizApi(data).then((value) async {
        setSubmitQuizData(value);
        // CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        await roadmapController.markLevelCompleted(roadmapController.currIndex.value, roadmapController.currStepId.value, roadmapController.currRoadmapId.value);
        setRxRequestStatus(Status.COMPLETED);
        Get.offNamed(RoutesClass.quizCompleted, arguments: quizId.value);
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
    if (currentIndex.value < (getQuizData.value.data?.quizQuestions?.length ?? 1) - 1) {
      if (getQuizData.value.data?.quizQuestions?[currentIndex.value].questionType == "Subjective") {
        selectedAnswers[currentIndex.value]["answerText"] = controllers[currentIndex.value].value.text;
      }
      print(isResponseValidAtIndex(selectedAnswers, currentIndex.value));
      if (isResponseValidAtIndex(selectedAnswers, currentIndex.value)) {
        scrollController.jumpTo(0.0);
        currentIndex.value = currentIndex.value + 1;
      } else {
        if (isButtonDisabled.value) {
        } else {
          isButtonDisabled.value = true;
          CommonMethods.showToast("Please Select the Option!");
          Future.delayed(const Duration(seconds: 5), () {
            isButtonDisabled.value = false;
          });
        }
      }
      print(currentIndex.value);
      //print(selectedValues);
      print(selectedAnswers);
    } else {
      if (getQuizData.value.data?.quizQuestions?[currentIndex.value].questionType == "Subjective") {
        selectedAnswers[currentIndex.value]["answerText"] = controllers[currentIndex.value].value.text;
      }
      print(selectedAnswers);
      submit();
    }
  }

  void backPage() {
    if (getQuizData.value.data?.quizQuestions?[currentIndex.value].questionType == "Subjective") {
      selectedAnswers[currentIndex.value]["answerText"] = controllers[currentIndex.value].value.text;
    }
    scrollController.jumpTo(0.0);
    currentIndex.value = currentIndex.value - 1;
    print(currentIndex.value);
  }
}

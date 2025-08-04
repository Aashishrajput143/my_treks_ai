import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vroar/models/answer_submission_model.dart';
import 'package:vroar/models/get-assessment_model.dart';

import '../../../common/common_methods.dart';
import '../../../common/roadmap_common_widgets/roadmap_task_done_screen.dart';
import '../../../data/response/status.dart';
import '../../../resources/images.dart';
import '../../../resources/strings.dart';
import '../../../routes/routes_class.dart';
import '../../../utils/utils.dart';
import '../../repository/roadmap_repository.dart';
import 'onboarding_roadmap_controller.dart';

class QuestionAnswerController extends GetxController {
  var currentIndex = 0.obs;
  var id = "0".obs;
  var currentIndexOptions = 0.obs;
  dynamic arguments = Get.arguments;
  var isButtonDisabled = false.obs;
  final api = RoadmapRepository();
  var multipleSelected = false.obs;

  RxList<TextEditingController> controllers = <TextEditingController>[].obs;
  RxList<FocusNode> focusNodes = <FocusNode>[].obs;
  RxList<Map<String, dynamic>> selectedAnswers = <Map<String, dynamic>>[].obs;
  RxList<RxList<bool>> selectedLists = <RxList<bool>>[].obs;
  final RxList<Rx<String>> selectedValues = <Rx<String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    id.value = (arguments[1]['assessmentId']) ?? "0";
    String selected = (arguments[3]['assessmentType']) ?? "ASSESSMENT";
    multipleSelected.value = selected == "ASSESSMENT" ? false : false;
    print(id.value);
    getAssessmentApi();
    selectedAnswers.assignAll(
      List.generate(
        2,
        (index) => {
          "questionId": index + 1,
          "answerText": "",
          "selectedOptionIds": <int>[].obs,
        },
      ),
    );
    controllers = List.generate(2, (_) => TextEditingController()).obs;
    focusNodes = List.generate(2, (_) => FocusNode()).obs;
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAssessmentData = GetAssessmentModel().obs;
  final submitAssessmentData = AnswerSubmissionModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAssessmentData(GetAssessmentModel value) => getAssessmentData.value = value;
  void setSubmitAssessmentData(AnswerSubmissionModel value) => submitAssessmentData.value = value;

  Future<void> getAssessmentApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      api.onBoardingAssessmentApi(id.value).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setAssessmentData(value);
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

    var response = responses[index];

    bool hasSelectedOptions = response.containsKey('selectedOptionIds') && response['selectedOptionIds'] is List && response['selectedOptionIds'].isNotEmpty;

    bool hasAnswerText = response.containsKey('answerText') && response['answerText'] is String && response['answerText'].trim().isNotEmpty;

    return hasSelectedOptions || hasAnswerText;
  }

  int getFirstEmptyResponseIndex(List<Map<String, dynamic>> responses) {
    for (int i = 0; i < responses.length; i++) {
      var response = responses[i];

      bool hasSelectedOptions = response.containsKey('selectedOptionIds') && response['selectedOptionIds'] is List && response['selectedOptionIds'].isNotEmpty;

      bool hasAnswerText = response.containsKey('answerText') && response['answerText'] is String && response['answerText'].trim().isNotEmpty;

      if (!hasSelectedOptions && !hasAnswerText) {
        return i;
      }
    }

    return -1;
  }

  void submit() {
    if (getAssessmentData.value.data?.questions?[currentIndex.value].questionType == "Subjective") {
      selectedAnswers[currentIndex.value]["answerText"] = controllers[currentIndex.value].value.text;
    }
    if (isValidResponse(selectedAnswers)) {
      submitAnswerApi();
    } else {
      if (isButtonDisabled.value) {
      } else {
        isButtonDisabled.value = true;
        CommonMethods.showToast("Please Answer all the Questions!");
        Future.delayed(const Duration(seconds: 5), () {
          isButtonDisabled.value = false;
        });
      }
    }
  }

  Future<void> submitAnswerApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"assessmentId": id.value, "answers": selectedAnswers};

      await api.onBoardingAnswerSubmissionApi(data).then((value) async {
        setRxRequestStatus(Status.COMPLETED);
        setSubmitAssessmentData(value);
        // CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        if (value.statusCode == 200) {
          OnBoardingRoadmapController onBoardingRoadmapController = Get.put<OnBoardingRoadmapController>(OnBoardingRoadmapController());
          Get.off(() => RoadmapTaskDoneScreen(
                image: appImages.successIconFull,
                showButton: true,
                titleText: appStrings.assessmentCompleted,
                subText: appStrings.congratulationText,
                //buttonHint: appStrings.retakeAssessment,
                button2Hint: appStrings.continueToNextLvlButton,
                onComplete: () {
                  Get.toNamed(RoutesClass.questionAnswer, arguments: arguments);
                },
                navigate: () async {
                  onBoardingRoadmapController.setRxRequestStatus(Status.LOADING);
                  await onBoardingRoadmapController.markLevelCompletedOnly(arguments[2]['currentLevel']);
                  Get.back();
                },
              ));
        }
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
    selectedValues.addAll(List.generate(getAssessmentData.value.data?.questions?.length ?? 2, (_) => "".obs));
    selectedLists.addAll(
      List.generate(
        getAssessmentData.value.data?.questions?.length ?? 1,
        (page) => List.generate(getAssessmentData.value.data?.questions?[page].options?.length ?? 4, (index) => false).obs,
      ),
    );
    selectedAnswers.assignAll(
      List.generate(
        getAssessmentData.value.data?.questions?.length ?? 1,
        (index) => {
          "questionId": getAssessmentData.value.data?.questions?[index].id,
          if (getAssessmentData.value.data?.questions?[index].questionType == "Objective") "selectedOptionIds": <int>[].obs,
          if (getAssessmentData.value.data?.questions?[index].questionType == "Subjective") "answerText": "",
        },
      ),
    );
    controllers = List.generate(getAssessmentData.value.data?.questions?.length ?? 1, (_) => TextEditingController()).obs;
    focusNodes = List.generate(getAssessmentData.value.data?.questions?.length ?? 1, (_) => FocusNode()).obs;
  }

  void addOption(int index) {
    int optionId = int.parse(getAssessmentData.value.data?.questions?[currentIndex.value].options?[index].id ?? "0");

    // Access the map entry directly
    Map<String, dynamic> currentAnswer = selectedAnswers[currentIndex.value];

    if (!multipleSelected.value) {
      // Single select: clear old and add one new
      currentAnswer["selectedOptionIds"] = <int>[optionId].obs;

      selectedValues[currentIndex.value].value = getAssessmentData.value.data?.questions?[currentIndex.value].options?[index].optionText ?? "";

      selectedLists[currentIndex.value] = <bool>[].obs;
      selectedLists[currentIndex.value].addAll(
        List.generate(
          getAssessmentData.value.data?.questions?[currentIndex.value].options?.length ?? 2,
          (_) => false,
        ),
      );
    } else {
      // Multi-select logic
      RxList<int> selectedOptions = currentAnswer["selectedOptionIds"];
      if (!selectedOptions.contains(optionId)) {
        selectedOptions.add(optionId);
      } else {
        selectedOptions.remove(optionId);
      }
    }

    // Toggle selection state for UI
    selectedLists[currentIndex.value][index] = !selectedLists[currentIndex.value][index];

    // Trigger reactive updates
    selectedAnswers.refresh();

    print("Selected Value: ${selectedValues[currentIndex.value]}");
    print("Selected Answers: $selectedAnswers");
    print(selectedLists);
  }

  void forwardPage() {
    if (currentIndex.value < (getAssessmentData.value.data?.questions?.length ?? 1) - 1) {
      if (getAssessmentData.value.data?.questions?[currentIndex.value].questionType == "Subjective") {
        selectedAnswers[currentIndex.value]["answerText"] = controllers[currentIndex.value].value.text;
      }
      if (isResponseValidAtIndex(selectedAnswers, currentIndex.value)) {
        currentIndex.value = currentIndex.value + 1;
      } else {
        if (isButtonDisabled.value) {
        } else {
          isButtonDisabled.value = true;
          CommonMethods.showToast("Please Answer the Question!");
          Future.delayed(const Duration(seconds: 5), () {
            isButtonDisabled.value = false;
          });
        }
      }
      print(currentIndex.value);
      //print(selectedValues);
      print(selectedAnswers);
    }
  }

  void backPage() {
    if (getAssessmentData.value.data?.questions?[currentIndex.value].questionType == "Subjective") {
      selectedAnswers[currentIndex.value]["answerText"] = controllers[currentIndex.value].value.text;
    }
    currentIndex.value = currentIndex.value - 1;
    print(currentIndex.value);
  }
}

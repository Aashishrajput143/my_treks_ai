import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/common_methods.dart';
import '../../../data/response/status.dart';
import '../../../modules/controller/roadmap_controllers/onboarding_roadmap_controller.dart';
import '../../../common/app_constants_list.dart';
import '../../../resources/strings.dart';
import '../../../utils/utils.dart';

class TopStrengthController extends GetxController {
  OnBoardingRoadmapController roadmapController = Get.put(OnBoardingRoadmapController());
  OnBoardingRoadmapController onBoardingRoadmapController = Get.put<OnBoardingRoadmapController>(OnBoardingRoadmapController());
  var topStrength = <String>[].obs;
  var selectedStrength1 = Rxn<String>();
  var selectedStrength2 = Rxn<String>();
  var selectedStrength3 = Rxn<String>();
  var selectedStrength4 = Rxn<String>();
  var selectedStrength5 = Rxn<String>();

  RxList<String> top5Strengths = [''].obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  @override
  void onInit() {
    super.onInit();
    topStrength.assignAll(AppConstantsList.topStrength);
  }

  void setRxRequestStatus(Status value) {
    rxRequestStatus.value = value;
    update();
  }

  void updateStrength(Rxn<String> selectedStrength, String? newValue) {
    if (selectedStrength.value != null) {
      topStrength.add(selectedStrength.value!);
      top5Strengths.remove(selectedStrength.value);
    }
    selectedStrength.value = newValue;
    if (newValue != null) {
      topStrength.remove(newValue);
      top5Strengths.add(newValue);
      top5Strengths[0].isEmpty ? top5Strengths.removeAt(0) : null;
    }
    Utils.printLog(topStrength);
    Utils.printLog(top5Strengths);
    topStrength.sort();
  }

  void launchCalenderUrl() async {
    const url = "https://calendar.google.com/calendar/u/0/appointments/AcZssZ0poNDELxFZrwvITfcipgTl2KCPKJkIwxnoyRY=";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  onClickComplete() async {
    setRxRequestStatus(Status.LOADING);
    if (top5Strengths[0].isEmpty) {
      CommonMethods.showToast(appStrings.emptyStrengthAlert);
      setRxRequestStatus(Status.COMPLETED);
      return;
    } else {
      await onBoardingRoadmapController.markLevelCompleted(onBoardingRoadmapController.currIndex.value, onBoardingRoadmapController.currStepId.value, topStregth: top5Strengths, gallupResultUrl: roadmapController.uploadResultFile.value.data?.filePath);
      if (onBoardingRoadmapController.statusCode.value == 200) {
        setRxRequestStatus(Status.COMPLETED);
        launchCalenderUrl();
        Get.back();
        // Get.off(() => RoadmapTaskDoneScreen(
        //     image: appImages.sandClockLoading,
        //     titleText: appStrings.pleaseWaitForAssistance,
        //     subText: appStrings.assistanceSubtext,
        //     button2Hint: appStrings.backToRoadmapButton,
        //     isLottie: true,
        //     navigate: () => Get.back()));
      }
    }
  }
}

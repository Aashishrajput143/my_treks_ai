

import 'package:get/get.dart';
import 'package:vroar/modules/controller/onboarding_controller.dart';

class OnboardingBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => OnBoardingController());
  }

}

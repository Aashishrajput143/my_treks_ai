import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vroar/resources/images.dart';
import 'package:vroar/resources/strings.dart';

import '../../common/constants.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';

class OnBoardingController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);

  var currentIndex = 0.obs;

  final RxList<dynamic> images = [
    appImages.firstOnBoardingImage,
    appImages.secondOnBoardingImage,
    appImages.thirdOnBoardingImage,
    appImages.fourthOnBoardingImage,
  ].obs;

  final RxList<String> titles = [
    appStrings.welcomeTo,
    appStrings.personalized,
    appStrings.interactive,
    appStrings.track,
  ].obs;

  final RxList<String> subtitles = [
    appStrings.connectLearn,
    appStrings.tailoredLearning,
    appStrings.supportGuidance,
    appStrings.joinUs,
  ].obs;

  final RxList<Tween<Offset>> offsetList = [
    Tween<Offset>(begin: const Offset(0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(0, 0.1), end: const Offset(0, 0.0)),
  ].obs;

  final RxList<Tween<Offset>> offsetListForImage = [
    Tween<Offset>(begin: const Offset(0.1, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0, 0.0)),
    Tween<Offset>(begin: const Offset(-0.00, 0.08), end: const Offset(0.0, -0.0098)),
  ].obs;

  @override
  void onInit() {
    // const duration = Duration(milliseconds: 300);
    // animationController = AnimationController(duration: duration, vsync: this)..forward();
    super.onInit();
  }

  void updateIndex(int newIndex) {
    if (newIndex < 4) {
      currentIndex.value = newIndex;
    } else {
      Utils.savePreferenceValues(Constants.isOnBoarding, "No");
      Get.offAndToNamed(RoutesClass.login);
    }
    Utils.printLog("Current Index: $currentIndex");
  }
}

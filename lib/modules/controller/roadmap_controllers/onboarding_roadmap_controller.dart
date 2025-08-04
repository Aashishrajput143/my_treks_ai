// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vroar/models/verify_subscription_model.dart';
import 'package:vroar/modules/screen/roadmap/onboarding_roadmap_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../common/common_widgets.dart';
import '../../../common/roadmap_common_widgets/roadmap_task_done_screen.dart';
import '../../../common/roadmap_common_widgets/youtube_video_player.dart';
import '../../../common/constants.dart';
import '../../../models/oboarding_roadmap_models.dart';
import '../../../models/upload_media_model.dart';
import '../../../resources/images.dart';
import '../../../routes/routes_class.dart';
import '../../../utils/roadmap_enums.dart';
import '../../../utils/utils.dart';
import '../../../common/common_methods.dart';
import '../../../data/response/status.dart';
import '../../../resources/strings.dart';
import '../../repository/roadmap_repository.dart';
import '../../repository/signup_repository.dart';
import '../../../common/shared_preference.dart';
// import '../../data/response/status.dart';

class OnBoardingRoadmapController extends GetxController with GetTickerProviderStateMixin {
  TransformationController transformationController = TransformationController();
  // CommonScreenController commonScreenController = Get.put(CommonScreenController());
  late AnimationController animationController;
  double minY = Platform.isAndroid
      ? -Get.height * 2.3
      : Get.height <= 667
          ? -Get.height * 3.2
          : -Get.height * 2.3; // Set the limit for downward movement
  RxInt lastUnlockedLevel = 0.obs;
  double imageHeight = 3840;
  double imageWidth = 2048;
  RxBool isLevelCompleted = false.obs;
  RxBool isOnBoardingRoadMap = false.obs;
  RxBool showUploadBtn = true.obs;
  RxBool showContinueBtn = false.obs;
  RxBool showInHouseVideo = false.obs;
  RxString inHouseVideoUrl = ''.obs;
  var inValidCouponCode = Rxn<String>();
  RxInt currIndex = 0.obs;
  RxInt currStepId = 0.obs;
  final int onBoardingLevelsRoadMap = 8;
  List<Offset> levelPositions = []; // Holds level positions for scrolling
  RxBool isImageLoaded = false.obs;
  late Image backgroundImage;
  var picker = FilePickerIO().obs;
  var selectedFile = Rxn<String>();
  var selectedFileSize = Rxn<String>();
  var selectedFilePath = Rxn<String>();
  RxString userName = ''.obs;
  RxInt statusCode = 0.obs;
  RxString userImage = ''.obs;

  var couponController = TextEditingController().obs;
  var couponFocusNode = FocusNode().obs;
  var couponCode = "".obs;
  var isLoading = false.obs;

  var selectedImage = Rxn<String>();
  final api = SignupRepository();
  final roadmapRepository = RoadmapRepository();
  final uploadResultFile = UploadMediaModel().obs;
  final verifySubscription = VerifySubscriptionModel().obs;
  void setUploadResultFile(UploadMediaModel value) => uploadResultFile.value = value;
  void setVerifySubscription(VerifySubscriptionModel value) => verifySubscription.value = value;

  final StreamController<OnBoardingRoadmapJourneyModel> _roadmapStreamController = StreamController.broadcast();

  // Expose the stream
  Stream<OnBoardingRoadmapJourneyModel> get roadmapStream => _roadmapStreamController.stream;

  final getOnBoardingRoadmapData = OnBoardingRoadmapJourneyModel().obs;
  final getOnBoardingRoadmapUpdateResponse = OnBoardingRoadmapJourneyUpdateModel().obs;
  final onBoardRoadMapApi = RoadmapRepository();

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status value) {
    rxRequestStatus.value = value;
    update();
  }

  void setOnBoardingRoadmapData(OnBoardingRoadmapJourneyModel value) {
    getOnBoardingRoadmapData.value = value;
    _roadmapStreamController.add(value);
    setRxRequestStatus(Status.COMPLETED);
  }

  void setOnBoardingRoadmapUpdateResponse(OnBoardingRoadmapJourneyUpdateModel value) {
    getOnBoardingRoadmapUpdateResponse.value = value;
    // _roadmapStreamController.add(value);
    setRxRequestStatus(Status.COMPLETED);
  }

  @override
  void onInit() {
    super.onInit();
    preloadImage();
    // loadLastUnlockedLevel();
    initializeLevelPositions();
    transformationController.addListener(_checkBounds);
    // Initialize AnimationController at class level
    animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // getOnBoardingRoadmapApi();
  }

  @override
  void onClose() {
    transformationController.removeListener(_checkBounds);
    transformationController.dispose();
    _roadmapStreamController.close();
    animationController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToLastUnlockedLevel(false, 0);
    });
  }

  void _checkBounds() {
    Matrix4 matrix = transformationController.value;
    double y = matrix.getTranslation().y;

    // Restrict downward movement if level >= 7
    if ((levelPositions.length >= 7 && y > minY) || lastUnlockedLevel.value >= 7 && y > minY) {
      transformationController.value = Matrix4.translationValues(
        matrix.getTranslation().x,
        GetPlatform.isAndroid ? (minY + 55) : minY,
        0,
      )..multiply(Matrix4.diagonal3Values(
          matrix.getMaxScaleOnAxis(),
          matrix.getMaxScaleOnAxis(),
          1,
        ));
    }
  }

  void preloadImage() async {
    backgroundImage = Image.asset('assets/images/roadmap_demo.png');

    // Ensure image is fully loaded before updating UI
    await precacheImage(backgroundImage.image, Get.context!);

    isImageLoaded.value = true;
    backgroundImage.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((_, __) {
        isImageLoaded.value = true; // Notify UI when image is ready
      }),
    );
    update();
  }

  void onInteractionEnd() {
    transformationController.toScene(Offset.zero);
    update();
  }

  void onChangeCurrentScreen(int index) {
    // commonScreenController.selectedIndex.value = index;
    update();
  }

  onClickUploadButton() {
    pickFileFromPhone().then((val) => {
          if (val.value != '')
            {
              showUploadBtn.value = false,
              showContinueBtn.value = true,
              update(),
            }
        });
  }

  revertBack() {
    showUploadBtn.value = true;
    showContinueBtn.value = false;
    selectedFile.value = "";
    selectedFileSize.value = "";
    selectedFilePath.value = "";
    update();
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  Future pickFileFromPhone() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      print(result.files.first.path.toString());
      XFile file = XFile(result.files.first.path!);
      selectedFile.value = result.files.first.name;
      selectedFilePath.value = result.files.first.path;
      var fileSize = getFileSizeString(bytes: result.files.first.size);
      selectedFileSize.value = fileSize.toString();
      print(fileSize);
    }
    print(result);
    return selectedFile;
  }

  Future<bool> levelTagColor(index) async => await AppPreferences.isOnBoardingLevelCompleted(index);

  Future<void> markLevelCompleted(int level, int stepId, {List<String>? topStregth, gallupResultUrl}) async {
    if (!await CommonMethods.checkInternetConnectivity()) {
      CommonMethods.showToast(appStrings.weUnableCheckData);
      return;
    }

    try {
      // setRxRequestStatus(Status.LOADING);
      await AppPreferences.saveOnBoardingLevelCompleted(level);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      OnBoardingRoadmapJourneyUpdatePostModel data =
          OnBoardingRoadmapJourneyUpdatePostModel(id: int.parse(getOnBoardingRoadmapData.value.data!.id!), levelCompleted: getOnBoardingRoadmapData.value.data!.levelCompleted! + 1, completedStepId: stepId, topStrengths: topStregth, gallupResult: gallupResultUrl);
      await onBoardRoadMapApi.onBoardingRoadmapLevelUpdate(data.toJson()).then((value) async {
        setOnBoardingRoadmapUpdateResponse(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        statusCode.value = getOnBoardingRoadmapUpdateResponse.value.statusCode ?? 0;
        if (getOnBoardingRoadmapUpdateResponse.value.statusCode == 200) {
          await prefs.setInt(Constants.onBoardingLastUnlockedLevel, level + 1); // Ensure next level unlocks

          lastUnlockedLevel.value = level + 1; // Ensure reactive state updates
          update();
          await getOnBoardingRoadmapApi();
          // loadLastUnlockedLevel();
          setRxRequestStatus(Status.COMPLETED);
        }
      });
    } catch (e) {
      handleApiError(e);
      Utils.printLog(e);
    }
  }

  Future<void> markLevelCompletedOnly(int level) async {
    await AppPreferences.saveOnBoardingLevelCompleted(level);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(Constants.onBoardingLastUnlockedLevel, level + 1); // Ensure next level unlocks

    lastUnlockedLevel.value = level + 1; // Ensure reactive state updates
    update();
    await getOnBoardingRoadmapApi();
    loadLastUnlockedLevel();
  }

  Future<void> loadLastUnlockedLevel() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // lastUnlockedLevel.value = prefs.getInt('lastUnlockedLevel') ?? 0;

    Utils.getIntPreferenceValues(Constants.onBoardingLastUnlockedLevel).then((val) => {
          // Scroll to last unlocked level after loading (Ensure UI updates)
          lastUnlockedLevel.value = val ?? 0,
          Future.delayed(const Duration(milliseconds: 300), () {
            scrollToLastUnlockedLevel(false, 0);
          }),
        });
  }

  Future<void> scrollToLastUnlockedLevel(bool callCompletedLevel, int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastLevel = callCompletedLevel ? level : prefs.getInt(Constants.onBoardingLastUnlockedLevel) ?? 0;

    if (levelPositions.isEmpty) return; // Ensure positions exist

    int safeLevelIndex = lastLevel.clamp(0, levelPositions.length - 1);
    Offset targetOffset = levelPositions[safeLevelIndex];

    // Get current transformation matrix
    Matrix4 currentMatrix = transformationController.value.clone();

    // Extract current translation (x, y)
    double currentX = currentMatrix.storage[12];
    double currentY = currentMatrix.storage[13];

    // Ensure target translation stays within screen bounds
    double moveX = (-targetOffset.dx + Get.width / 2).clamp(-imageWidth + Get.width, 0);
    double moveY = (-targetOffset.dy + Get.height / 3).clamp(-imageHeight + Get.height, 0);

    // Handle levels beyond 16 (avoid white screen)
    if (lastLevel <= 1) {
      moveX = (-targetOffset.dx + Get.width / 1.4).clamp(-imageWidth + Get.width / 2, imageWidth);
      moveY = (-targetOffset.dy + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 150)) / 1.2).clamp(-imageHeight + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)), imageHeight);
    } else if (lastLevel <= 0 && Get.height <= 667) {
      moveX = (-targetOffset.dx + Get.width / 1.4).clamp(-imageWidth + Get.width / 2.4, imageWidth);
      moveY = (-targetOffset.dy + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 150)) / 1.2).clamp(-imageHeight + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)), imageHeight);
    } else if (lastLevel >= 8) {
      moveX = (-targetOffset.dx + Get.width / 4).clamp(-imageWidth + Get.width, 0);
      moveY = (-targetOffset.dy + Get.height / 4).clamp(-imageHeight + Get.height, 0);
    } else if (lastLevel == 4) {
      moveX = (-targetOffset.dx + Get.width / 1.4).clamp(-imageWidth + Get.width / 2.4, imageWidth);
      moveY = (-targetOffset.dy + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)) / 1.8).clamp(-imageHeight + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)), imageHeight);
    } else if (lastLevel <= 5) {
      moveX = (-targetOffset.dx + Get.width / 4.8).clamp(-imageWidth + Get.width / 2.3, imageWidth);
      moveY = (-targetOffset.dy + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)) / 2.8).clamp(-imageHeight + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)), imageHeight);
    } else if (lastLevel == 7 && Get.height <= 667) {
      moveX = (-targetOffset.dx + Get.width / 1.5).clamp(-imageWidth + Get.width / 2.3, imageWidth);
      moveY = (-targetOffset.dy + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)) / 2.8).clamp(-imageHeight + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)), imageHeight);
    } else if (lastLevel == 7) {
      moveX = (-targetOffset.dx + Get.width / 1.2).clamp(-imageWidth + Get.width / 2.3, imageWidth);
      moveY = (-targetOffset.dy + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)) / 2.8).clamp(-imageHeight + (GetPlatform.isAndroid ? Get.height + 100 : (Get.height - 100)), imageHeight);
    }

    // Create target transformation matrix
    Matrix4 targetMatrix = (Matrix4.identity()..translate(moveX, moveY, 0));

    // Use Matrix4Tween for smooth animation
    final matrixTween = Matrix4Tween(begin: currentMatrix, end: targetMatrix);

    Animation<Matrix4> animation = matrixTween.animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    animation.addListener(() {
      transformationController.value = animation.value;
      update(); // Notify GetX UI
    });

    animationController.forward(from: 0).whenComplete(() {
      update(); // Ensure UI refresh after animation completes
    });
  }

  void initializeLevelPositions() {
    levelPositions = const [
      // Offset(1985.4, 3691.6), // 0 (clamped to max dimensions)
      // Offset(1985.4, 3691.6), // 1
      // Offset(1557.6, 3464.5), // 2
      // Offset(1693.5, 3253.4), // 3
      // Offset(1897.8, 3126.8), // 4
      // Offset(1664.3, 3043.8), // 5
      // Offset(1284.9, 2800.5), // 6
      // Offset(1654.6, 2450.2),
      Offset(1044, 3660), // 0
      Offset(940, 3500), // 1
      Offset(780, 3400), // 2
      Offset(850, 3200), // 3
      Offset(1000, 3000), // 4
      Offset(750, 2800), // 5
      Offset(640, 2600), // 6
      Offset(820, 2390), // 7
      // Offset(1024, 2100), // Middle of waterfall
      // Offset(1024, 1800), // Top pool of waterfall
      // Offset(900, 1600), // Path curve after waterfall
      // Offset(800, 1400), // Near top cabin
      // Offset(700, 1200), // Upper path section
      // Offset(600, 1000), // Near top pond
      // Offset(500, 800),
      // Offset(1030, 1960), //0
      // Offset(990.5, 1870.5), //1
      // Offset(900.8, 1830.0), //2
      // Offset(910.5, 1700.7), //3
      // Offset(990.5, 1575.0), //4
      // Offset(910.5, 1513.3), //5
      // Offset(820.5, 1440.7), //6
      // Offset(840.5, 1320.3), //7
    ];
  }

  Future<void> uploadFileApi() async {
    if (!await CommonMethods.checkInternetConnectivity()) {
      CommonMethods.showToast(appStrings.weUnableCheckData);
      return;
    }

    if (selectedFilePath.value?.isEmpty == null) {
      CommonMethods.showToastSuccess("Please select a file to upload!");
      return;
    }

    setRxRequestStatus(Status.LOADING);
    final String mediaLibraryType = MediaLibraryType.gallupResult.value;

    String? userId = await Utils.getPreferenceValues(Constants.userId);
    if (userId == null || userId.isEmpty) {
      CommonMethods.showToast("User ID not found!");
      setRxRequestStatus(Status.ERROR);
      return;
    }

    Utils.printLog("Uploading file for user: $userId");

    try {
      final response = await api.uploadApi(selectedFilePath.value, mediaLibraryType, userId);
      setUploadResultFile(response);
      setRxRequestStatus(Status.COMPLETED);
      update();
      Utils.printLog("Upload Response: ${response.toString()}");
    } catch (error) {
      handleApiError(error);
    }
  }

  Future<void> verifySubscriptionApi() async {
    if (!await CommonMethods.checkInternetConnectivity()) {
      CommonMethods.showToast(appStrings.weUnableCheckData);
      return;
    }
    Map<String, dynamic> data = {
      "redeemCode": couponCode.value //"kjsadfksafjkjksakjd"
    };

    isLoading.value = true;
    try {
      final response = await roadmapRepository.verifySubscriptionApi(data);
      setVerifySubscription(response);
      isLoading.value = false;
      update();
      Utils.printLog("Upload Response: ${response.toString()}");
    } catch (error) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
      isLoading.value = false;

      if (error.toString().contains("{")) {
        try {
          var errorResponse = json.decode(error.toString());
          String message = errorResponse['message'] ?? "An unexpected error occurred.";
          inValidCouponCode.value = message;
          // inValidCouponCode.value = "*The coupon code entered is invalid. Please check the code and try again.";
          //CommonMethods.showToast(message);
        } catch (_) {
          CommonMethods.showToast("An unexpected error occurred.");
        }
      }

      Utils.printLog("API Error: $error");
    }
  }

  void handleApiError(dynamic error) {
    setError(error.toString());
    setRxRequestStatus(Status.ERROR);
    isLoading.value = false;

    if (error.toString().contains("{")) {
      try {
        var errorResponse = json.decode(error.toString());
        String message = errorResponse['message'] ?? "An unexpected error occurred.";
        CommonMethods.showToast(message);
      } catch (_) {
        CommonMethods.showToast("An unexpected error occurred.");
      }
    }

    Utils.printLog("API Error: $error");
  }

  Future<void> getOnBoardingRoadmapApi() async {
    if (!await CommonMethods.checkInternetConnectivity()) {
      CommonMethods.showToast(appStrings.weUnableCheckData);
      return;
    }

    userName.value = await Utils.getPreferenceValues(Constants.firstName) ?? '';
    userImage.value = await Utils.getPreferenceValues(Constants.avatar) ?? '';

    try {
      final roadmapData = await onBoardRoadMapApi.getOnBoardingRoadmapApi();
      setOnBoardingRoadmapData(roadmapData);

      int completedSteps = roadmapData.data?.completedSteps?.length ?? 1;
      if (completedSteps == 8) {
        onStaticScreen(); // Navigate to static screen
      } else if (completedSteps == 1 || completedSteps != lastUnlockedLevel.value) {
        lastUnlockedLevel.value = completedSteps;
        await AppPreferences.saveOnBoardingLevelCompleted(lastUnlockedLevel.value);
        await (await SharedPreferences.getInstance()).setInt(Constants.onBoardingLastUnlockedLevel, lastUnlockedLevel.value + 1);
        scrollToLastUnlockedLevel(false, 0);
      } else {
        loadLastUnlockedLevel();
      }

      setRxRequestStatus(Status.COMPLETED);
      Utils.printLog("Roadmap Data Loaded: ${roadmapData.toString()}");
    } catch (error) {
      handleApiError(error);
    }
  }

  playYtVideo(url) {
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(url);
    // videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=IhPcbusMv1g");
    print(videoId);
    Get.to(() => YouTubeVideoPlayerWidget(videoId: videoId!));
  }

  onClickGallupVideo(url, level, stepId) {
    playVideo(url).then(() => {markLevelCompleted(level, stepId)});
  }

  playVideo(url) {
    // Get.to(() => VideoPlayerWidget(videoUrl: url));
    inHouseVideoUrl.value = url;
    showInHouseVideo.value = true;
    update();
  }

  hideVideoPlayWidget() {
    showInHouseVideo.value = false;
    update();
  }

  googleMeet(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  updateCurrIndexStepId(index, stepId) {
    currIndex.value = index;
    currStepId.value = stepId;
    update();
  }

  OnBoardingRoadMapContentType? getEnumFromValue(String value) {
    return OnBoardingRoadMapContentType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError("Invalid value: $value"),
    );
  }

  Future<void> handleAction(String type, bool isCurrent, String contentType, bool isCompleted, String inHouseVideoUrl, String? contentLink, int stepId, String assessmentId, int index, w, h) async {
    final onBoardRoadmapScreen = OnBoardingRoadmapScreen();
    final OnBoardingRoadMapContentType? onContentType = getEnumFromValue(type);

    // Early return if content type is invalid
    if (onContentType == null) {
      Utils.printLog("Invalid type: $type");
      return;
    }

    // Handle video content types with shared logic
    if ([OnBoardingRoadMapContentType.onBoardVideo, OnBoardingRoadMapContentType.gallupVideo, OnBoardingRoadMapContentType.coachVideo].contains(onContentType)) {
      _handleVideoContent(onBoardRoadmapScreen: onBoardRoadmapScreen, contentType: contentType, isCurrent: isCurrent, isCompleted: isCompleted, contentLink: contentLink, stepId: stepId, index: index);
      return;
    }

    // Handle other content types
    switch (onContentType) {
      case OnBoardingRoadMapContentType.assessment:
        if (isCurrent && !isCompleted) {
          onBoardRoadmapScreen.assignmentDialog(() {
            Get.back();
            Get.toNamed(RoutesClass.questionAnswer, arguments: [
              {'stepId': stepId},
              {'assessmentId': assessmentId},
              {'currentLevel': index},
              {'assessmentType': 'ASSESSMENT'}
            ]);
          });
        } else {
          onBoardRoadmapScreen.assignmentCompletedDialog(() {
            Get.back();
          });
        }
        break;
      case OnBoardingRoadMapContentType.softSkillAssessment:
        final bool isSoftSkill = onContentType == OnBoardingRoadMapContentType.softSkillAssessment;
        final String assessmentType = isSoftSkill ? 'SOFT_SKILL_ASSESSMENT' : 'ASSESSMENT';

        if (isCurrent && !isCompleted) {
        onBoardRoadmapScreen.assignmentOnBoardingDialog(() {
          Get.back();
          Get.toNamed(RoutesClass.questionAnswer, arguments: [
            {'stepId': stepId},
            {'assessmentId': assessmentId},
            {'currentLevel': index},
            {'assessmentType': assessmentType}
          ]);
        }, isSoftSkill);
        } else {
          onBoardRoadmapScreen.assignmentOnBoardingCompletedDialog(() {
            Get.back();
          }, isSoftSkill);
        }
        break;

      case OnBoardingRoadMapContentType.userInviteGallupCode:
        if (isCurrent && !isCompleted) {
          updateCurrIndexStepId(index, stepId);
          Get.to(() => RoadmapTaskDoneScreen(
                appBarBack: true,
                image: appImages.lockFullIcon,
                titleText: appStrings.codeTitle,
                buttonHint: appStrings.inviteParent,
                button2Hint: appStrings.enterCouponCode,
                subText: appStrings.codeDescription,
                onComplete: () => Get.toNamed(RoutesClass.parentInvite, arguments: [
                  {'isOnBoarding': true},
                  {"skip": false}
                ]),
                navigate: () {
                  bottomCodeDrawer(couponController.value, couponFocusNode.value, couponCode, inValidCouponCode, isLoading, (value) {
                    couponCode.value = value;
                    inValidCouponCode.value = null;
                  }, () async {
                    inValidCouponCode.value = null;
                    couponFocusNode.value.unfocus();
                    print(couponCode.value);
                    if (couponCode.value != "") {
                      await verifySubscriptionApi();
                      if (verifySubscription.value.statusCode == 200) {
                        Get.back();
                        Get.back();
                        couponController.value.text = "";
                        markLevelCompleted(index, stepId);
                        onBoardRoadmapScreen.onBoardingCouponCodeCompletedDialog(w, h);
                      }
                    } else {
                      inValidCouponCode.value = null;
                    }
                    isLoading.value = false;
                    // isLoading.value=true;
                    // verifySubscriptionApi();
                    // Future.delayed(const Duration(seconds: 4), () {
                    //   couponFocusNode.value.unfocus();
                    //   print(couponCode.value);
                    //   if (couponCode.value != "") {
                    //     if (couponCode.value == "PAY-5000") {
                    //       Get.back();
                    //       Get.back();
                    //       couponController.value.text = "";
                    //       markLevelCompleted(index, stepId);
                    //       onBoardRoadmapScreen.onBoardingCouponCodeCompletedDialog(w, h);
                    //     } else {
                    //       inValidCouponCode.value = "*The coupon code entered is invalid. Please check the code and try again.";
                    //     }
                    //   } else {
                    //     inValidCouponCode.value = null;
                    //   }
                    //   isLoading.value=false;
                    // });
                  });
                },
              ));
        } else {
          onBoardRoadmapScreen.onBoardingCouponCodeCompletedDialog(w, h);
        }
        break;

      case OnBoardingRoadMapContentType.gallupResult:
        if (isCurrent && !isCompleted) {
          updateCurrIndexStepId(index, stepId);
          onBoardRoadmapScreen.resultUploadDialog(contentLink);
        } else {
          updateCurrIndexStepId(index, stepId);
          onBoardRoadmapScreen.resultUploadCompletedDialog(contentLink);
        }
        break;

      case OnBoardingRoadMapContentType.scheduleCoachmeeting:
        if (isCurrent && !isCompleted) {
          onBoardRoadmapScreen.strengthCoachingDialog(() async {
            String url = contentLink ?? "https://calendly.com/alexa-mytreks/coaching-session";
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            } else {
              throw 'Could not launch $url';
            }
          }, () {
            Get.back();
            markLevelCompleted(index, stepId);
          });
        } else {
          onBoardRoadmapScreen.strengthCoachingCompletedDialog(() {
            Get.back();
            onStaticScreen();
          });
        }
        //googleMeet(inHouseVideoUrl);
        break;

      default:
        // This should never be reached due to early return if onContentType is null
        Utils.printLog("Unhandled content type: $type");
    }
  }

  onStaticScreen() {
    Get.to(() => RoadmapTaskDoneScreen(appBarBack: true, isLottie: true, image: appImages.sandClockLoading, titleText: appStrings.journeyCreationInProgress, subText: appStrings.journeyCreationDescription, showButton: false, paddingTop: 200));
  }

  void _handleVideoContent({required OnBoardingRoadmapScreen onBoardRoadmapScreen, required String contentType, required bool isCurrent, required bool isCompleted, required String? contentLink, required int stepId, required int index}) {
    final videoContentType = getEnumFromValue(contentType);

    if (videoContentType == null) {
      Utils.printLog("Unsupported video content type: $contentType");
      return;
    }

    switch (videoContentType) {
      case OnBoardingRoadMapContentType.nativeVideo:
        if (isCurrent && !isCompleted) {
          onBoardRoadmapScreen.openVideoDialog(() {
            Get.back();
            markLevelCompleted(index, stepId);
            // onBoardRoadmapScreen.videoCompleteDialog(contentLink, "video");
          }, () {
            Get.back();
            playVideo(contentLink!);
            onBoardRoadmapScreen.playVideoInPopUp(contentLink);
          }, "video");
        } else {
          onBoardRoadmapScreen.videoCompleteDialog(contentLink, "video");
        }
        break;

      case OnBoardingRoadMapContentType.youtubeVideo:
        if (isCurrent && !isCompleted) {
          onBoardRoadmapScreen.openVideoDialog(() {
            Get.back();
            markLevelCompleted(index, stepId);
            // onBoardRoadmapScreen.videoCompleteDialog(contentLink, "youtube");
          }, () {
            Get.back();
            playYtVideo(contentLink!);
          }, "youtube");
        } else {
          onBoardRoadmapScreen.videoCompleteDialog(contentLink, "youtube");
        }
        break;

      default:
        Utils.printLog("Unsupported video content type: $contentType");
    }
  }

  final uploadFileData = UploadMediaModel().obs;
  void setUploadFileData(UploadMediaModel value) => uploadFileData.value = value;
}

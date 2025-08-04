import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vroar/models/get_logout_model.dart';
import 'package:vroar/models/get_profile_model.dart';
import 'package:vroar/modules/repository/login_repository.dart';
import 'package:vroar/modules/repository/profile_repository.dart';
import 'package:vroar/resources/strings.dart';

import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/delete_user_model.dart';
import '../../models/upload_media_model.dart';
import '../../routes/routes_class.dart';
import '../../utils/utils.dart';
import '../repository/signup_repository.dart';
import 'common_screen_controller.dart';

class ProfileDetailsController extends GetxController {
  final CommonScreenController mainController =
      Get.put(CommonScreenController());

  var selectedImage = Rxn<String>();

  final api = SignupRepository();
  final profileApi = ProfileRepository();
  final logoutApi = LoginRepository();
  var toggle = true.obs;
  final uploadProfileData = UploadMediaModel().obs;
  final getProfileData = GetProfileModel().obs;
  final getLogoutData = GetLogoutModel().obs;
  final deleteAccountData = DeleteUser().obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  RxString error = ''.obs;
  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setUploadProfileData(UploadMediaModel value) =>
      uploadProfileData.value = value;
  void setGetProfileData(GetProfileModel value) => getProfileData.value = value;
  void setGetLogoutData(GetLogoutModel value) => getLogoutData.value = value;
  void setDeleteAccountData(DeleteUser value) =>
      deleteAccountData.value = value;

  Future<void> uploadProfileApi() async {
    if (!await _checkConnection()) return;

    setRxRequestStatus(Status.LOADING);

    try {
      final String filePath = selectedImage.value ?? "";
      const String mediaLibraryType = 'PROFILE';
      final String userId =
          await Utils.getPreferenceValues(Constants.userId) ?? "";

      final response = await api.uploadApi(filePath, mediaLibraryType, userId);

      setRxRequestStatus(Status.COMPLETED);
      if (response.statusCode == 200) {
        setUploadProfileData(response);
        CommonMethods.showToastSuccess(appStrings.profileImgeUploaded);
        Utils.printLog("Upload Profile Response: $response");
        await mainController.getProfileApi();
      }
    } catch (error, stackTrace) {
      _handleApiError(error, stackTrace);
    }
  }

  Future<void> getLogoutApi() async {
    if (!await _checkConnection()) return;
    setRxRequestStatus(Status.LOADING);
    try {
      final response = await logoutApi.logoutApi();
      setRxRequestStatus(Status.COMPLETED);
      setGetLogoutData(response);
      CommonMethods.showToastSuccess(response.message!);
      Utils.printLog("Logout Response: $response");

      Utils.clearPreferenceValues();
      Utils.savePreferenceValues(Constants.isOnBoarding, "No");
      Get.offAllNamed(RoutesClass.login);
    } catch (error, stackTrace) {
      _handleApiError(error, stackTrace);
    }
  }

  // Helper methods to reduce code duplication
  Future<bool> _checkConnection() async {
    final bool hasConnection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("Internet Connection: $hasConnection");

    if (!hasConnection) {
      CommonMethods.showToast(appStrings.weUnableCheckData);
      return false;
    }

    return true;
  }

  Future<void> deleteAccountApi() async {
    if (!await _checkConnection()) return;
    setRxRequestStatus(Status.LOADING);
    try {
      Get.back();
      final response = await logoutApi.deleteAccountApi();
      setRxRequestStatus(Status.COMPLETED);
      setDeleteAccountData(response);
      Utils.printLog("Delete Account Response: $response");

      if (response.statusCode == 200) {
        CommonMethods.showToastSuccess(response.message!);
        Utils.clearPreferenceValues();
        Utils.savePreferenceValues(Constants.isOnBoarding, "No");
        Get.offAllNamed(RoutesClass.login);
      } else {
        CommonMethods.showToast(
            "Failed to delete account: ${response.message}");
      }
    } catch (error, stackTrace) {
      _handleApiError(error, stackTrace);
    }
  }

  void _handleApiError(dynamic error, StackTrace stackTrace) {
    setError(error.toString());
    setRxRequestStatus(Status.ERROR);

    if (error.toString().contains("{")) {
      try {
        final errorResponse = json.decode(error.toString());
        Utils.printLog("Error Response: $errorResponse");

        if (errorResponse is Map && errorResponse.containsKey('message')) {
          CommonMethods.showToast(errorResponse['message']);
        } else {
          CommonMethods.showToast("An unexpected error occurred.");
        }
      } catch (e) {
        CommonMethods.showToast("Error parsing server response.");
      }
    } else {
      CommonMethods.showToast("An unexpected error occurred.");
    }

    Utils.printLog("Error: $error");
    Utils.printLog("Stack Trace: $stackTrace");
  }

  openWebPage(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}

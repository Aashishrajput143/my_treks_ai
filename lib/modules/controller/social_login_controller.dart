import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vroar/models/google_login_model.dart';
import 'package:vroar/models/login_model.dart';
import 'package:vroar/modules/repository/signup_repository.dart';
import 'package:vroar/routes/routes_class.dart';
//import 'package:http/http.dart' as http;

import '../../common/Constants.dart';
import '../../common/common_methods.dart';
import '../../data/app_url/app_base_url.dart';
import '../../data/app_url/app_url.dart';
import '../../data/response/status.dart';
import '../../models/apple_login_model.dart';
import '../../models/update_profile_model.dart';
import '../../resources/strings.dart';
import '../../utils/utils.dart';
import '../repository/login_repository.dart';

class SocialLoginController extends GetxController {
  final _api = LoginRepository();
  final signApi = SignupRepository();

  RxString accessToken = ''.obs;
  RxString username = ''.obs;
  RxString idToken = ''.obs;
  RxString email = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  var userImage = ''.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      //'email',
      'profile',
      'openid', // Add this scope for serverAuthCode
    ],
    signInOption: SignInOption.standard, // or SignInOption.serverAuthCode if you're using serverAuthCode
    serverClientId: Platform.isIOS ? "814443057039-dp0b894kkr8t1phc789qtp9a82un69rr.apps.googleusercontent.com" : "814443057039-h55fl7pjfabl3b8rgo1fhg7s4jlofale.apps.googleusercontent.com", // Replace with your Web Client ID
  );
  Future<void> signIn() async {
    try {
      await _googleSignIn.signOut();

      final account = await _googleSignIn.signIn();
      print(account);
      List<String> name = (account?.displayName ?? "").trim().split(" ");
      firstName.value = name.isNotEmpty ? name[0] : '';
      lastName.value = name.length > 1 ? name.sublist(1).join(" ") : '';
      Utils.savePreferenceValues(Constants.firstName, account?.displayName ?? "");
      Utils.savePreferenceValues(Constants.email, account?.email ?? "");
      Utils.savePreferenceValues(Constants.avatar, account?.photoUrl ?? "");
      if (account != null) {
        await fetchTokens(account);
        googleLoginApi();
      }
    } catch (e) {
      print('Error decoding token: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    print("Logout=============>");
  }

  Future<void> fetchTokens(GoogleSignInAccount account) async {
    try {
      final authentication = await account.authentication;
      accessToken.value = authentication.accessToken ?? '';
      idToken.value = authentication.idToken ?? '';
    } catch (e) {
      print('Error decoding token: $e');
    }
    print("accessToken=======> $accessToken");
    print("idToken======>$idToken");
  }

  Future<void> verifyAppleIdToken(String idToken) async {
    try {
      final jwt = JWT.decode(idToken);
      print("User email: ${jwt.payload}");
      print("User email: ${jwt.audience}");
      final dynamic emailId = jwt.payload["email"];
      email.value = emailId;
      Utils.savePreferenceValues(Constants.email, emailId ?? "");

      print("User email save: $email");
    } catch (e) {
      print('Error decoding token: $e');
    }
  }

  Future<void> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,

        webAuthenticationOptions: Platform.isAndroid
            ? WebAuthenticationOptions(
                clientId: "com.vroar.vroar-service", // Your service ID from Apple Developer
                redirectUri: Uri.parse("https://www.vroar.ai/apple/login/callback"), // Your backend URL
              )
            : null, // iOS does not need web authentication options
      );

      final String? emailId = credential.email;
      final String? name = credential.givenName;
      final String fullName = "${credential.givenName} ${credential.familyName}";
      final String? familyName = credential.familyName;

      debugPrint("Apple Sign-In Success:");
      debugPrint("User ID: ${credential.userIdentifier}");
      debugPrint("Email: $emailId");
      debugPrint("Full Name: $fullName");
      debugPrint("family Name: $familyName");
      debugPrint("identity token: ${credential.identityToken}");
      firstName.value = name ?? "";
      lastName.value = familyName ?? "";
      username.value = ((credential.givenName?.isNotEmpty ?? false) && (credential.familyName?.isNotEmpty ?? false))
          ? fullName
          : (credential.givenName?.isNotEmpty ?? false)
              ? name ?? ""
              : "";
      idToken.value = credential.identityToken ?? '';
      verifyAppleIdToken(idToken.value);
      Utils.savePreferenceValues(Constants.firstName, name ?? "");
      appleLoginApi();

      // if (email.value != "" && email.value.endsWith("@privaterelay.appleid.com")) {
      //   debugPrint("User chose to hide their email.");
      //   CommonMethods.showToast(
      //     "We are unable to proceed with a private Apple email address. Please use 'Share My Email' during sign-in to continue.",time: 7,
      //   );
      // } else {
      //   Utils.savePreferenceValues(Constants.firstName, name ?? "");
      //   appleLoginApi();
      // }
    } catch (e) {
      print('Error decoding token: $e');
    }
  }

  /// Generates a random nonce for Apple Sign-In
  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    return List.generate(length, (index) => charset[DateTime.now().millisecond % charset.length]).join();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final googleLoginData = GoogleLoginModel().obs;
  final appleLoginData = AppleLoginModel().obs;
  final signUpGoogleData = UpdateProfileModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setGoogleLoginData(GoogleLoginModel value) => googleLoginData.value = value;
  void setAppleLoginData(AppleLoginModel value) => appleLoginData.value = value;
  void setSignUpGoogleData(UpdateProfileModel value) => signUpGoogleData.value = value;

  void handleError(error, stackTrace) {
    setError(error.toString());
    setRxRequestStatus(Status.ERROR);
    if (error.toString().contains("{")) {
      final errorResponse = json.decode(error.toString());
      CommonMethods.showToast(errorResponse is Map && errorResponse.containsKey('message') ? errorResponse['message'] : "An unexpected error occurred.");
    }
    Utils.printLog("Error===> ${error.toString()}");
    Utils.printLog("stackTrace===> ${stackTrace.toString()}");
  }

  Future<void> googleLoginApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"id_token": idToken.value};
      _api.googleApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGoogleLoginData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        Utils.savePreferenceValues(Constants.accessToken, value.data?.accessToken ?? "");
        Utils.savePreferenceValues(Constants.isSocialLogin, value.data?.accessToken ?? "");
        Utils.savePreferenceValues(Constants.refreshToken, value.data?.refreshToken ?? "");
        Utils.savePreferenceValues(Constants.role, value.data?.group ?? "");
        signOut();
        redirect(value.data?.group);
      }).onError((error, stackTrace) {
        handleError(error, stackTrace);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> appleLoginApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "id_token": idToken.value,
        if (username.value.isNotEmpty && username.value != "") "name": username.value,
      };
      _api.appleApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setAppleLoginData(value);
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        Utils.savePreferenceValues(Constants.accessToken, value.data?.accessToken ?? "");
        Utils.savePreferenceValues(Constants.isSocialLogin, value.data?.accessToken ?? "");
        Utils.savePreferenceValues(Constants.refreshToken, value.data?.refreshToken ?? "");
        Utils.savePreferenceValues(Constants.role, value.data?.group ?? "");
        redirect(value.data?.group);
      }).onError((error, stackTrace) {
        handleError(error, stackTrace);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> updateProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        if (firstName.value.isNotEmpty) "firstName": firstName.value,
        if (lastName.value.isNotEmpty) "lastName": lastName.value,
        "role": "STUDENT",
        // "phoneNo": phoneController.value.text,
        // if (selectedImage.value?.isNotEmpty ?? false) "avatar": uploadProfileData.value.data?.filePath,
        // "countryCode": countryCode.value,
        // "gender": selectedGender.value,
        // if (selectedGrade.value != null) "grade": selectedGrade.value,
        // "birthDate": selectedDateUnixStamp.value
      };
      signApi.signUpSocialApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setSignUpGoogleData(value);
        Utils.savePreferenceValues(Constants.accessToken, value.data?.accessToken ?? "");
        Utils.savePreferenceValues(Constants.role, value.data?.role ?? "");
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        redirectSocialLogin(value.data?.role);
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

  void redirect(role) {
    if (role != null && role != "") {
      print("commonScreen $role");
      role == "STUDENT" ? Get.offAllNamed(RoutesClass.commonScreen, arguments: role) : websiteLaunch();
    } else {
      // isUserRoleBack.value = false;
      // print("userRole $role");
      // Get.offAllNamed(RoutesClass.userRole);
      updateProfileApi();
    }
    print("Login Successful");
  }

  void redirectSocialLogin(role) {
    role == "STUDENT" ? Get.offAllNamed(RoutesClass.commonScreen, arguments: role) : websiteLaunch();
    // Get.toNamed(RoutesClass.parentInvite, arguments: [
    //   {'isOnBoarding': false},
    //   {"skip": true}
    // ]);
  }

  websiteLaunch() {
    var websiteUrl = AppUrl.baseUrl == AppBaseUrl.baseUrlMyTreksDev
        ? 'https://dev.accounts.mytreks.ai/login'
        : AppUrl.baseUrl == AppBaseUrl.baseUrlMyTreksUAT
            ? 'https://uat.accounts.mytreks.ai/login'
            : 'https://accounts.mytreks.ai/login';
    final uri = Uri.parse(websiteUrl);
    Utils.clearPreferenceValues();
    Utils.savePreferenceValues(Constants.isOnBoarding, "No");
    launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}

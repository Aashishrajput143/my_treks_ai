import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vroar/common/app_constants_list.dart';
import 'package:vroar/models/upload_media_model.dart';
import 'package:vroar/modules/repository/signup_repository.dart';
import 'package:vroar/resources/strings.dart';

import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../models/signup_model.dart';
import '../../models/update_profile_model.dart';
import '../../resources/colors.dart';
import '../../resources/validator.dart';
import '../../routes/routes_class.dart';
import '../../utils/roadmap_enums.dart';
import '../../utils/utils.dart';

class SignupDetailsController extends GetxController {
  var role = "".obs;
  final _api = SignupRepository();

  var firstNameController = TextEditingController().obs;
  var firstNameFocusNode = FocusNode().obs;
  var lastNameController = TextEditingController().obs;
  var lastNameFocusNode = FocusNode().obs;
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var passwordController = TextEditingController().obs;
  var passwordFocusNode = FocusNode().obs;
  var cPasswordController = TextEditingController().obs;
  var cPasswordFocusNode = FocusNode().obs;
  var phoneController = TextEditingController().obs;
  var phoneNumberFocusNode = FocusNode().obs;
  var dobController = TextEditingController().obs;
  var dobFocusNode = FocusNode().obs;
  var ageController = TextEditingController().obs;
  var ageFocusNode = FocusNode().obs;
  var age = Rxn<int>();
  RxnString errorEmail = RxnString();

  @override
  Future<void> onInit() async {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    role.value = arguments['role'] ?? "";
    emailController.value.text = arguments['emailId'] ?? "";
    print(role.value);
  }

  var countryCode = "+1".obs;
  var phoneTotalCount = 10.obs;
  var showPassword = true.obs;
  var showCPassword = true.obs;
  var avatar = "".obs;

  // Rx<DateTime> selectedDate = DateTime(0, 0, 0, 0, 0).obs;
  // var selectedDateUnixStamp = 0.obs;
  var selectedAgeUnixStamp = 0.obs;
  List<String> genderOptions = AppConstantsList.genderOptions;
  List<String> gradeOptions = AppConstantsList.gradeOptions;
  var selectedGender = Rxn<String>();
  var selectedGrade = Rxn<String>();
  RxBool isChecked = false.obs;
  var selectedImage = Rxn<String>();
  var profileImage = Rxn<String>();

  String? isValidate(role) {
    if (firstNameController.value.text.isEmpty) {
      return "please enter the first name";
    }
    if (lastNameController.value.text.isEmpty) {
      return "please enter the last name";
    }
    if (role == "STUDENT") {
      if (selectedGrade.value == null) {
        return "please select the grade";
      }
    }
    if (emailController.value.text.isEmpty) {
      return "please enter the email";
    }
    // if (phoneController.value.text.isEmpty) {
    //   return "please enter the phone number";
    // }
    // if (selectedDate.value == DateTime(0, 0, 0, 0, 0)) {
    //   return "please select date of birth";
    // }
    // if (selectedGender.value == null) {
    //   return "please enter the gender";
    // }
    if (isChecked.value == false) {
      return "please checked the terms and conditions";
    }
      if ((Validator.validatePassword(passwordFocusNode.value.hasPrimaryFocus ? "" : passwordController.value.text, cPasswordController.value.text, false)) != null) {
        return Validator.validatePassword(passwordFocusNode.value.hasPrimaryFocus ? "" : passwordController.value.text, cPasswordController.value.text, false);
      }
      if ((Validator.validatePassword(cPasswordFocusNode.value.hasPrimaryFocus ? "" : cPasswordController.value.text, passwordController.value.text, true)) != null) {
        return Validator.validatePassword(cPasswordFocusNode.value.hasPrimaryFocus ? "" : cPasswordController.value.text, passwordController.value.text, true);
      }
      if ((Validator.validateEmail(emailFocusNode.value.hasPrimaryFocus ? "" : emailController.value.text)) != null) {
        return Validator.validateEmail(emailFocusNode.value.hasPrimaryFocus ? "" : emailController.value.text);
      }
      if (passwordController.value.text.isEmpty && cPasswordController.value.text.isEmpty) {
        return "please enter the password";
      }
    // if (Validator.validateAge(selectedDate.value.toString(), 13) != null) {
    //   return Validator.validateAge(selectedDate.value.toString(), 13);
    // }
    return null;
  }

  Future<void> selectAge(BuildContext context) async{
    showMaterialNumberPicker(
        context: context,
        maxLongSide: 400,
        maxShortSide: 400,
        buttonTextColor: appColors.contentAccent,
        headerColor: appColors.contentAccent,
        title: 'Select Your Age',
        maxNumber: 50,
        minNumber: 13,
        selectedNumber: age.value,
        onChanged: (value){
          age.value=value;
          ageController.value.text=value.toString();
          convertAgeToUnixTimestamp(age.value??13);
        }
    );
  }

  void convertAgeToUnixTimestamp(int age) {
    final now = DateTime.now();
    final birthDate = DateTime(now.year - age, now.month, now.day);

    final safeBirthDate = birthDate.isBefore(DateTime(1971))
        ? DateTime(1971, 1, 1)
        : birthDate;

    selectedAgeUnixStamp.value = safeBirthDate.toUtc().millisecondsSinceEpoch ~/ 1000;

    print('Age: $age');
    print('Unix Timestamp: ${selectedAgeUnixStamp.value}');
  }



  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     fieldHintText: 'DD/MM/YYYY',
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1971),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != selectedDate.value) {
  //     selectedDate.value = picked;
  //     selectedDateUnixStamp.value = picked.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     dobController.value.text = DateFormat('dd/MM/yyyy').format(picked);
  //   }
  //   print(selectedDate);
  //   print(selectedDateUnixStamp);
  // }

  final rxRequestStatus = Status.COMPLETED.obs;
  final signUpData = SignUpModel().obs;
  final signUpGoogleData = UpdateProfileModel().obs;
  final uploadProfileData = UploadMediaModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSignUpData(SignUpModel value) => signUpData.value = value;
  void setSignUpGoogleData(UpdateProfileModel value) => signUpGoogleData.value = value;
  void setUploadProfileData(UploadMediaModel value) => uploadProfileData.value = value;

  Future<void> registerApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "firstName": firstNameController.value.text,
        "lastName": lastNameController.value.text,
        "email": emailController.value.text,
        if (phoneController.value.text.isNotEmpty) "phoneNo": phoneController.value.text,
        if (phoneController.value.text.isNotEmpty) "countryCode": countryCode.value,
        if (selectedImage.value?.isNotEmpty ?? false) "avatar": uploadProfileData.value.data?.filePath,
        "password": cPasswordController.value.text,
        "role": role.value,
        if (selectedGender.value?.isNotEmpty ?? false)"gender": selectedGender.value,
        "grade": selectedGrade.value,
        // "birthDate": selectedDateUnixStamp.value
        if (ageController.value.text.isNotEmpty)"birthDate": selectedAgeUnixStamp.value
      };
      _api.signUpApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setSignUpData(value);
        CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect ${value.data?.referenceId}");
        redirect(value.data?.referenceId ?? "0", "${emailController.value.text} ");
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

  Future<void> uploadProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      String filePath = selectedImage.value ?? "";
      String mediaLibraryType = MediaLibraryType.profile.value;

      _api.uploadApi(filePath, mediaLibraryType, "").then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setUploadProfileData(value);
        //CommonMethods.showToastSuccess("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        registerApi();
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

  Future<void> submit() async {
    if (selectedImage.value?.isNotEmpty ?? false) {
      await uploadProfileApi();
    } else {
      registerApi();
    }
  }

  void redirect(String referenceId, String emailId) {
    Get.toNamed(RoutesClass.verificationCode, arguments: {
      'referenceId': int.parse(referenceId),
      'emailId': emailId,
      'forget': false,
    });
  }
}

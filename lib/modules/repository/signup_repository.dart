import 'package:vroar/models/upload_media_model.dart';
import 'package:vroar/models/user_invite_model.dart';
import 'package:vroar/models/verify_otp_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../models/signup_model.dart';
import '../../models/update_profile_model.dart';

class SignupRepository {
  final _apiServices = NetworkApiServices();

  Future<SignUpModel> signUpApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.register);
    return SignUpModel.fromJson(response);
  }

  Future<UploadMediaModel> uploadApi(var filePath, var mediaLibraryType, var userId) async {
    dynamic response = await _apiServices.formDataApi(filePath, mediaLibraryType,userId, AppUrl.uploadMedia);
    return UploadMediaModel.fromJson(response);
  }

  Future<UpdateProfileModel> signUpSocialApi(var data) async {
    dynamic response = await _apiServices.putEncodeApi(data, AppUrl.updateProfile,isSocialLogin: true);
    return UpdateProfileModel.fromJson(response);
  }

  Future<UpdateProfileModel> editProfile(var data) async {
    dynamic response = await _apiServices.putEncodeApi(data, AppUrl.updateProfile);
    return UpdateProfileModel.fromJson(response);
  }

  Future<VerifyOtpModel> verifyOTPApi(var data) async {
    dynamic response = await _apiServices.postEncodeApiForFCM(data, AppUrl.verify);
    return VerifyOtpModel.fromJson(response);
  }

  Future<UserInviteModel> userInviteApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.userInvite);
    return UserInviteModel.fromJson(response);
  }
}

import 'package:vroar/models/apple_login_model.dart';
import 'package:vroar/models/delete_user_model.dart';
import 'package:vroar/models/google_login_model.dart';
import 'package:vroar/models/login_model.dart';
import 'package:vroar/models/refresh_token_model.dart';
import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../models/get_logout_model.dart';
import '../../models/verify_email_model.dart';

class LoginRepository {
  final _apiServices = NetworkApiServices();

  Future<LoginModel> loginApi(var data) async {
    dynamic response = await _apiServices.postEncodeApiForFCM(data, AppUrl.login);
    return LoginModel.fromJson(response);
  }

  Future<VerifyEmailModel> verifyEmailApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.verifyEmail);
    return VerifyEmailModel.fromJson(response);
  }

  Future<GoogleLoginModel> googleApi(var data) async {
    dynamic response = await _apiServices.postEncodeApiForFCM(data, AppUrl.googleLogin);
    return GoogleLoginModel.fromJson(response);
  }

  Future<AppleLoginModel> appleApi(var data) async {
    dynamic response = await _apiServices.postEncodeApiForFCM(data, AppUrl.appleLogin);
    return AppleLoginModel.fromJson(response);
  }

  Future<GetLogoutModel> logoutApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.getLogout);
    return GetLogoutModel.fromJson(response);
  }

  Future<DeleteUser> deleteAccountApi() async {
    dynamic response = await _apiServices.deleteApi(AppUrl.deleteUser);
    return DeleteUser.fromJson(response);
  }

  Future<RefreshTokenModel> refreshTokenApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.refreshToken);
    return RefreshTokenModel.fromJson(response);
  }
}

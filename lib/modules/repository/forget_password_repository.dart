import 'package:vroar/models/forget_email_model.dart';
import 'package:vroar/models/forget_password_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class ForgetPasswordRepository {
  final _apiServices = NetworkApiServices();

  Future<ForgetEmailModel> getForgetEmailApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data,AppUrl.forgetEmail);
    return ForgetEmailModel.fromJson(response);
  }

  Future<ForgetPasswordModel> getForgetPasswordApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data,AppUrl.forgetPassword);
    return ForgetPasswordModel.fromJson(response);
  }
}

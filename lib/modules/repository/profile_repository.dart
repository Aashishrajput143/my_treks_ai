

import 'package:vroar/models/get_profile_model.dart';
import 'package:vroar/models/need_assistance_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../models/change_password_model.dart';

class ProfileRepository {
  final _apiServices = NetworkApiServices();

  Future<GetProfileModel> getProfile() async {
    dynamic response =
    await _apiServices.getApi(AppUrl.getProfile);
    return GetProfileModel.fromJson(response);
  }

  Future<ChangePasswordModel> changePassword(var data) async {
    dynamic response =
    await _apiServices.postEncodeApiForFCM(data,AppUrl.changePassword);
    return ChangePasswordModel.fromJson(response);
  }

  Future<NeedAssistanceModel> needAssistance(var data) async {
    dynamic response =
    await _apiServices.postEncodeApi(data,AppUrl.needAssistance);
    return NeedAssistanceModel.fromJson(response);
  }
}

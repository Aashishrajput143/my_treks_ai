import 'package:vroar/models/get_internship_list_model.dart';
import 'package:vroar/models/saved_internship_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../models/get_internship_details_model.dart';

class InternshipRepository {
  final _apiServices = NetworkApiServices();

  Future<GetInternshipListModel> getInternshipListApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data,AppUrl.getInternshipList);
    return GetInternshipListModel.fromJson(response);
  }

  Future<GetInternshipDetailModel> getInternshipDetailApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getInternshipDetail}$id");
    return GetInternshipDetailModel.fromJson(response);
  }

  Future<SavedInternshipModel> savedInternshipApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data,AppUrl.savedInternship);
    return SavedInternshipModel.fromJson(response);
  }
}

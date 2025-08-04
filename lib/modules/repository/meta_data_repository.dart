import 'package:vroar/models/get_meta_data_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class MetaDataRepository {
  final _apiServices = NetworkApiServices();

  Future<GetMetaDataModel> getMetaDataApi(var page,var pageSize,var type) async {
    dynamic response = await _apiServices.getApi("${AppUrl.getMetaData}$page&pageSize=$pageSize&type=$type");
    return GetMetaDataModel.fromJson(response);
  }
}

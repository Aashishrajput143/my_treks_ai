import 'package:vroar/models/get_event_by_id_model.dart';
import 'package:vroar/models/get_event_list_model.dart';
import 'package:vroar/models/redeem_rewards_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class EventRepository {
  final _apiServices = NetworkApiServices();

  Future<GetEventListModel> getEventListApi(var page, var pageSize) async {
    dynamic response = await _apiServices.getApi("${AppUrl.eventList}$page&pageSize=$pageSize");
    return GetEventListModel.fromJson(response);
  }

  Future<GetEventByIdModel> getEventByIdApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.event}$id");
    return GetEventByIdModel.fromJson(response);
  }

  Future<RedeemRewardsModel> redeemRewardsApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.redeemRewards}$id");
    return RedeemRewardsModel.fromJson(response);
  }
}

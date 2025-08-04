import 'package:vroar/models/coin_history_model.dart';
import 'package:vroar/models/get_total_coin_model.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class CoinRepository {
  final _apiServices = NetworkApiServices();

  Future<GetTotalCoinModel> getTotalCoinApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.totalCoin);
    return GetTotalCoinModel.fromJson(response);
  }

  Future<CoinHistoryModel> getCoinHistoryApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.coinHistory);
    return CoinHistoryModel.fromJson(response);
  }
}
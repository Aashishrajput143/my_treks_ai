class GetTotalCoinModel {
  String? message;
  DataTotalCoin? data;
  int? statusCode;

  GetTotalCoinModel({this.message, this.data, this.statusCode});

  GetTotalCoinModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new DataTotalCoin.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class DataTotalCoin {
  int? totalCoinEarn;

  DataTotalCoin({this.totalCoinEarn});

  DataTotalCoin.fromJson(Map<String, dynamic> json) {
    totalCoinEarn = json['totalCoinEarn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCoinEarn'] = this.totalCoinEarn;
    return data;
  }
}
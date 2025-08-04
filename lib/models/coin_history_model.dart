class CoinHistoryModel {
  String? message;
  DataCoinHistory? data;
  int? statusCode;

  CoinHistoryModel({this.message, this.data, this.statusCode});

  CoinHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new DataCoinHistory.fromJson(json['data']) : null;
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

class DataCoinHistory {
  List<Docs>? docs;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  int? page;
  int? totalDocs;
  int? totalPages;
  int? totalCoinEarn;

  DataCoinHistory(
      {this.docs,
        this.hasNextPage,
        this.hasPrevPage,
        this.limit,
        this.page,
        this.totalDocs,
        this.totalPages,
        this.totalCoinEarn});

  DataCoinHistory.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
    limit = json['limit'];
    page = json['page'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
    totalCoinEarn = json['totalCoinEarn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalDocs'] = this.totalDocs;
    data['totalPages'] = this.totalPages;
    data['totalCoinEarn'] = this.totalCoinEarn;
    return data;
  }
}

class Docs {
  String? id;
  String? createdAt;
  String? rewardType;
  String? description;
  String? earnedFrom;
  int? rewardValue;
  String? actionType;

  Docs(
      {this.id,
        this.createdAt,
        this.rewardType,
        this.description,
        this.earnedFrom,
        this.rewardValue,
        this.actionType});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    rewardType = json['rewardType'];
    description = json['description'];
    earnedFrom = json['earnedFrom'];
    rewardValue = json['rewardValue'];
    actionType = json['actionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['rewardType'] = this.rewardType;
    data['description'] = this.description;
    data['earnedFrom'] = this.earnedFrom;
    data['rewardValue'] = this.rewardValue;
    data['actionType'] = this.actionType;
    return data;
  }
}
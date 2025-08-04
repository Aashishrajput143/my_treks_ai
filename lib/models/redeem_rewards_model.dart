class RedeemRewardsModel {
  String? message;
  DataRewards? data;
  int? statusCode;

  RedeemRewardsModel({this.message, this.data, this.statusCode});

  RedeemRewardsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new DataRewards.fromJson(json['data']) : null;
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

class DataRewards {
  int? usedCoins;
  User? user;
  Event? event;
  int? createdAt;
  int? updatedAt;
  String? id;
  bool? isJoined;

  DataRewards(
      {this.usedCoins,
        this.user,
        this.event,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.isJoined});

  DataRewards.fromJson(Map<String, dynamic> json) {
    usedCoins = json['usedCoins'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    isJoined = json['isJoined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usedCoins'] = this.usedCoins;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['isJoined'] = this.isJoined;
    return data;
  }
}

class User {
  String? id;

  User({this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Event {
  int? id;

  Event({this.id});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
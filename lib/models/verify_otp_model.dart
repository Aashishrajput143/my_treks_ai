class VerifyOtpModel {
  String? message;
  Data? data;
  int? statusCode;

  VerifyOtpModel({this.message, this.data, this.statusCode});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  dynamic group;
  String? email;

  Data({this.accessToken, this.refreshToken, this.group, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    group = json['group'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['group'] = group;
    data['email'] = email;
    return data;
  }
}

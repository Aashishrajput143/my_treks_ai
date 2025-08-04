class UpdateProfileModel {
  String? message;
  Data? data;
  int? statusCode;

  UpdateProfileModel({this.message, this.data, this.statusCode});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? group;
  String? role;

  Data({this.accessToken, this.refreshToken, this.group, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    group = json['group'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['group'] = group;
    data['role'] = role;
    return data;
  }
}

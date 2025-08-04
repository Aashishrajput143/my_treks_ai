class SignUpModel {
  String? message;
  Data? data;
  int? statusCode;

  SignUpModel({this.message, this.data, this.statusCode});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  String? referenceId;

  Data({this.referenceId});

  Data.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referenceId'] = referenceId;
    return data;
  }
}

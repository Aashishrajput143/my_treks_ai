class ForgetPasswordModel {
  String? message;
  Null? data;
  int? statusCode;

  ForgetPasswordModel({this.message, this.data, this.statusCode});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['data'] = this.data;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

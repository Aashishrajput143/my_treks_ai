class NeedAssistanceModel {
  String? message;
  Data? data;
  int? statusCode;

  NeedAssistanceModel({this.message, this.data, this.statusCode});

  NeedAssistanceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? requestId;
  String? issueType;
  String? status;
  String? createdAt;

  Data({this.requestId, this.issueType, this.status, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    issueType = json['issueType'];
    status = json['status'];
    createdAt = json['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['issueType'] = this.issueType;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

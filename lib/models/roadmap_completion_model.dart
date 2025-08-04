class RoadMapCompletionModel {
  String? message;
  Data? data;
  int? statusCode;

  RoadMapCompletionModel({this.message, this.data, this.statusCode});

  RoadMapCompletionModel.fromJson(Map<String, dynamic> json) {
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
  int? percentage;
  int? totalSteps;
  int? completedSteps;

  Data({this.percentage, this.totalSteps, this.completedSteps});

  Data.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    totalSteps = json['totalSteps'];
    completedSteps = json['completedSteps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentage'] = this.percentage;
    data['totalSteps'] = this.totalSteps;
    data['completedSteps'] = this.completedSteps;
    return data;
  }
}
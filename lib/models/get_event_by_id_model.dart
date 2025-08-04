class GetEventByIdModel {
  String? message;
  Data? data;
  int? statusCode;

  GetEventByIdModel({this.message, this.data, this.statusCode});

  GetEventByIdModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? createdAt;
  String? updatedAt;
  String? eventName;
  String? eventDescription;
  String? speakerName;
  String? speakerPicture;
  String? speakerSummary;
  String? speakerDetails;
  String? sessionStartDate;
  String? sessionEndDate;
  String? sessionStartTime;
  String? sessionEndTime;
  String? status;
  String? sessionDetails;
  String? zoomLink;
  String? eventType;
  int? coins;

  Data(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.eventName,
        this.eventDescription,
        this.speakerName,
        this.speakerPicture,
        this.speakerSummary,
        this.speakerDetails,
        this.sessionStartDate,
        this.sessionEndDate,
        this.sessionStartTime,
        this.sessionEndTime,
        this.status,
        this.sessionDetails,
        this.zoomLink,
        this.eventType,
        this.coins});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    eventName = json['eventName'];
    eventDescription = json['eventDescription'];
    speakerName = json['speakerName'];
    speakerPicture = json['speakerPicture'];
    speakerSummary = json['speakerSummary'];
    speakerDetails = json['speakerDetails'];
    sessionStartDate = json['sessionStartDate'];
    sessionEndDate = json['sessionEndDate'];
    sessionStartTime = json['sessionStartTime'];
    sessionEndTime = json['sessionEndTime'];
    status = json['status'];
    sessionDetails = json['sessionDetails'];
    zoomLink = json['zoomLink'];
    eventType = json['eventType'];
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['eventName'] = this.eventName;
    data['eventDescription'] = this.eventDescription;
    data['speakerName'] = this.speakerName;
    data['speakerPicture'] = this.speakerPicture;
    data['speakerSummary'] = this.speakerSummary;
    data['speakerDetails'] = this.speakerDetails;
    data['sessionStartDate'] = this.sessionStartDate;
    data['sessionEndDate'] = this.sessionEndDate;
    data['sessionStartTime'] = this.sessionStartTime;
    data['sessionEndTime'] = this.sessionEndTime;
    data['status'] = this.status;
    data['sessionDetails'] = this.sessionDetails;
    data['zoomLink'] = this.zoomLink;
    data['eventType'] = this.eventType;
    data['coins'] = this.coins;
    return data;
  }
}
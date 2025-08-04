import 'dart:convert';

GetEventListModel getEventListModelFromJson(String str) => GetEventListModel.fromJson(json.decode(str));

String getEventListModelToJson(GetEventListModel data) => json.encode(data.toJson());

class GetEventListModel {
  final String? message;
  EventData? data;
  final int? statusCode;

  GetEventListModel({
    this.message,
    this.data,
    this.statusCode,
  });

  factory GetEventListModel.fromJson(Map<String, dynamic> json) => GetEventListModel(
        message: json["message"],
        data: json["data"] == null ? null : EventData.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "statusCode": statusCode,
      };
}

class EventData {
  final List<Doc>? docs;
  final bool? hasNextPage;
  final bool? hasPrevPage;
  final int? limit;
  final int? page;
  final int? totalDocs;
  final int? totalPages;

  EventData({
    this.docs,
    this.hasNextPage,
    this.hasPrevPage,
    this.limit,
    this.page,
    this.totalDocs,
    this.totalPages,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
        docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
        limit: json["limit"],
        page: json["page"],
        totalDocs: json["totalDocs"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "docs": docs == null ? [] : List<dynamic>.from(docs!.map((x) => x.toJson())),
        "hasNextPage": hasNextPage,
        "hasPrevPage": hasPrevPage,
        "limit": limit,
        "page": page,
        "totalDocs": totalDocs,
        "totalPages": totalPages,
      };

  EventData copyWith({
    List<Doc>? docs,
    int? totalDocs,
    int? limit,
    int? page,
    int? totalPages,
    bool? hasPrevPage,
    bool? hasNextPage,
  }) {
    return EventData(
      docs: docs ?? this.docs,
      totalDocs: totalDocs ?? this.totalDocs,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      hasPrevPage: hasPrevPage ?? this.hasPrevPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}

class Doc {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? eventName;
  final String? eventDescription;
  final String? speakerName;
  final String? speakerPicture;
  final String? speakerSummary;
  final String? speakerDetails;
  final String? sessionStartDate;
  final String? sessionEndDate;
  final String? sessionStartTime;
  final String? sessionEndTime;
  final String? status;
  final String? sessionDetails;
  final String? zoomLink;
  final String? eventType;
  final int? coins;

  Doc({
    this.id,
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
    this.coins,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        eventName: json["eventName"],
        eventDescription: json["eventDescription"],
        speakerName: json["speakerName"],
        speakerPicture: json["speakerPicture"],
        speakerSummary: json["speakerSummary"],
        speakerDetails: json["speakerDetails"],
        sessionStartDate: json["sessionStartDate"],
        sessionEndDate: json["sessionEndDate"],
        sessionStartTime: json["sessionStartTime"],
        sessionEndTime: json["sessionEndTime"],
        status: json["status"],
        sessionDetails: json["sessionDetails"],
        zoomLink: json["zoomLink"],
        eventType: json["eventType"],
        coins: json["coins"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "eventName": eventName,
        "eventDescription": eventDescription,
        "speakerName": speakerName,
        "speakerPicture": speakerPicture,
        "speakerSummary": speakerSummary,
        "speakerDetails": speakerDetails,
        "sessionStartDate": sessionStartDate,
        "sessionEndDate": sessionEndDate,
        "sessionStartTime": sessionStartTime,
        "sessionEndTime": sessionEndTime,
        "status": status,
        "sessionDetails": sessionDetails,
        "zoomLink": zoomLink,
        "eventType": eventType,
        "coins": coins,
      };
}

import 'dart:convert';

import '../utils/roadmap_enums.dart';

GetUserRoadmapJourneyModel getUserRoadmapJourneyModelFromJson(String str) => GetUserRoadmapJourneyModel.fromJson(json.decode(str));

String getUserRoadmapJourneyModelToJson(GetUserRoadmapJourneyModel data) => json.encode(data.toJson());

class GetUserRoadmapJourneyModel {
  final String? message;
  final List<Datum>? data;
  final int? statusCode;

  GetUserRoadmapJourneyModel({
    this.message,
    this.data,
    this.statusCode,
  });

  factory GetUserRoadmapJourneyModel.fromJson(Map<String, dynamic> json) => GetUserRoadmapJourneyModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class Datum {
  final String? id;
  final String? createdAt;
  final String? name;
  final String? status;
  final List<RoadmapJourney>? roadmapJourneys;

  Datum({
    this.id,
    this.createdAt,
    this.name,
    this.status,
    this.roadmapJourneys,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["createdAt"],
        name: json["name"],
        status: json["status"],
        roadmapJourneys: json["roadmapJourneys"] == null ? [] : List<RoadmapJourney>.from(json["roadmapJourneys"]!.map((x) => RoadmapJourney.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "name": name,
        "status": status,
        "roadmapJourneys": roadmapJourneys == null ? [] : List<dynamic>.from(roadmapJourneys!.map((x) => x.toJson())),
      };
}

class RoadmapJourney {
  final int? completedSteps;
  final String? name;
  final int? totalSteps;
  final String? id;
  final String? assignedDate;
  final List<MetadataTag>? metadataTags;

  RoadmapJourney({
    this.completedSteps,
    this.name,
    this.totalSteps,
    this.id,
    this.assignedDate,
    this.metadataTags,
  });

  factory RoadmapJourney.fromJson(Map<String, dynamic> json) => RoadmapJourney(
        completedSteps: json["completedSteps"],
        name: json["name"],
        totalSteps: json["totalSteps"],
        id: json["id"],
        assignedDate: json["assignedDate"],
        metadataTags: json["metadataTags"] == null ? [] : List<MetadataTag>.from(json["metadataTags"]!.map((x) => MetadataTag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "completedSteps": completedSteps,
        "name": name,
        "totalSteps": totalSteps,
        "id": id,
        "assignedDate": assignedDate,
        "metadataTags": metadataTags == null ? [] : List<dynamic>.from(metadataTags!.map((x) => x.toJson())),
      };
}

class MetadataTag {
  final String? id;
  final String? name;
  final String? type;

  MetadataTag({
    this.id,
    this.name,
    this.type,
  });

  factory MetadataTag.fromJson(Map<String, dynamic> json) => MetadataTag(
        id: json["id"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
      };
}

enum Type { CAREER, INDUSTRY, SOFT_SKILLS, }

final typeValues = EnumValues({"CAREER": Type.CAREER, "INDUSTRY": Type.INDUSTRY, "SOFT SKILLS": Type.SOFT_SKILLS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// class GetUserRoadmapJourneyModel {
//   String? message;
//   List<Data>? data;
//   int? statusCode;

//   GetUserRoadmapJourneyModel({this.message, this.data, this.statusCode});

//   GetUserRoadmapJourneyModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     statusCode = json['statusCode'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['statusCode'] = this.statusCode;
//     return data;
//   }
// }

// class Data {
//   String? id;
//   String? name;
//   String? status;
//   String? user;
//   List<RoadmapJourneys>? roadmapJourneys;

//   Data({this.id, this.name, this.status, this.user, this.roadmapJourneys});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     status = json['status'];
//     user = json['user'];
//     if (json['roadmapJourneys'] != null) {
//       roadmapJourneys = <RoadmapJourneys>[];
//       json['roadmapJourneys'].forEach((v) {
//         roadmapJourneys!.add(new RoadmapJourneys.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['status'] = this.status;
//     data['user'] = this.user;
//     if (this.roadmapJourneys != null) {
//       data['roadmapJourneys'] =
//           this.roadmapJourneys!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class RoadmapJourneys {
//   int? completedSteps;
//   String? name;
//   int? totalSteps;
//   String? id;

//   RoadmapJourneys({this.completedSteps, this.name, this.totalSteps, this.id});

//   RoadmapJourneys.fromJson(Map<String, dynamic> json) {
//     completedSteps = json['completedSteps'];
//     name = json['name'];
//     totalSteps = json['totalSteps'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['completedSteps'] = this.completedSteps;
//     data['name'] = this.name;
//     data['totalSteps'] = this.totalSteps;
//     data['id'] = this.id;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final onBoardingRoadmapJourneyModel = onBoardingRoadmapJourneyModelFromJson(jsonString);

import 'dart:convert';

OnBoardingRoadmapJourneyModel onBoardingRoadmapJourneyModelFromJson(String str) => OnBoardingRoadmapJourneyModel.fromJson(json.decode(str));

String onBoardingRoadmapJourneyModelToJson(OnBoardingRoadmapJourneyModel data) => json.encode(data.toJson());

class OnBoardingRoadmapJourneyModel {
  String? message;
  Data? data;
  int? statusCode;

  OnBoardingRoadmapJourneyModel({
    this.message,
    this.data,
    this.statusCode,
  });

  factory OnBoardingRoadmapJourneyModel.fromJson(Map<String, dynamic> json) => OnBoardingRoadmapJourneyModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "statusCode": statusCode,
      };
}

class Data {
  String? id;
  String? createdAt;
  String? updatedAt;
  int? totalLevels;
  int? levelCompleted;
  dynamic completedAt;
  List<int>? completedSteps;
  List<OnboardingStep>? onboardingSteps;

  Data({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.totalLevels,
    this.levelCompleted,
    this.completedAt,
    this.completedSteps,
    this.onboardingSteps,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        totalLevels: json["totalLevels"],
        levelCompleted: json["levelCompleted"],
        completedAt: json["completedAt"],
        completedSteps: json["completedSteps"] == null ? [] : List<int>.from(json["completedSteps"]!.map((x) => x)),
        onboardingSteps: json["onboardingSteps"] == null ? [] : List<OnboardingStep>.from(json["onboardingSteps"]!.map((x) => OnboardingStep.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "totalLevels": totalLevels,
        "levelCompleted": levelCompleted,
        "completedAt": completedAt,
        "completedSteps": completedSteps == null ? [] : List<dynamic>.from(completedSteps!.map((x) => x)),
        "onboardingSteps": onboardingSteps == null ? [] : List<dynamic>.from(onboardingSteps!.map((x) => x.toJson())),
      };
}

class OnboardingStep {
  String? id;
  String? createdAt;
  String? updatedAt;
  int? sequenceNo;
  String? role;
  String? type;
  dynamic contentType;
  String? contentLink;
  Assessment? assessment;
  String? status;

  OnboardingStep({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.sequenceNo,
    this.role,
    this.type,
    this.contentType,
    this.contentLink,
    this.assessment,
    this.status,
  });

  factory OnboardingStep.fromJson(Map<String, dynamic> json) => OnboardingStep(
        id: json["id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        sequenceNo: json["sequenceNo"],
        role: json["role"],
        type: json["type"],
        contentType: json["contentType"],
        contentLink: json["contentLink"],
        assessment: json["assessment"] == null ? null : Assessment.fromJson(json["assessment"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "sequenceNo": sequenceNo,
        "role": role,
        "type": type,
        "contentType": contentType,
        "contentLink": contentLink,
        "assessment": assessment?.toJson(),
        "status": status,
      };
}

class Assessment {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? role;
  String? assessmentName;
  String? status;
  String? type;

  Assessment({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.assessmentName,
    this.status,
    this.type,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        id: json["id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        role: json["role"],
        assessmentName: json["assessmentName"],
        status: json["status"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "role": role,
        "assessmentName": assessmentName,
        "status": status,
        "type": type,
      };
}

OnBoardingRoadmapJourneyUpdateModel onBoardingRoadmapJourneyUpdateModelFromJson(String str) => OnBoardingRoadmapJourneyUpdateModel.fromJson(json.decode(str));

String onBoardingRoadmapJourneyUpdateModelToJson(OnBoardingRoadmapJourneyUpdateModel data) => json.encode(data.toJson());

class OnBoardingRoadmapJourneyUpdateModel {
  int? statusCode;
  String? message;
  String? extraError;

  OnBoardingRoadmapJourneyUpdateModel({
    this.statusCode,
    this.message,
    this.extraError,
  });

  factory OnBoardingRoadmapJourneyUpdateModel.fromJson(Map<String, dynamic> json) => OnBoardingRoadmapJourneyUpdateModel(
        statusCode: json["statusCode"],
        message: json["message"],
        extraError: json["extraError"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "extraError": extraError,
      };
}

OnBoardingRoadmapJourneyUpdatePostModel onBoardingRoadmapJourneyUpdatePostModelFromJson(String str) => OnBoardingRoadmapJourneyUpdatePostModel.fromJson(json.decode(str));

String onBoardingRoadmapJourneyUpdatePostModelToJson(OnBoardingRoadmapJourneyUpdatePostModel data) => json.encode(data.toJson());

class OnBoardingRoadmapJourneyUpdatePostModel {
  int? id;
  int? levelCompleted;
  int? completedStepId;
  String? gallupResult;
  List<String>? topStrengths;

  OnBoardingRoadmapJourneyUpdatePostModel({
    this.id,
    this.levelCompleted,
    this.completedStepId,
    this.gallupResult,
    this.topStrengths,
  });

  factory OnBoardingRoadmapJourneyUpdatePostModel.fromJson(Map<String, dynamic> json) => OnBoardingRoadmapJourneyUpdatePostModel(
        id: json["id"],
        levelCompleted: json["levelCompleted"],
        completedStepId: json["completedStepId"],
        gallupResult: json["gallupResult"],
        topStrengths: List<String>.from(json["topStrengths"].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      "id": id,
      "levelCompleted": levelCompleted,
      "completedStepId": completedStepId,
    };

    if (gallupResult != null && gallupResult!.isNotEmpty) {
      map["gallupResult"] = gallupResult;
      map["topStrengths"] = List<dynamic>.from(topStrengths!.map((x) => x));
    }
    return map;
  }
}

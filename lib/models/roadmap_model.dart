import 'dart:convert';

RoadmapJourneyModel roadmapJourneyModelFromJson(String str) => RoadmapJourneyModel.fromJson(json.decode(str));

String roadmapJourneyModelToJson(RoadmapJourneyModel data) => json.encode(data.toJson());

class RoadmapJourneyModel {
  final String? message;
  final Data? data;
  final int? statusCode;

  RoadmapJourneyModel({
    this.message,
    this.data,
    this.statusCode,
  });

  factory RoadmapJourneyModel.fromJson(Map<String, dynamic> json) => RoadmapJourneyModel(
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
  final String? id;
  final String? name;
  final String? status;
  final List<MetadataTag>? metadataTags;
  final List<RoadmapStep>? roadmapSteps;

  Data({
    this.id,
    this.name,
    this.status,
    this.metadataTags,
    this.roadmapSteps,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        metadataTags: json["metadataTags"] == null ? [] : List<MetadataTag>.from(json["metadataTags"]!.map((x) => MetadataTag.fromJson(x))),
        roadmapSteps: json["roadmapSteps"] == null ? [] : List<RoadmapStep>.from(json["roadmapSteps"]!.map((x) => RoadmapStep.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "metadataTags": metadataTags == null ? [] : List<dynamic>.from(metadataTags!.map((x) => x.toJson())),
        "roadmapSteps": roadmapSteps == null ? [] : List<dynamic>.from(roadmapSteps!.map((x) => x.toJson())),
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

class RoadmapStep {
  final String? id;
  final int? sequenceNo;
  final String? name;
  final String? time;
  final int? points;
  final Content? content;
  final String? status;

  RoadmapStep({
    this.id,
    this.sequenceNo,
    this.name,
    this.time,
    this.points,
    this.content,
    this.status,
  });

  factory RoadmapStep.fromJson(Map<String, dynamic> json) => RoadmapStep(
        id: json["id"],
        sequenceNo: json["sequenceNo"],
        name: json["name"],
        time: json["time"],
        points: json["points"],
        content: json["content"] == null ? null : Content.fromJson(json["content"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sequenceNo": sequenceNo,
        "name": name,
        "time": time,
        "points": points,
        "content": content?.toJson(),
        "status": status,
      };
}

class Content {
  final String? id;
  final String? name;
  final String? contentType;
  final String? contentLink;
  final String? description;
  final Quiz? quiz;
  final bool? quizEnabled;

  Content({
    this.id,
    this.name,
    this.contentType,
    this.contentLink,
    this.description,
    this.quiz,
    this.quizEnabled,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        contentType: json["contentType"],
        contentLink: json["contentLink"],
        description: json["description"],
        quiz: json["quiz"] == null ? null : Quiz.fromJson(json["quiz"]),
        quizEnabled: json["quizEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contentType": contentType,
        "contentLink": contentLink,
        "description": description,
        "quiz": quiz?.toJson(),
        "quizEnabled": quizEnabled,
      };
}

class Quiz {
  final String? id;
  final String? quizType;

  Quiz({
    this.id,
    this.quizType,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        quizType: json["quizType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quizType": quizType,
      };
}

RoadmapJourneyUpdateModel roadmapJourneyUpdateModelFromJson(String str) => RoadmapJourneyUpdateModel.fromJson(json.decode(str));

String roadmapJourneyUpdateModelToJson(RoadmapJourneyUpdateModel data) => json.encode(data.toJson());

class RoadmapJourneyUpdateModel {
  final int? roadmapJourneyId;
  final int? roadmapStepId;
  final String? assignmentAnswer;
  final String? articleWriteup;
  final String? assignmentAnswerLink;

  RoadmapJourneyUpdateModel({
    this.roadmapJourneyId,
    this.roadmapStepId,
    this.assignmentAnswer,
    this.articleWriteup,
    this.assignmentAnswerLink
  });

  factory RoadmapJourneyUpdateModel.fromJson(Map<String, dynamic> json) => RoadmapJourneyUpdateModel(
        roadmapJourneyId: json["roadmapJourneyId"] != null ? int.tryParse(json["roadmapJourneyId"].toString()) : null,
        roadmapStepId: json["roadmapStepId"] != null ? int.tryParse(json["roadmapStepId"].toString()) : null,
        assignmentAnswer: json["assignmentAnswer"],
        assignmentAnswerLink: json["assignmentAnswerLink"],
        articleWriteup: json["articleWriteup"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      "roadmapJourneyId": roadmapJourneyId,
      "roadmapStepId": roadmapStepId,
    };

    if (assignmentAnswer != null && assignmentAnswer!.isNotEmpty) {
      map["assignmentAnswer"] = assignmentAnswer;
    }

    if (assignmentAnswerLink != null && assignmentAnswerLink!.isNotEmpty) {
      map["assignmentAnswerLink"] = assignmentAnswerLink;
    }

    if (articleWriteup != null && articleWriteup!.isNotEmpty) {
      map["articleWriteup"] = articleWriteup;
    }

    return map;
  }
}

RoadmapJourneyUpdateResponseModel roadmapJourneyUpdateResposeModelFromJson(String str) => RoadmapJourneyUpdateResponseModel.fromJson(json.decode(str));

String roadmapJourneyUpdateResponseModelToJson(RoadmapJourneyUpdateResponseModel data) => json.encode(data.toJson());

class RoadmapJourneyUpdateResponseModel {
  final String? message;
  final dynamic data;
  final int? statusCode;

  RoadmapJourneyUpdateResponseModel({
    this.message,
    this.data,
    this.statusCode,
  });

  factory RoadmapJourneyUpdateResponseModel.fromJson(Map<String, dynamic> json) => RoadmapJourneyUpdateResponseModel(
        message: json["message"],
        data: json["data"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
        "statusCode": statusCode,
      };
}

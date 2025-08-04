class GetAllRoadMapModel {
  String? message;
  Data? data;
  int? statusCode;

  GetAllRoadMapModel({this.message, this.data, this.statusCode});

  GetAllRoadMapModel.fromJson(Map<String, dynamic> json) {
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
  List<Docs>? docs;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  int? page;
  int? totalDocs;
  int? totalPages;

  Data(
      {this.docs,
        this.hasNextPage,
        this.hasPrevPage,
        this.limit,
        this.page,
        this.totalDocs,
        this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
    limit = json['limit'];
    page = json['page'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalDocs'] = this.totalDocs;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Docs {
  String? id;
  String? name;
  String? status;
  List<RoadmapSteps>? roadmapSteps;
  List<MetadataTags>? metadataTags;
  int? totalSteps;
  dynamic completedSteps;
  String? completionStatus;
  String? assignedDate;

  Docs(
      {this.id,
        this.name,
        this.status,
        this.roadmapSteps,
        this.metadataTags,
        this.totalSteps,
        this.completedSteps,
        this.completionStatus,
        this.assignedDate});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    if (json['roadmapSteps'] != null) {
      roadmapSteps = <RoadmapSteps>[];
      json['roadmapSteps'].forEach((v) {
        roadmapSteps!.add(new RoadmapSteps.fromJson(v));
      });
    }
    if (json['metadataTags'] != null) {
      metadataTags = <MetadataTags>[];
      json['metadataTags'].forEach((v) {
        metadataTags!.add(new MetadataTags.fromJson(v));
      });
    }
    totalSteps = json['totalSteps'];
    completedSteps = json['completedSteps'];
    completionStatus = json['completionStatus'];
    assignedDate = json['assignedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    if (this.roadmapSteps != null) {
      data['roadmapSteps'] = this.roadmapSteps!.map((v) => v.toJson()).toList();
    }
    if (this.metadataTags != null) {
      data['metadataTags'] = this.metadataTags!.map((v) => v.toJson()).toList();
    }
    data['totalSteps'] = this.totalSteps;
    data['completedSteps'] = this.completedSteps;
    data['completionStatus'] = this.completionStatus;
    data['assignedDate'] = this.assignedDate;
    return data;
  }
}

class RoadmapSteps {
  String? id;
  int? sequenceNo;
  String? name;
  String? time;
  int? points;

  RoadmapSteps({this.id, this.sequenceNo, this.name, this.time, this.points});

  RoadmapSteps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sequenceNo = json['sequenceNo'];
    name = json['name'];
    time = json['time'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sequenceNo'] = this.sequenceNo;
    data['name'] = this.name;
    data['time'] = this.time;
    data['points'] = this.points;
    return data;
  }
}

class MetadataTags {
  String? id;
  String? name;
  String? type;

  MetadataTags({this.id, this.name, this.type});

  MetadataTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

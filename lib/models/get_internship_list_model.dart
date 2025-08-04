class GetInternshipListModel {
  String? message;
  Data? data;
  int? statusCode;

  GetInternshipListModel({this.message, this.data, this.statusCode});

  GetInternshipListModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  String? internshipSummary;
  String? jobDescription;
  String? eligibility;
  int? noOfInternship;
  String? location;
  String? stipend;
  String? duration;
  List<String>? skills;
  String? companyName;
  String? companyLogo;
  int? noOfEmployee;
  String? companyEmail;
  String? companyIndustry;
  int? companyTeamSize;
  String? status;

  Docs(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.description,
        this.internshipSummary,
        this.jobDescription,
        this.eligibility,
        this.noOfInternship,
        this.location,
        this.stipend,
        this.duration,
        this.skills,
        this.companyName,
        this.companyLogo,
        this.noOfEmployee,
        this.companyEmail,
        this.companyIndustry,
        this.companyTeamSize,
        this.status});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    title = json['title'];
    description = json['description'];
    internshipSummary = json['internshipSummary'];
    jobDescription = json['jobDescription'];
    eligibility = json['eligibility'];
    noOfInternship = json['noOfInternship'];
    location = json['location'];
    stipend = json['stipend'];
    duration = json['duration'];
    skills = json['skills'].cast<String>();
    companyName = json['companyName'];
    companyLogo = json['companyLogo'];
    noOfEmployee = json['noOfEmployee'];
    companyEmail = json['companyEmail'];
    companyIndustry = json['companyIndustry'];
    companyTeamSize = json['companyTeamSize'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['title'] = this.title;
    data['description'] = this.description;
    data['internshipSummary'] = this.internshipSummary;
    data['jobDescription'] = this.jobDescription;
    data['eligibility'] = this.eligibility;
    data['noOfInternship'] = this.noOfInternship;
    data['location'] = this.location;
    data['stipend'] = this.stipend;
    data['duration'] = this.duration;
    data['skills'] = this.skills;
    data['companyName'] = this.companyName;
    data['companyLogo'] = this.companyLogo;
    data['noOfEmployee'] = this.noOfEmployee;
    data['companyEmail'] = this.companyEmail;
    data['companyIndustry'] = this.companyIndustry;
    data['companyTeamSize'] = this.companyTeamSize;
    data['status'] = this.status;
    return data;
  }
}
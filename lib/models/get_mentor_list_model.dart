class GetMentorListModel {
  String? message;
  Data? data;
  int? statusCode;

  GetMentorListModel({this.message, this.data, this.statusCode});

  GetMentorListModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? designation;
  String? currentCompany;
  int? totalExperience;
  List<String>? skills;
  String? avatar;

  Docs(
      {this.id,
        this.firstName,
        this.lastName,
        this.designation,
        this.currentCompany,
        this.totalExperience,
        this.skills,
        this.avatar});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    designation = json['designation'];
    currentCompany = json['currentCompany'];
    totalExperience = json['totalExperience'];
    skills = json['skills'].cast<String>();
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['designation'] = this.designation;
    data['currentCompany'] = this.currentCompany;
    data['totalExperience'] = this.totalExperience;
    data['skills'] = this.skills;
    data['avatar'] = this.avatar;
    return data;
  }
}
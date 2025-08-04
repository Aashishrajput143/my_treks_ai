class GetInternshipDetailModel {
  String? message;
  Data? data;
  int? statusCode;

  GetInternshipDetailModel({this.message, this.data, this.statusCode});

  GetInternshipDetailModel.fromJson(Map<String, dynamic> json) {
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
  bool? isExpressInterest;

  Data(
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
        this.status,
        this.isExpressInterest});

  Data.fromJson(Map<String, dynamic> json) {
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
    isExpressInterest = json['isExpressInterest'];
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
    data['isExpressInterest'] = this.isExpressInterest;
    return data;
  }
}
class BookSessionModel {
  String? message;
  Data? data;
  int? statusCode;

  BookSessionModel({this.message, this.data, this.statusCode});

  BookSessionModel.fromJson(Map<String, dynamic> json) {
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
  Mentor? mentor;
  User? user;
  String? meetingTime;
  String? sessionAgenda;
  String? careerPath;
  int? createdAt;
  int? updatedAt;
  String? id;

  Data(
      {this.mentor,
        this.user,
        this.meetingTime,
        this.sessionAgenda,
        this.careerPath,
        this.createdAt,
        this.updatedAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    mentor =
    json['mentor'] != null ? new Mentor.fromJson(json['mentor']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    meetingTime = json['meetingTime'];
    sessionAgenda = json['sessionAgenda'];
    careerPath = json['careerPath'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mentor != null) {
      data['mentor'] = this.mentor!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['meetingTime'] = this.meetingTime;
    data['sessionAgenda'] = this.sessionAgenda;
    data['careerPath'] = this.careerPath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Mentor {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? countryCode;
  String? avatar;
  String? coverImage;
  String? password;
  String? status;
  String? verifyStatus;
  String? relationWithGuardian;
  String? role;
  String? group;
  String? birthDate;
  String? grade;
  String? gender;
  String? loginSource;
  String? stripeCustomerId;
  String? skills;
  String? topics;
  String? careerSummary;
  String? achievements;
  String? industry;
  String? career;
  String? designation;
  String? professionalBackground;
  String? academicBackground;
  String? otherSkills;

  Mentor(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.avatar,
        this.coverImage,
        this.password,
        this.status,
        this.verifyStatus,
        this.relationWithGuardian,
        this.role,
        this.group,
        this.birthDate,
        this.grade,
        this.gender,
        this.loginSource,
        this.stripeCustomerId,
        this.skills,
        this.topics,
        this.careerSummary,
        this.achievements,
        this.industry,
        this.career,
        this.designation,
        this.professionalBackground,
        this.academicBackground,
        this.otherSkills});

  Mentor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    countryCode = json['countryCode'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    password = json['password'];
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    relationWithGuardian = json['relationWithGuardian'];
    role = json['role'];
    group = json['group'];
    birthDate = json['birthDate'];
    grade = json['grade'];
    gender = json['gender'];
    loginSource = json['loginSource'];
    stripeCustomerId = json['stripeCustomerId'];
    skills = json['skills'];
    topics = json['topics'];
    careerSummary = json['careerSummary'];
    achievements = json['achievements'];
    industry = json['industry'];
    career = json['career'];
    designation = json['designation'];
    professionalBackground = json['professionalBackground'];
    academicBackground = json['academicBackground'];
    otherSkills = json['otherSkills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['countryCode'] = this.countryCode;
    data['avatar'] = this.avatar;
    data['coverImage'] = this.coverImage;
    data['password'] = this.password;
    data['status'] = this.status;
    data['verifyStatus'] = this.verifyStatus;
    data['relationWithGuardian'] = this.relationWithGuardian;
    data['role'] = this.role;
    data['group'] = this.group;
    data['birthDate'] = this.birthDate;
    data['grade'] = this.grade;
    data['gender'] = this.gender;
    data['loginSource'] = this.loginSource;
    data['stripeCustomerId'] = this.stripeCustomerId;
    data['skills'] = this.skills;
    data['topics'] = this.topics;
    data['careerSummary'] = this.careerSummary;
    data['achievements'] = this.achievements;
    data['industry'] = this.industry;
    data['career'] = this.career;
    data['designation'] = this.designation;
    data['professionalBackground'] = this.professionalBackground;
    data['academicBackground'] = this.academicBackground;
    data['otherSkills'] = this.otherSkills;
    return data;
  }
}

class User {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? countryCode;
  String? avatar;
  String? coverImage;
  String? password;
  String? status;
  String? verifyStatus;
  String? relationWithGuardian;
  String? role;
  String? group;
  String? birthDate;
  String? grade;
  String? gender;
  String? loginSource;
  String? stripeCustomerId;
  String? skills;
  String? topics;
  String? careerSummary;
  String? achievements;
  String? industry;
  String? career;
  String? designation;
  String? professionalBackground;
  String? academicBackground;
  String? otherSkills;

  User(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.avatar,
        this.coverImage,
        this.password,
        this.status,
        this.verifyStatus,
        this.relationWithGuardian,
        this.role,
        this.group,
        this.birthDate,
        this.grade,
        this.gender,
        this.loginSource,
        this.stripeCustomerId,
        this.skills,
        this.topics,
        this.careerSummary,
        this.achievements,
        this.industry,
        this.career,
        this.designation,
        this.professionalBackground,
        this.academicBackground,
        this.otherSkills});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    countryCode = json['countryCode'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    password = json['password'];
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    relationWithGuardian = json['relationWithGuardian'];
    role = json['role'];
    group = json['group'];
    birthDate = json['birthDate'];
    grade = json['grade'];
    gender = json['gender'];
    loginSource = json['loginSource'];
    stripeCustomerId = json['stripeCustomerId'];
    skills = json['skills'];
    topics = json['topics'];
    careerSummary = json['careerSummary'];
    achievements = json['achievements'];
    industry = json['industry'];
    career = json['career'];
    designation = json['designation'];
    professionalBackground = json['professionalBackground'];
    academicBackground = json['academicBackground'];
    otherSkills = json['otherSkills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['countryCode'] = this.countryCode;
    data['avatar'] = this.avatar;
    data['coverImage'] = this.coverImage;
    data['password'] = this.password;
    data['status'] = this.status;
    data['verifyStatus'] = this.verifyStatus;
    data['relationWithGuardian'] = this.relationWithGuardian;
    data['role'] = this.role;
    data['group'] = this.group;
    data['birthDate'] = this.birthDate;
    data['grade'] = this.grade;
    data['gender'] = this.gender;
    data['loginSource'] = this.loginSource;
    data['stripeCustomerId'] = this.stripeCustomerId;
    data['skills'] = this.skills;
    data['topics'] = this.topics;
    data['careerSummary'] = this.careerSummary;
    data['achievements'] = this.achievements;
    data['industry'] = this.industry;
    data['career'] = this.career;
    data['designation'] = this.designation;
    data['professionalBackground'] = this.professionalBackground;
    data['academicBackground'] = this.academicBackground;
    data['otherSkills'] = this.otherSkills;
    return data;
  }
}
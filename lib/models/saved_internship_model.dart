class SavedInternshipModel {
  String? message;
  Data? data;
  int? statusCode;

  SavedInternshipModel({this.message, this.data, this.statusCode});

  SavedInternshipModel.fromJson(Map<String, dynamic> json) {
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
  UserInterest? userInterest;

  Data({this.userInterest});

  Data.fromJson(Map<String, dynamic> json) {
    userInterest = json['userInterest'] != null
        ? new UserInterest.fromJson(json['userInterest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInterest != null) {
      data['userInterest'] = this.userInterest!.toJson();
    }
    return data;
  }
}

class UserInterest {
  User? user;
  Internship? internship;
  String? status;
  int? createdAt;
  int? updatedAt;
  String? id;

  UserInterest(
      {this.user,
        this.internship,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.id});

  UserInterest.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    internship = json['internship'] != null
        ? new Internship.fromJson(json['internship'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.internship != null) {
      data['internship'] = this.internship!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class User {
  String? id;

  User({this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Internship {
  int? id;

  Internship({this.id});

  Internship.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
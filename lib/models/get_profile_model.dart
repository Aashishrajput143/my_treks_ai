class GetProfileModel {
  String? message;
  Data? data;
  int? statusCode;

  GetProfileModel({this.message, this.data, this.statusCode});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  String? avatar;
  dynamic birthDate;
  String? countryCode;
  String? email;
  dynamic grade;
  String? group;
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  dynamic guardian;

  Data({this.avatar, this.birthDate, this.countryCode, this.email, this.grade, this.group, this.id, this.firstName, this.lastName, this.phoneNo, this.guardian});

  Data.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    birthDate = json['birthDate'];
    countryCode = json['countryCode'];
    email = json['email'];
    grade = json['grade'];
    group = json['group'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNo = json['phoneNo'];
    guardian = json['guardian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['birthDate'] = birthDate;
    data['countryCode'] = countryCode;
    data['email'] = email;
    data['grade'] = grade;
    data['group'] = group;
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNo'] = phoneNo;
    data['guardian'] = guardian;
    return data;
  }
}

class GetMentorDetailsModel {
  String? message;
  Data? data;
  int? statusCode;

  GetMentorDetailsModel({this.message, this.data, this.statusCode});

  GetMentorDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? title;
  String? experience;
  List<Education>? education;
  List<String>? topSkills;
  String? description;
  Contact? contact;
  List<ProfessionalBackground>? professionalBackground;
  Skills? skills;
  List<String>? interests;
  String? summary;
  String? avatar;
  RawData? rawData;

  Data(
      {this.name,
        this.title,
        this.experience,
        this.education,
        this.topSkills,
        this.description,
        this.contact,
        this.professionalBackground,
        this.skills,
        this.interests,
        this.summary,
        this.avatar,
        this.rawData});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    experience = json['experience'];
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    topSkills = json['topSkills'].cast<String>();
    description = json['description'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    if (json['professionalBackground'] != null) {
      professionalBackground = <ProfessionalBackground>[];
      json['professionalBackground'].forEach((v) {
        professionalBackground!.add(new ProfessionalBackground.fromJson(v));
      });
    }
    skills =
    json['skills'] != null ? new Skills.fromJson(json['skills']) : null;
    interests = json['interests'].cast<String>();
    summary = json['summary'];
    avatar = json['avatar'];
    rawData =
    json['rawData'] != null ? new RawData.fromJson(json['rawData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['experience'] = this.experience;
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    data['topSkills'] = this.topSkills;
    data['description'] = this.description;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.professionalBackground != null) {
      data['professionalBackground'] =
          this.professionalBackground!.map((v) => v.toJson()).toList();
    }
    if (this.skills != null) {
      data['skills'] = this.skills!.toJson();
    }
    data['interests'] = this.interests;
    data['summary'] = this.summary;
    data['avatar'] = this.avatar;
    if (this.rawData != null) {
      data['rawData'] = this.rawData!.toJson();
    }
    return data;
  }
}

class Education {
  String? degree;
  String? institution;
  String? year;
  String? fieldOfStudy;

  Education({this.degree, this.institution, this.year, this.fieldOfStudy});

  Education.fromJson(Map<String, dynamic> json) {
    degree = json['degree'];
    institution = json['institution'];
    year = json['year'];
    fieldOfStudy = json['fieldOfStudy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['degree'] = this.degree;
    data['institution'] = this.institution;
    data['year'] = this.year;
    data['fieldOfStudy'] = this.fieldOfStudy;
    return data;
  }
}

class Contact {
  String? email;
  String? phone;

  Contact({this.email, this.phone});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class ProfessionalBackground {
  String? position;
  String? company;
  String? location;
  String? period;
  String? description;

  ProfessionalBackground(
      {this.position,
        this.company,
        this.location,
        this.period,
        this.description});

  ProfessionalBackground.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    company = json['company'];
    location = json['location'];
    period = json['period'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['company'] = this.company;
    data['location'] = this.location;
    data['period'] = this.period;
    data['description'] = this.description;
    return data;
  }
}

class Skills {
  List<String>? primary;
  dynamic? leadership;
  List<String>? other;

  Skills({this.primary, this.leadership, this.other});

  Skills.fromJson(Map<String, dynamic> json) {
    primary = json['primary'].cast<String>();
    if (json['leadership'] != null) {
      leadership = <String>[];
      json['leadership'].forEach((v) {
        //leadership!.add(new Null.fromJson(v));
      });
    }
    other = json['other'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    if (this.leadership != null) {
      data['leadership'] = this.leadership!.map((v) => v.toJson()).toList();
    }
    data['other'] = this.other;
    return data;
  }
}

class RawData {
  String? id;
  String? createdAt;
  String? gender;
  String? birthDate;
  String? achievements;
  String? industry;
  String? career;
  String? coverImage;

  RawData(
      {this.id,
        this.createdAt,
        this.gender,
        this.birthDate,
        this.achievements,
        this.industry,
        this.career,
        this.coverImage});

  RawData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    achievements = json['achievements'];
    industry = json['industry'];
    career = json['career'];
    coverImage = json['coverImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['achievements'] = this.achievements;
    data['industry'] = this.industry;
    data['career'] = this.career;
    data['coverImage'] = this.coverImage;
    return data;
  }
}
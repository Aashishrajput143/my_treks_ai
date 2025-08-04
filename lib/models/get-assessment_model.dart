class GetAssessmentModel {
  String? message;
  Data? data;
  int? statusCode;

  GetAssessmentModel({this.message, this.data, this.statusCode});

  GetAssessmentModel.fromJson(Map<String, dynamic> json) {
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
  String? role;
  String? assessmentName;
  String? status;
  String? type;
  List<Questions>? questions;

  Data(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.assessmentName,
        this.status,
        this.type,
        this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    role = json['role'];
    assessmentName = json['assessmentName'];
    status = json['status'];
    type = json['type'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['role'] = this.role;
    data['assessmentName'] = this.assessmentName;
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? questionText;
  String? questionType;
  Null? subText;
  List<Options>? options;

  Questions(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.questionText,
        this.questionType,
        this.subText,
        this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    questionText = json['questionText'];
    questionType = json['questionType'];
    subText = json['subText'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['questionText'] = this.questionText;
    data['questionType'] = this.questionType;
    data['subText'] = this.subText;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? optionText;
  bool? isCorrect;

  Options(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.optionText,
        this.isCorrect});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    optionText = json['optionText'];
    isCorrect = json['isCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['optionText'] = this.optionText;
    data['isCorrect'] = this.isCorrect;
    return data;
  }
}

class GetQuizModel {
  String? message;
  Data? data;
  int? statusCode;

  GetQuizModel({this.message, this.data, this.statusCode});

  GetQuizModel.fromJson(Map<String, dynamic> json) {
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
  String? quizType;
  List<QuizQuestions>? quizQuestions;

  Data(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.quizType,
        this.quizQuestions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    quizType = json['quizType'];
    if (json['quizQuestions'] != null) {
      quizQuestions = <QuizQuestions>[];
      json['quizQuestions'].forEach((v) {
        quizQuestions!.add(new QuizQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['quizType'] = this.quizType;
    if (this.quizQuestions != null) {
      data['quizQuestions'] =
          this.quizQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizQuestions {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? questionText;
  String? questionType;
  String? subText;
  List<Options>? options;

  QuizQuestions(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.questionText,
        this.questionType,
        this.subText,
        this.options});

  QuizQuestions.fromJson(Map<String, dynamic> json) {
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

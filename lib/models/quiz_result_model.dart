class QuizResultModel {
  String? message;
  Data? data;
  int? statusCode;

  QuizResultModel({this.message, this.data, this.statusCode});

  QuizResultModel.fromJson(Map<String, dynamic> json) {
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
  List<QuizResult>? quizResult;

  Data({this.quizResult});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['quizResult'] != null) {
      quizResult = <QuizResult>[];
      json['quizResult'].forEach((v) {
        quizResult!.add(new QuizResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quizResult != null) {
      data['quizResult'] = this.quizResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizResult {
  String? questionText;
  String? answerText;
  String? questionType;
  String? id;
  List<SelectedOptions>? selectedOptions;

  QuizResult(
      {this.questionText,
        this.answerText,
        this.questionType,
        this.id,
        this.selectedOptions});

  QuizResult.fromJson(Map<String, dynamic> json) {
    questionText = json['questionText'];
    answerText = json['answerText'];
    questionType = json['questionType'];
    id = json['id'];
    if (json['selectedOptions'] != null) {
      selectedOptions = <SelectedOptions>[];
      json['selectedOptions'].forEach((v) {
        selectedOptions!.add(new SelectedOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionText'] = this.questionText;
    data['answerText'] = this.answerText;
    data['questionType'] = this.questionType;
    data['id'] = this.id;
    if (this.selectedOptions != null) {
      data['selectedOptions'] =
          this.selectedOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelectedOptions {
  String? optionText;
  String? id;
  bool? isCorrect;
  bool? isSelected;

  SelectedOptions({this.optionText, this.id, this.isCorrect, this.isSelected});

  SelectedOptions.fromJson(Map<String, dynamic> json) {
    optionText = json['optionText'];
    id = json['id'];
    isCorrect = json['isCorrect'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionText'] = this.optionText;
    data['id'] = this.id;
    data['isCorrect'] = this.isCorrect;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

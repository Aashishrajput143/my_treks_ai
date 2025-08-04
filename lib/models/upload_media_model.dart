class UploadMediaModel {
  String? message;
  Data? data;
  int? statusCode;

  UploadMediaModel({this.message, this.data, this.statusCode});

  UploadMediaModel.fromJson(Map<String, dynamic> json) {
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
  String? filePath;
  String? fileName;

  Data({this.filePath, this.fileName});

  Data.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filePath'] = filePath;
    data['fileName'] = fileName;
    return data;
  }
}

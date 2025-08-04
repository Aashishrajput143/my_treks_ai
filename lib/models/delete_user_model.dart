import 'dart:convert';

DeleteUser deleteUserFromJson(String str) => DeleteUser.fromJson(json.decode(str));

String deleteUserToJson(DeleteUser data) => json.encode(data.toJson());

class DeleteUser {
  final String? message;
  final dynamic data;
  final int? statusCode;

  DeleteUser({
    this.message,
    this.data,
    this.statusCode,
  });

  factory DeleteUser.fromJson(Map<String, dynamic> json) => DeleteUser(
        message: json["message"],
        data: json["data"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
        "statusCode": statusCode,
      };
}

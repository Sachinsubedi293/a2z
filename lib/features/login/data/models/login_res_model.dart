import 'package:hive_flutter/hive_flutter.dart';

part 'login_res_model.g.dart';

@HiveType(typeId: 0)
class LoginResModel {
  @HiveField(0)
  final String? accessToken;
  @HiveField(1)
  final String? refreshToken;

  LoginResModel({required this.accessToken, required this.refreshToken});

  factory LoginResModel.fromJson(Map<String, dynamic> json) {
    return LoginResModel(
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

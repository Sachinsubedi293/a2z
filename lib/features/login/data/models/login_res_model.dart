import 'package:hive/hive.dart';

part 'login_res_model.g.dart';


@HiveType(typeId: 0)
class LoginResModel {
  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final String refreshToken;

  LoginResModel({required this.accessToken, required this.refreshToken});

  factory LoginResModel.fromJson(Map<String, dynamic> json) {
    return LoginResModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

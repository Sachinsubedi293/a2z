import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtHandle {
  static Future<String?> getAccessToken() async {
    final box = await Hive.openBox('loginBox');
    return box.get('accessToken') as String?;
  }

  static Future<bool> isAccessTokenExpired() async {
    final token = await getAccessToken();
    if (token == null) return true; 
    return JwtDecoder.isExpired(token);
  }
}

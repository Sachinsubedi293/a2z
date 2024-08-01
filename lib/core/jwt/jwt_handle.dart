import 'package:flutter/foundation.dart';
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

  static Future<Map<String, dynamic>?> decodeAccessToken() async {
    final token = await getAccessToken();
    if (token == null) return null;
    
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      if (kDebugMode) {
        print("Token Decode Error: $e");
      }
      return null;
    }
  }

  static Future<String?> getClaim(String claimKey) async {
    final decodedToken = await decodeAccessToken();
    return decodedToken?[claimKey];
  }
}

import 'package:a2zjewelry/features/login/domain/entities/login_entity.dart';
import 'package:flutter/material.dart';

abstract class LoginRepository {
  Future<void> loginUser(LoginEntity entity,BuildContext context);
}

import 'package:a2zjewelry/features/forgot_password/domain/entities/forgot_entity.dart';
import 'package:flutter/material.dart';

abstract class ForgotRepository {
  Future<void> forgotUser(ForgotEntity entity,BuildContext context);
}

import 'package:a2zjewelry/features/register/domain/entities/register_entity.dart';
import 'package:flutter/material.dart';

abstract class RegisterRepository {
  Future<void> registerUser(RegisterEntity entity,BuildContext context);
}

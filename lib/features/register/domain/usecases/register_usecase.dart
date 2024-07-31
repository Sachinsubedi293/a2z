import 'package:a2zjewelry/features/register/domain/entities/register_entity.dart';
import 'package:a2zjewelry/features/register/domain/repositories/regiater_repo.dart';
import 'package:flutter/material.dart';

class RegisterUserUseCase {
  final RegisterRepository repository;

  RegisterUserUseCase(this.repository);

  Future<void> call(RegisterEntity entity,BuildContext context) async {
    return await repository.registerUser(entity,context);
  }
}

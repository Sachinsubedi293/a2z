import 'package:a2zjewelry/features/login/domain/entities/login_entity.dart';
import 'package:a2zjewelry/features/login/domain/repositories/login_repo.dart';
import 'package:flutter/material.dart';

class LoginUserUseCase {
  final LoginRepository repository;

  LoginUserUseCase(this.repository);

  Future<void> call(LoginEntity entity,BuildContext context) async {
    return await repository.loginUser(entity,context);
  }
}

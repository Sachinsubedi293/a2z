import 'package:a2zjewelry/features/forgot_password/domain/entities/forgot_entity.dart';
import 'package:a2zjewelry/features/forgot_password/domain/repositories/forgot_repo.dart';
import 'package:flutter/material.dart';

class ForgotUserUseCase {
  final ForgotRepository repository;

  ForgotUserUseCase(this.repository);

  Future<void> call(ForgotEntity entity,BuildContext context) async {
    return await repository.forgotUser(entity,context);
  }
}

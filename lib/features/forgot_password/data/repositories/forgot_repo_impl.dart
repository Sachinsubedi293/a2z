import 'package:a2zjewelry/features/forgot_password/data/datasources/forgot_remote.dart';
import 'package:a2zjewelry/features/forgot_password/data/models/forgot_model.dart';
import 'package:a2zjewelry/features/forgot_password/domain/entities/forgot_entity.dart';
import 'package:a2zjewelry/features/forgot_password/domain/repositories/forgot_repo.dart';
import 'package:flutter/material.dart';

class ForgotRepositoryImpl implements ForgotRepository {
  final ForgotRemote remoteDataSource;

  ForgotRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> forgotUser(ForgotEntity entity,BuildContext context) async {
    final model = ForgotModel(
      email: entity.email,
    );
    await remoteDataSource.forgotRemoteUser(model,context);
  }
}

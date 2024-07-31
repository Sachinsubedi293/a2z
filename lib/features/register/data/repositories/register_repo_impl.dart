import 'package:a2zjewelry/features/register/data/datasources/register_remote.dart';
import 'package:a2zjewelry/features/register/data/models/register_model.dart';
import 'package:a2zjewelry/features/register/domain/entities/register_entity.dart';
import 'package:a2zjewelry/features/register/domain/repositories/regiater_repo.dart';
import 'package:flutter/material.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;

  RegisterRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> registerUser(RegisterEntity entity,BuildContext context) async {
    final model = RegisterModel(
      email: entity.email,
      password: entity.password,
      allowMail: entity.allowMail,
    );
    await remoteDataSource.registerUser(model,context);
  }
}

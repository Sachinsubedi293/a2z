import 'package:a2zjewelry/features/login/data/datasources/login_remote.dart';
import 'package:a2zjewelry/features/login/data/models/login_model.dart';
import 'package:a2zjewelry/features/login/domain/entities/login_entity.dart';
import 'package:a2zjewelry/features/login/domain/repositories/login_repo.dart';
import 'package:flutter/material.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemote remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> loginUser(LoginEntity entity,BuildContext context) async {
    final model = LoginModel(
      email: entity.email,
      password:entity.password
    );
   return await remoteDataSource.loginRemoteUser(model,context);
  }
}

import 'dart:io';

import 'package:a2zjewelry/features/profile/data/datasources/profile_remote.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_model.dart';
import 'package:a2zjewelry/features/profile/domain/entities/profile_entity.dart';
import 'package:a2zjewelry/features/profile/domain/repositories/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemote remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> updateUser(ProfileEntity entity, File? avatarFile) async {
    final model = ProfileModel(
      email: entity.email,
      first_name: entity.first_name,
      last_name: entity.last_name,
      bio: entity.bio,
      avatar: entity.avatar,
    );
    return await remoteDataSource.updateUser(model, avatarFile);
  }
}

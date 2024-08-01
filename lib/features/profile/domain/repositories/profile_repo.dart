import 'dart:io';

import 'package:a2zjewelry/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<void> updateUser(ProfileEntity entity, File? avatarFile);
}

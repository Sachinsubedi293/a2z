import 'dart:io';
import 'package:a2zjewelry/features/profile/domain/entities/profile_entity.dart';
import 'package:a2zjewelry/features/profile/domain/repositories/profile_repo.dart';
class ProfileUserUseCase {
  final ProfileRepository repository;

  ProfileUserUseCase(this.repository);

  Future<void> call(ProfileEntity entity, File? avatarFile) async {
    try {
      // Delegate the call to the repository, which handles the actual update
      await repository.updateUser(entity, avatarFile);
    } catch (e) {
      // Handle or propagate exceptions as needed
      throw Exception('Failed to update user profile: $e');
    }
  }
}

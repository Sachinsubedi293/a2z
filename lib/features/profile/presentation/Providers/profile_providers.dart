import 'dart:io';
import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/profile/data/datasources/profile_local.dart';
import 'package:a2zjewelry/features/profile/data/datasources/profile_remote.dart';
import 'package:a2zjewelry/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:a2zjewelry/features/profile/domain/entities/profile_entity.dart';
import 'package:a2zjewelry/features/profile/domain/usecases/profile_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Profile State
class ProfileState {
  final bool loading;
  final String? error;

  ProfileState({this.loading = false, this.error});

  ProfileState copyWith({bool? loading, String? error}) {
    return ProfileState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

// Profile Notifier
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileUserUseCase profileUserUseCase;
  bool isEditing = false;

  ProfileNotifier(this.profileUserUseCase) : super(ProfileState());

  Future<void> updateUser(ProfileEntity entity, File? avatarFile) async {
    try {
      state = state.copyWith(loading: true);
      await profileUserUseCase.call(entity, avatarFile);
      state = state.copyWith(loading: false, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  void setEditing(bool editing) {
    isEditing = editing;
    state = state.copyWith();
  }
}

// Providers
final dioProvider = Provider<Dio>((ref) {
  return DioClient().createDio();
});

final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  final dataSource = ProfileLocalDataSource();
  dataSource.initHiveBoxes();
  return dataSource;
});

final profileRemoteDataSourceProvider = Provider<ProfileRemote>((ref) {
  final dio = ref.watch(dioProvider);
  final localDataSource = ref.watch(profileLocalDataSourceProvider);
  return ProfileRemote(dio, localDataSource);
});

final profileRepositoryProvider = Provider<ProfileRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRepositoryImpl(remoteDataSource);
});

final profileUserUseCaseProvider = Provider<ProfileUserUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileUserUseCase(repository);
});

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final profileUserUseCase = ref.watch(profileUserUseCaseProvider);
  return ProfileNotifier(profileUserUseCase);
});

final profileImageProvider = StateProvider<File?>((ref) => null);

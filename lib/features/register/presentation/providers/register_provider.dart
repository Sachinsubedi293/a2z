import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/register/data/datasources/register_remote.dart';
import 'package:a2zjewelry/features/register/data/repositories/register_repo_impl.dart';
import 'package:a2zjewelry/features/register/domain/entities/register_entity.dart';
import 'package:a2zjewelry/features/register/domain/usecases/register_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  final bool loading;
  final String? error;

  RegisterState({this.loading = false, this.error});

  RegisterState copyWith({bool? loading, String? error}) {
    return RegisterState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterUserUseCase registerUserUseCase;

  RegisterNotifier(this.registerUserUseCase) : super(RegisterState());

  Future<void> registerUser(RegisterEntity entity,BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      await registerUserUseCase.call(entity,context);
      state = state.copyWith(loading: false, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final registerUserUseCase = ref.watch(registerUserUseCaseProvider);
  return RegisterNotifier(registerUserUseCase);
});

final registerUserUseCaseProvider = Provider<RegisterUserUseCase>((ref) {
  final repository = ref.watch(registerRepositoryProvider);
  return RegisterUserUseCase(repository);
});

final registerRepositoryProvider = Provider<RegisterRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(registerRemoteDataSourceProvider);
  return RegisterRepositoryImpl(remoteDataSource);
});

final registerRemoteDataSourceProvider = Provider<RegisterRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return RegisterRemoteDataSource(dio);
});

final dioProvider = Provider<Dio>((ref) {
  return DioClient().createDio();
});

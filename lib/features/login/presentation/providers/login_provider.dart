import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/login/data/datasources/login_remote.dart';
import 'package:a2zjewelry/features/login/data/repositories/login_repo_impl.dart';
import 'package:a2zjewelry/features/login/domain/entities/login_entity.dart';
import 'package:a2zjewelry/features/login/domain/usecases/login_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool loading;
  final String? error;

  LoginState({this.loading = false, this.error});

  LoginState copyWith({bool? loading, String? error}) {
    return LoginState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUserUseCase loginUserUseCase;

  LoginNotifier(this.loginUserUseCase) : super(LoginState());

  Future<void> loginUser(LoginEntity entity, BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
    await loginUserUseCase.call(entity, context);
      state = state.copyWith(loading: false, error: null);
    
      
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final loginUserUseCase = ref.watch(loginUserUseCaseProvider);
  return LoginNotifier(loginUserUseCase);
});

final loginUserUseCaseProvider = Provider<LoginUserUseCase>((ref) {
  final repository = ref.watch(loginRepositoryProvider);
  return LoginUserUseCase(repository);
});

final loginRepositoryProvider = Provider<LoginRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(loginRemoteDataSourceProvider);
  return LoginRepositoryImpl(remoteDataSource);
});

final loginRemoteDataSourceProvider = Provider<LoginRemote>((ref) {
  final dio = ref.watch(dioProvider);
  return LoginRemote(dio);
});

final dioProvider = Provider<Dio>((ref) {
  return DioClient().createDio();
});

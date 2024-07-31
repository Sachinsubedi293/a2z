import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/forgot_password/data/datasources/forgot_remote.dart';
import 'package:a2zjewelry/features/forgot_password/data/repositories/forgot_repo_impl.dart';
import 'package:a2zjewelry/features/forgot_password/domain/entities/forgot_entity.dart';
import 'package:a2zjewelry/features/forgot_password/domain/usecases/forgot_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotState {
  final bool loading;
  final String? error;

  ForgotState({this.loading = false, this.error});

  ForgotState copyWith({bool? loading, String? error}) {
    return ForgotState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class ForgotNotifier extends StateNotifier<ForgotState> {
  final ForgotUserUseCase forgotUserUseCase;

  ForgotNotifier(this.forgotUserUseCase) : super(ForgotState());

  Future<void> forgotUser(ForgotEntity entity,BuildContext context) async {
    try {
      state = state.copyWith(loading: true);
      await forgotUserUseCase.call(entity,context);
      state = state.copyWith(loading: false, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final forgotProvider = StateNotifierProvider<ForgotNotifier, ForgotState>((ref) {
  final forgotUserUseCase = ref.watch(forgotUserUseCaseProvider);
  return ForgotNotifier(forgotUserUseCase);
});

final forgotUserUseCaseProvider = Provider<ForgotUserUseCase>((ref) {
  final repository = ref.watch(forgotRepositoryProvider);
  return ForgotUserUseCase(repository);
});

final forgotRepositoryProvider = Provider<ForgotRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(forgotRemoteDataSourceProvider);
  return ForgotRepositoryImpl(remoteDataSource);
});

final forgotRemoteDataSourceProvider = Provider<ForgotRemote>((ref) {
  final dio = ref.watch(dioProvider);
  return ForgotRemote(dio);
});

final dioProvider = Provider<Dio>((ref) {
  return DioClient().createDio();
});

import 'package:a2zjewelry/features/cart/data/datasources/cart_service_remote.dart';
import 'package:a2zjewelry/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:a2zjewelry/features/cart/domain/repositories/cart_repo.dart';
import 'package:a2zjewelry/features/cart/domain/usecases/cart_delete_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:a2zjewelry/features/cart/domain/entities/cart_entity.dart';
import 'package:a2zjewelry/features/cart/domain/usecases/cart_usecase.dart';
import 'package:dio/dio.dart';
import 'dart:async';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final cartServiceRemoteProvider = Provider<CartServiceRemote>((ref) {
  final dio = ref.watch(dioProvider);
  return CartServiceRemote(dio);
});

final deleteCartItemUseCaseProvider = Provider<CartDeleteItem>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return CartDeleteItem(cartRepository);
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final cartServiceRemote = ref.watch(cartServiceRemoteProvider);
  return CartRepositoryImpl(cartServiceRemote);
});

final fetchCartUseCaseProvider = Provider<FetchCartUseCase>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return FetchCartUseCase(cartRepository);
});

final cartStateProvider = StateNotifierProvider<CartStateNotifier, AsyncValue<Cart>>((ref) {
  final fetchCartUseCase = ref.watch(fetchCartUseCaseProvider);
  final deleteCartItemUseCase = ref.watch(deleteCartItemUseCaseProvider);
  return CartStateNotifier(fetchCartUseCase, deleteCartItemUseCase);
});

class CartStateNotifier extends StateNotifier<AsyncValue<Cart>> {
  final FetchCartUseCase fetchCartUseCase;
  final CartDeleteItem deleteCartItemUseCase;
  Timer? _timer;
  Cart? _lastFetchedCart;

  CartStateNotifier(this.fetchCartUseCase, this.deleteCartItemUseCase) : super(const AsyncValue.loading()) {
    _fetchCart();
    _startPolling();
  }

  Future<void> _fetchCart() async {
    try {
      final cart = await fetchCartUseCase.execute();
      if (cart != _lastFetchedCart) {
        _lastFetchedCart = cart;
        state = AsyncValue.data(cart);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteCartItem(int itemId) async {
    try {
      await deleteCartItemUseCase.execute(itemId);
      // Refresh cart after deletion
      _fetchCart();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchCart();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
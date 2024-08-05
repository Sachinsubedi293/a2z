import 'package:a2zjewelry/features/cart/presentation/providers/cart_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:a2zjewelry/features/cart/presentation/widgets/total_price.dart';
import '../widgets//cart_item.dart.dart';

class CartPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartStateProvider);
    final cartService = ref.watch(cartServiceRemoteProvider);
    return Scaffold(
      body: cartState.when(
        data: (cart) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartItem(
                      title: 'Product ${item.product}',
                      quantity: item.quantity.toString(),
                      imageUrl: 'https://example.com/image.jpg',
                      onDelete: () {
                        showDeleteConfirmationDialog(
                          context,
                          () async {
                            await cartService.deleteCartItem(item.id);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              TotalPrice(totalPrice: cart.totalPrice),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error\nStackTrace: $stackTrace'),
        ),
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(
    BuildContext context,
    Future<void> Function() onConfirm,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to delete this item from the cart?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await onConfirm();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

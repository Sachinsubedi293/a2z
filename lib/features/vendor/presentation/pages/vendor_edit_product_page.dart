import 'package:a2zjewelry/features/product/presentation/providers/product_detail_provider.dart';
import 'package:a2zjewelry/features/vendor/presentation/widgets/vendor_product_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProductPage extends ConsumerWidget {
  final int productId;

  const EditProductPage({required this.productId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailAsyncValue =
        ref.watch(productDetailNotifierProvider(productId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop(true);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Edit Product'),
      ),
      body: productDetailAsyncValue.when(
        data: (products) => EditProductForm(product: products), 
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

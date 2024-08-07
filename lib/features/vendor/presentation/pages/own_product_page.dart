import 'package:a2zjewelry/features/vendor/presentation/providers/vendor_delete_product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:a2zjewelry/features/vendor/presentation/providers/vendor_own_product_provider.dart';
import 'package:a2zjewelry/features/vendor/presentation/widgets/own_product_card.dart';

class OwnProductsPage extends ConsumerStatefulWidget {
  const OwnProductsPage({super.key});

  @override
  _OwnProductsPageState createState() => _OwnProductsPageState();
}

class _OwnProductsPageState extends ConsumerState<OwnProductsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final query = _searchController.text;
      ref.read(productNotifierProvider.notifier).search(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, int productId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
    
    if (result == true) {
      await ref.read(deleteNotifierProvider.notifier).deleteProduct(productId);
      await ref.read(productNotifierProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    final productNotifier = ref.read(productNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search products',
            border: InputBorder.none,
            isDense: true,
          ),
          onChanged: (query) {
            productNotifier.search(query);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Optional: Add action for search button
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await productNotifier.refresh(),
        child: productState.products.when(
          data: (products) {
            if (products.isEmpty) {
              return const Center(child: Text('No products available.'));
            } else {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.extentAfter == 0) {
                    productNotifier.loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageUrls =
                        product.images.map((img) => img.image).toList();

                    return ProductCard(
                      productName: product.name,
                      productPrice: product.price.toString(),
                      productImageUrls: imageUrls,
                      onEdit: () async {
                        final result =
                            await context.push('/edit/${product.id}');
                        if (result == true) {
                          await productNotifier.refresh();
                        }
                      },
                      onDelete: () async {
                        await _showDeleteConfirmationDialog(context, product.id!);
                      },
                    );
                  },
                ),
              );
            }
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

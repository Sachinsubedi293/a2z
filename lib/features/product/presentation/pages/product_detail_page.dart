import 'package:a2zjewelry/features/product/presentation/providers/product_detail_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends ConsumerWidget {
  final int id;

  const ProductDetailPage({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailAsyncValue =
        ref.watch(productDetailNotifierProvider(id));
    final cart = ref.watch(cartServiceprovider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: productDetailAsyncValue.when(
        data: (product) {
          final List<String> imageUrls = [
            'https://www.freepnglogos.com/uploads/discord-logo-png/discord-logo-logodownload-download-logotipos-1.png',
            'https://www.freepnglogos.com/uploads/discord-logo-png/discord-logo-logodownload-download-logotipos-1.png',
            'https://www.freepnglogos.com/uploads/discord-logo-png/discord-logo-logodownload-download-logotipos-1.png',
          ];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 200,
                      child: PageView.builder(
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: imageUrls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          );
                        },
                      )),
                  const SizedBox(height: 16.0),
                  Text(
                    'Product Name: ${product.name}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Category: ${product.category.name}'),
                  const SizedBox(height: 8.0),
                  Text('Slug: ${product.slug}'),
                  const SizedBox(height: 8.0),
                  Text('Introduction: ${product.intro}'),
                  const SizedBox(height: 8.0),
                  Text('Description: ${product.description}'),
                  const SizedBox(height: 8.0),
                  Text('Price: \$${product.price}'),
                  const SizedBox(height: 8.0),
                  Text('Stock Quantity: ${product.stockQuantity}'),
                  const SizedBox(height: 8.0),
               
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQuantityDialog(context, cart);
        },
        tooltip: 'Add to Cart',
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  void _showQuantityDialog(BuildContext context, cart) {
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Quantity'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              hintText: 'Enter quantity',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final quantity = int.tryParse(quantityController.text) ?? 1;
                cart.addToCart(id, quantity);
                Navigator.of(context).pop();
              },
              child: const Text('Add to Cart'),
            ),
          ],
        );
      },
    );
  }
}

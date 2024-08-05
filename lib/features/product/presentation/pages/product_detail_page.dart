import 'package:a2zjewelry/features/product/presentation/providers/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends ConsumerWidget {
  final int id;

  const ProductDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailAsyncValue =
        ref.watch(productDetailNotifierProvider(id));
    final cart = ref.watch(cartServiceprovider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        leading: IconButton(
            onPressed: () {
              context.go('/start/home');
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: productDetailAsyncValue.when(
        data: (product) {
          final List<String> imageUrls = [
            'https://via.placeholder.com/400x200.png?text=Image+1',
            'https://via.placeholder.com/400x200.png?text=Image+2',
            'https://via.placeholder.com/400x200.png?text=Image+3',
          ];

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Product Name: ${product.productName}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text('Category: ${product.category.categoryName}'),
                SizedBox(height: 8.0),
                Text('Slug: ${product.slug}'),
                SizedBox(height: 8.0),
                Text('Introduction: ${product.intro}'),
                SizedBox(height: 8.0),
                Text('Description: ${product.description}'),
                SizedBox(height: 8.0),
                Text('Price: \$${product.price}'),
                SizedBox(height: 8.0),
                Text('Stock Quantity: ${product.stockQuantity}'),
                SizedBox(height: 8.0),
                Text('Created At: ${product.createdAt}'),
                SizedBox(height: 8.0),
                Text('Updated At: ${product.updatedAt}'),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQuantityDialog(context,cart);
        },
        child: Icon(Icons.shopping_cart),
        tooltip: 'Add to Cart',
      ),
    );
  }

  void _showQuantityDialog(BuildContext context,cart) {
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
              hintText: 'Enter quantity',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final quantity = int.tryParse(quantityController.text) ?? 1;
                cart.addToCart(id, quantity);
                Navigator.of(context).pop();
              },
              child: Text('Add to Cart'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:a2zjewelry/features/product/presentation/providers/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends ConsumerWidget {
  final int id;

  // Constructor to accept the id parameter
  const ProductDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the id to get the product detail from the provider
    final productDetailAsyncValue = ref.watch(productDetailNotifierProvider(id));

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
          // For demonstration purposes, using placeholder images for carousel
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
                // Carousel using PageView
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
    );
  }
}

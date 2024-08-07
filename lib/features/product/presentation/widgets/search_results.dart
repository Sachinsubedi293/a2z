import 'package:flutter/material.dart';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/product/presentation/widgets/search_result_item.dart';

class SearchResults extends StatelessWidget {
  final List<Product> products;

  const SearchResults({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(
            child: Text(
              'No products found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return SearchResultItem(
                id: product.id!,
                title: product.name,
                price: product.price.toString(),
                imageUrl:  'https://www.freepnglogos.com/uploads/discord-logo-png/discord-logo-logodownload-download-logotipos-1.png', // Placeholder image URL
              );
            },
          );
  }
}

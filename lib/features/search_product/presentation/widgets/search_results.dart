import 'package:a2zjewelry/features/search_product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/search_product/presentation/widgets/search_result_item.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final List<Product> products;

  const SearchResults({
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? Center(child: Text('No products found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
        : GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return SearchResultItem(
                title: product.productName,
                price: product.price,
                imageUrl: product.images.isNotEmpty ? product.images.first.image : '',
              );
            },
          );
  }
}

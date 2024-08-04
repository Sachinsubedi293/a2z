import 'package:flutter/material.dart';
import 'package:a2zjewelry/features/product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/product/presentation/widgets/search_result_item.dart';

class SearchResults extends StatelessWidget {
  final List<Product> products;

  const SearchResults({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? Center(
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
                id: product.id,
                title: product.productName,
                price: product.price,
                imageUrl:  'https://via.placeholder.com/150', // Placeholder image URL
              );
            },
          );
  }
}

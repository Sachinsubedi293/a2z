import 'package:a2zjewelry/features/search_product/presentation/providers/product_provider.dart';
import 'package:a2zjewelry/features/search_product/presentation/widgets/search_bar.dart';
import 'package:a2zjewelry/features/search_product/presentation/widgets/search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(productNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchBar1(), // Assuming this is a custom search bar widget
      ),
      body: searchResults.when(
        data: (products) => products.isEmpty?Center(child: Text("No Products Available"),):SearchResults(products: products),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

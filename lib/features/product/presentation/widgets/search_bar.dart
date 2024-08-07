import 'package:a2zjewelry/features/product/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar1 extends ConsumerWidget {
  const SearchBar1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search for jewelry...',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: Icon(Icons.search, color: Colors.black),
      ),
      onSubmitted: (query) {
        ref.read(productNotifierProvider.notifier).search(query);
      },
    );
  }
}

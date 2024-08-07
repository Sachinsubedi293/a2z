// widgets/top_collection.dart
import 'package:flutter/material.dart';
import 'collection_item.dart';

class TopCollection extends StatelessWidget {
  const TopCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CollectionItem(title: 'FOR SLIM & BEAUTY', imageUrl: 'https://example.com/for_slim_beauty.jpg', subtitle: 'Sale up to 40%'),
        CollectionItem(title: 'Summer Collection 2021', imageUrl: 'https://example.com/summer_collection.jpg', subtitle: 'Most sexy & fabulous design'),
      ],
    );
  }
}

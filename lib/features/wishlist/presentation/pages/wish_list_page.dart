// lib/pages/wishlist_page.dart
import 'package:a2zjewelry/features/wishlist/presentation/widgets/wishlist_items.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: WishlistItems(),
    );
  }
}

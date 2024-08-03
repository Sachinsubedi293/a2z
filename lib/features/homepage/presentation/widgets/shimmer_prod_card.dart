import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 150, // Adjust this width as needed
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 16,
              color: Colors.grey,
            ),
            const SizedBox(height: 4),
            Container(
              height: 14,
              width: 60,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

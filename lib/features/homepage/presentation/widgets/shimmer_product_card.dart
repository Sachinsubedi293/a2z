import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Container(
              height: 16,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Container(
              height: 16,
              color: Colors.grey,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}

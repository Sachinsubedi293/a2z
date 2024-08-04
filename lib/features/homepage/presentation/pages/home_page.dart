import 'package:a2zjewelry/features/category/presentation/widgets/section_title.dart';
import 'package:a2zjewelry/features/homepage/presentation/widgets/banner_widget.dart';
import 'package:a2zjewelry/features/homepage/presentation/widgets/category_row.dart';
import 'package:a2zjewelry/features/homepage/presentation/widgets/collection_banner.dart';
import 'package:a2zjewelry/features/homepage/presentation/widgets/feature_products.dart';
import 'package:a2zjewelry/features/homepage/presentation/widgets/recommended_products.dart';
import 'package:a2zjewelry/features/homepage/presentation/widgets/top_collection.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerWidget(),
              SizedBox(height: 16),
              CategoryRow(),
              SizedBox(height: 16),
              SectionTitle(title: 'Feature Products'),
              FeatureProducts(),
              SizedBox(height: 16),
              CollectionBanner(),
              SizedBox(height: 16),
              SectionTitle(title: 'Recommended'),
              RecommendedProducts(),
              SizedBox(height: 16),
              SectionTitle(title: 'Top Collection'),
              TopCollection(),
            ],
          ),
        ),
      ),
    );
  }
}

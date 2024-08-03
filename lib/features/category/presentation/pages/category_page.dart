import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 16),
            _buildSectionTitle('Categories'),
            SizedBox(height: 16),
            _buildCategoriesGrid(),
            SizedBox(height: 16),
            _buildSectionTitle('Featured'),
            SizedBox(height: 16),
            _buildFeaturedCategories(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search categories',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        // Implement search functionality here
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(_categories.length, (index) {
          return _buildCategoryItem(
            _categories[index]['title']!,
            _categories[index]['imageUrl']!,
          );
        }),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navigate to the category details page
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.2),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_featuredCategories.length, (index) {
          return _buildFeaturedCategoryItem(
            _featuredCategories[index]['title']!,
            _featuredCategories[index]['imageUrl']!,
          );
        }),
      ),
    );
  }

  Widget _buildFeaturedCategoryItem(String title, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.2),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  final List<Map<String, String>> _categories = [
    {'title': 'Necklaces', 'imageUrl': 'https://example.com/necklaces.jpg'},
    {'title': 'Rings', 'imageUrl': 'https://example.com/rings.jpg'},
    {'title': 'Bracelets', 'imageUrl': 'https://example.com/bracelets.jpg'},
    {'title': 'Earrings', 'imageUrl': 'https://example.com/earrings.jpg'},
  ];

  final List<Map<String, String>> _featuredCategories = [
    {'title': 'Gold Jewelry', 'imageUrl': 'https://example.com/gold.jpg'},
    {'title': 'Silver Jewelry', 'imageUrl': 'https://example.com/silver.jpg'},
  ];
}

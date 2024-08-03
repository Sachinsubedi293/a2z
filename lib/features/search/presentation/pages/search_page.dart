import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildSearchBar()
      ),
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    // Static data for search results
    List<Map<String, String>> searchResults = [
      {
        'title': 'Gold Necklace',
        'price': '120.00',
        'imageUrl': 'https://example.com/gold_necklace.jpg'
      },
      {
        'title': 'Diamond Ring',
        'price': '450.00',
        'imageUrl': 'https://example.com/diamond_ring.jpg'
      },
      {
        'title': 'Silver Bracelet',
        'price': '80.00',
        'imageUrl': 'https://example.com/silver_bracelet.jpg'
      },
    ];

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return _buildSearchResultItem(
          searchResults[index]['title']!,
          searchResults[index]['price']!,
          searchResults[index]['imageUrl']!,
        );
      },
    );
  }

  Widget _buildSearchResultItem(String title, String price, String imageUrl) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              '\$$price',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

   Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for jewelry...',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: Icon(Icons.search, color: Colors.black),
      ),
      onSubmitted: (query) {
        // Implement search functionality here
      },
    );
  }
}


 
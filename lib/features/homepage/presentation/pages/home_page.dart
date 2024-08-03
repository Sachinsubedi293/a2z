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
              _buildBanner(),
              SizedBox(height: 16),
              _buildCategoryRow(),
              SizedBox(height: 16),
              _buildSectionTitle('Feature Products'),
              _buildFeatureProducts(),
              SizedBox(height: 16),
              _buildCollectionBanner(),
              SizedBox(height: 16),
              _buildSectionTitle('Recommended'),
              _buildRecommendedProducts(),
              SizedBox(height: 16),
              _buildSectionTitle('Top Collection'),
              _buildTopCollection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryItem('Women', Icons.woman),
        _buildCategoryItem('Men', Icons.man),
        _buildCategoryItem('Accessories', Icons.watch),
        _buildCategoryItem('Beauty', Icons.brush),
      ],
    );
  }

  Widget _buildCategoryItem(String title, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32),
        Text(title),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
              'https://example.com/autumn_collection.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Autumn Collection 2021',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(onPressed: () {}, child: Text('Show all')),
      ],
    );
  }

  Widget _buildFeatureProducts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildProductItem('Turtleneck Sweater', 39.99, 'https://example.com/turtleneck_sweater.jpg'),
          _buildProductItem('Long Sleeve Dress', 45.00, 'https://example.com/long_sleeve_dress.jpg'),
          _buildProductItem('Sportwear', 80.00, 'https://example.com/sportwear.jpg'),
        ],
      ),
    );
  }

  Widget _buildProductItem(String title, double price, String imageUrl) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(title),
          Text('\$$price'),
        ],
      ),
    );
  }

  Widget _buildCollectionBanner() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
              'https://example.com/hang_out_party.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'HANG OUT & PARTY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedProducts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildProductItem('White fashion hoodie', 29.00, 'https://example.com/white_fashion_hoodie.jpg'),
          _buildProductItem('Cotton T-Shirt', 30.00, 'https://example.com/cotton_tshirt.jpg'),
        ],
      ),
    );
  }

  Widget _buildTopCollection() {
    return Column(
      children: [
        _buildCollectionItem('FOR SLIM & BEAUTY', 'https://example.com/for_slim_beauty.jpg', 'Sale up to 40%'),
        _buildCollectionItem('Summer Collection 2021', 'https://example.com/summer_collection.jpg', 'Most sexy & fabulous design'),
      ],
    );
  }

  Widget _buildCollectionItem(String title, String imageUrl, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/* class HomePage extends StatefulWidget {
  final Future<Box<ProfileResModel>> profileBoxFuture;
  final Future<Box<LoginResModel>> loginBoxFuture;

  const HomePage({
    super.key,
    required this.profileBoxFuture,
    required this.loginBoxFuture,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> _featuredCollectionsFuture;
  late Future<List<Product>> _vendorPromotionsFuture;
  late Future<List<Product>> _newArrivalsFuture;
  late Future<List<Product>> _bestSellersFuture;
  late Future<List<Product>> _seasonalPromotionsFuture;
  late Future<List<String>> _customerReviewsFuture; // Assuming reviews are strings

  String _email = 'User';
  late Future<void> _profileDataFuture;

  @override
  void initState() {
    super.initState();
    final apiService = ApiService();
    _featuredCollectionsFuture = apiService.fetchProducts();
    _vendorPromotionsFuture = apiService.fetchProducts();
    _newArrivalsFuture = apiService.fetchNewArrivals();
    _bestSellersFuture = apiService.fetchBestSellers();
    _seasonalPromotionsFuture = apiService.fetchSeasonalPromotions();
    _customerReviewsFuture = apiService.fetchCustomerReviews();
    _profileDataFuture = _initializeProfileData();
  }

  Future<void> _initializeProfileData() async {
    try {
      final box = await widget.profileBoxFuture;
      final profileResModel = box.get('profile');
      setState(() {
        _email = profileResModel?.email ?? 'User';
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching profile data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jewelry Store'),
      ),
      body: FutureBuilder<void>(
        future: _profileDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Hero Section
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/assets/welcome1.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Discover Exclusive Jewelry from Top Vendors!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildNewArrivalsSection(),
                  const SizedBox(height: 20),
                  _buildBestSellersSection(),
                  const SizedBox(height: 20),
                  _buildSeasonalPromotionsSection(),
                  const SizedBox(height: 20),
                  _buildCustomerReviewsSection(),
                  const SizedBox(height: 20),
                  _buildPopularSection(),
                  const SizedBox(height: 20),
                  _buildVendorPromotionsSection(),
                ],
              ),
            );
          }
        },
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildNewArrivalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Arrivals',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Product>>(
            future: _newArrivalsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const ShimmerProductCard(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final products = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imageUrl: product.image,
                      title: product.name,
                      price: product.price.toString(),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBestSellersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Best Sellers',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Product>>(
            future: _bestSellersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const ShimmerProductCard(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final products = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imageUrl: product.image,
                      title: product.name,
                      price: product.price.toString(),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSeasonalPromotionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seasonal Promotions',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Product>>(
            future: _seasonalPromotionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const ShimmerProductCard(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final products = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imageUrl: product.image,
                      title: product.name,
                      price: product.price.toString(),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Reviews',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<String>>(
          future: _customerReviewsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final reviews = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reviews.map((review) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('- $review', style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
              );
            } else {
              return const Center(child: Text('No reviews available'));
            }
          },
        ),
      ],
    );
  }

  Widget _buildPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Collections',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Product>>(
            future: _featuredCollectionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const ShimmerProductCard(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final products = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imageUrl: product.image,
                      title: product.name,
                      price: product.price.toString(),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVendorPromotionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vendor Promotions',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Product>>(
            future: _vendorPromotionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const ShimmerProductCard(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final products = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imageUrl: product.image,
                      title: product.name,
                      price: product.price.toString(),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Hello $_email! Welcome to Our Jewelry Marketplace",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () {
                    context.go('/home/profile');
                  },
                ),
                // Add more drawer items here
              ],
            ),
          ),
          Expanded(
              child: Container()), // Pushes the Logout button to the bottom
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                clearBoxAndLogout();
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> clearBoxAndLogout() async {
    try {
      final box = await widget.loginBoxFuture;
      await box.clear();
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing box: $e');
      }
    }
  }
}
*/
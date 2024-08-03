import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:a2zjewelry/features/cart/presentation/pages/cart_page.dart';
import 'package:a2zjewelry/features/category/presentation/pages/category_page.dart';
import 'package:a2zjewelry/features/search/presentation/pages/search_page.dart';
import 'package:a2zjewelry/features/wishlist/presentation/pages/wish_list_page.dart';
import 'package:a2zjewelry/features/homepage/presentation/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Example counters
  final int _notificationsCount = 3;
  final int _cartItemCount = 5;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _getAppBarTitle(_selectedIndex),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 8, end: 8),
            badgeContent: Text(
              '$_notificationsCount',
              style: TextStyle(color: Colors.white),
            ),
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.deepOrange),
            child: IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),
          CategoriesPage(),
          SearchPage(),
          CartPage(),
          WishlistPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: Text(
                '$_cartItemCount',
                style: TextStyle(color: Colors.white),
              ),
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.deepOrange),
              child: Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Categories';
      case 2:
        return 'Search';
      case 3:
        return 'Cart';
      case 4:
        return 'Wishlist';
      default:
        return 'GemStore';
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Stack(
              children: [
                Positioned(
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(1);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(2);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(3);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlist'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(4);
            },
          ),
        ],
      ),
    );
  }
}

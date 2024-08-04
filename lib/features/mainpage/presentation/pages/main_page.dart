import 'package:a2zjewelry/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:a2zjewelry/features/mainpage/presentation/widgets/drop_down_menu.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({required this.child, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final int _notificationsCount = 3;
  final int _cartItemCount = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        NavigationService.goHome();
        break;
      case 1:
        NavigationService.goToCategories();
        break;
      case 2:
        NavigationService.goToSearch();
        break;
      case 3:
        NavigationService.goToCart();
        break;
      case 4:
        NavigationService.goToWishlist();
        break;
    }
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
          UserAvatarMenu(
            avatarUrl:
                'https://example.com/avatar.jpg', // Replace with the actual URL
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: widget.child,
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
                    'A2Z Jewelry',
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
              context.pop();
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              context.pop();
              _onItemTapped(1);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              context.pop();
              _onItemTapped(2);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () {
              context.pop();
              _onItemTapped(3);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlist'),
            onTap: () {
              context.pop();
              _onItemTapped(4);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              context.pop();
             NavigationService.goToProfile();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:a2zjewelry/features/mainpage/presentation/widgets/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class VendorMainPage extends StatefulWidget {
  final Widget child;
  const VendorMainPage({super.key, required this.child});

  @override
  State<VendorMainPage> createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
  int _selectedIndex = 0;
  final int _notificationsCount = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
       context.go('/vendor/analytics');
        break;
      case 1:
        context.go('/vendor/add');
        break;
      case 2:
        context.go('/vendor/products');
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
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: (){
                context.go('/start/home');
              }, icon: Icon(Icons.money)),
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 8, end: 8),
            badgeContent: Text(
              '$_notificationsCount',
              style: const TextStyle(color: Colors.white),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.deepOrange),
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {},
            ),
          ),
          UserAvatarMenu()
        ],
      ),
      drawer: _buildDrawer(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Product',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Products',
          ),
          
        ],
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Analytics';
      case 1:
        return 'Add Product';
      case 2:
        return 'My Products';
      default:
        return 'Analytics';
    }
  }



  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Text(
              'Vendor Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Analytics'),
            onTap: () {
              context.pop();
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Product'),
            onTap: () {
              context.pop();
              _onItemTapped(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('My Products'),
            onTap: () {
              context.pop();
              _onItemTapped(2);
            },
          ),
         
        ],
      ),
    );
  }
}

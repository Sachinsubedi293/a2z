import 'package:a2zjewelry/features/cart/presentation/providers/cart_providers.dart';
import 'package:a2zjewelry/features/mainpage/presentation/widgets/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class MainPage extends ConsumerStatefulWidget {
  final Widget child;

  const MainPage({required this.child, super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;
  final int _notificationsCount = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/start/home');
        break;
      case 1:
        context.go('/start/categories');
        break;
      case 2:
        context.go('/start/search');
        break;
      case 3:
        context.go('/start/cart');
        break;
      case 4:
        context.go('/start/wishlist');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
      
        final cartState = ref.watch(cartStateProvider);

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
                context.go('/vendor/analytics');
              }, icon: Icon(Icons.sell)),
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: 8, end: 8),
                badgeContent: Text(
                  '${_notificationsCount}',
                  style: const TextStyle(color: Colors.white),
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.deepOrange),
                child: IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              UserAvatarMenu(),
            ],
          ),
          drawer: _buildDrawer(),
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  badgeContent: Text(
                    cartState.when(
                      data: (cart) => '${cart.items.length}',
                      loading: () => '...',
                      error: (_, __) => '0',
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  badgeStyle: const badges.BadgeStyle(badgeColor: Colors.deepOrange),
                  child: const Icon(Icons.shopping_cart),
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Wishlist',
              ),
            ],
          ),
        );
      },
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
          const DrawerHeader(
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.pop();
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              context.pop();
              _onItemTapped(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              context.pop();
              _onItemTapped(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              context.pop();
              _onItemTapped(3);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Wishlist'),
            onTap: () {
              context.pop();
              _onItemTapped(4);
            },
          ),
        ],
      ),
    );
  }
}

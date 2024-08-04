import 'package:a2zjewelry/core/utils/env_components.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserAvatarMenu extends StatelessWidget {
  final String avatarUrl;

  UserAvatarMenu({required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        radius: 24, 
        backgroundColor: Colors.deepOrange,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.deepOrange, 
              width: 3, 
            ),
          ),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(baseUrl + avatarUrl),
          ),
        ),
      ),
      offset: Offset(0, 50),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Profile',
            child: Text('Profile'),
          ),
          PopupMenuItem<String>(
            value: 'Logout',
            child: Text('Logout'),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 'Profile') {
          context.go('/profile');
        } else if (value == 'Logout') {
          _showLogoutDialog(context);
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sure'),
              onPressed: () async {
                // Clear Hive boxes
                await Hive.box<LoginResModel>('loginBox').clear();
                await Hive.box<ProfileResModel>('profileBox').clear();

                context.go('/login');
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:a2zjewelry/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';

class UserAvatarMenu extends StatelessWidget {
  final String avatarUrl;

  UserAvatarMenu({required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      onSelected: (value) {
        if (value == 'Profile') {
          NavigationService.goToProfile();
        } else if (value == 'Logout') {
          _showLogoutDialog(context);
        }
      },
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

                NavigationService.goLogin();
              },
            ),
          ],
        );
      },
    );
  }
}

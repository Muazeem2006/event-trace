// ignore_for_file: prefer_const_constructors


import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/models/User.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  User? user;

  @override
  void initState() {
    super.initState();
    final LocalStorage userStorage = LocalStorage('user');
    var userData = userStorage.getItem('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            accountName: Text(
              user!.name!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user!.email,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/member-01.png'),
            ),
          ),
          ListTile(
            title: const Text('My Profile'),
            leading: Icon(Icons.person_3_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: const Text('Message'),
            leading: Badge(
              textStyle:
                  TextStyle(color: Theme.of(context).colorScheme.background),
              backgroundColor: appRed,
              label: Text("3"),
              child: Icon(Icons.chat_bubble_outlined),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/notification');
            },
          ),
          ListTile(
            title: const Text('Calendar'),
            leading: Icon(Icons.event_note),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          ListTile(
            title: const Text('Bookmark'),
            leading: Icon(Icons.bookmark_border_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/bookmark');
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            leading: Icon(Icons.mail_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            title: const Text('Helps & FAQs'),
            leading: Icon(Icons.help_outline),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: Icon(Icons.logout),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    title: Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    content: Text('Are you sure you want to sign out?'),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          // Perform sign out action
                          Navigator.of(context).pop();
                        },
                        child: Text('Sign Out'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

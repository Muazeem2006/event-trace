// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:developer';

import 'package:event_trace/constants/app_data.dart';
import 'package:event_trace/models/User.dart';
import 'package:event_trace/views/addons/edit_profile_screen.dart';
import 'package:event_trace/views/addons/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  @override
  void initState() {
    super.initState();
    final LocalStorage userStorage = LocalStorage('user');
    var userData = userStorage.getItem('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }
  }

  List<Map<String, dynamic>> profileData = [
    {
      'title': "Edit Profile",
      'link': EditProfileScreen(),
    },
    {
      'title': "Notifications",
      'link': null,
    },
    {
      'title': "Frequently Asked Questions",
      'link': HelpScreen(),
    },
    {
      'title': "Contact Us",
      'link': null,
    },
    {
      'title': "Sign out",
      'link': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: openDrawer,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Profile ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Airbnb Cereal App",
            fontSize: 24,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    backgroundImage: AssetImage('assets/images/member-02.png'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user!.name!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        user!.email,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: profileData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(
                      profileData[index]['title'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      log(profileData[index]['title']);
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Interest',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    label: Text("CHANGE"),
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                    avatar: Icon(
                      Icons.edit_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: List.generate(
                  interestCollection.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                      backgroundColor: interestCollection[index]['color'],
                      label: Text(
                        interestCollection[index]['name'],
                      ),
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

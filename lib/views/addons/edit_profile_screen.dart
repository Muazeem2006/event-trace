// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'dart:developer'; 

import 'dart:io';

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/constants/app_data.dart';
import 'package:event_trace/constants/file_upload.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

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
        // elevation: 0,
        title: Text(
          'Edit Profile',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: auxGrey,
                      backgroundImage:
                          AssetImage('assets/images/member-02.png'),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: PopupMenuButton<String>(
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          offset: Offset(0, 40),
                          onSelected: (String result) {
                            log('Selected: $result');
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                                value: 'camera',
                                child: Row(
                                  children: [
                                    Icon(Icons.camera_alt_outlined),
                                    Text('Snap Picture'),
                                  ],
                                ),
                                onTap: () {
                                  // Implement camera
                                  takePicture((image) => _image);
                                  log(_image!.path);
                                }),
                            PopupMenuItem<String>(
                                value: 'gallery',
                                child: Row(
                                  children: [
                                    Icon(Icons.image_outlined),
                                    Text('Select from Gallery'),
                                  ],
                                ),
                                onTap: () {
                                  // Implement gallery
                                  selectPicture((image) => _image);
                                  log(_image!.path);
                                }),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Ashfak Sayem',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '350',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Column(
                    children: [
                      Text(
                        '346',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Follower',
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
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Me",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter About Me',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Interest',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
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

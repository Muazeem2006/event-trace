// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:event_trace/constants/app_data.dart';

class CaleendarScreen extends StatefulWidget {
  const CaleendarScreen({Key? key}) : super(key: key);

  @override
  _CaleendarScreenState createState() => _CaleendarScreenState();
}

class _CaleendarScreenState extends State<CaleendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          "Notification",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            color: Theme.of(context).colorScheme.onPrimary,
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
              leading: CircleAvatar(
                backgroundImage:
                    AssetImage(notificationData[index]['image']!),
              ),
              title: Text(notificationData[index]['title']!, style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),),
              children: [
                ListTile(
                  title: Text(notificationData[index]['detail']!, style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
                  onTap: () {},
                )
              ]);
        },
        itemCount: notificationData.length,
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:event_trace/constants/app_data.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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

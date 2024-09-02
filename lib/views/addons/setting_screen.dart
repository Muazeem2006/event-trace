// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'dart:developer';
import 'package:event_trace/constants/app_data.dart';
import 'package:event_trace/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        title: Text(
          'Settings',
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Theme Settings",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Choose your preferred theme",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              trailing: Switch(
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: settingsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(settingsList[index]['title'],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    subtitle: Row(
                      children: settingsList[index]['subtitle']
                              .every((element) => element is String)
                          ? [
                              Text(
                                settingsList[index]['subtitle'].join(', '),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              )
                            ]
                          : [],
                    ),
                    onTap: () {
                      log(settingsList[index]['title']);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/views/components/detail_screen.dart';
import 'package:event_trace/views/utils/bookmark_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        title: Text(
          'Bookmarks',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<EventNotifier>(
                builder: (context, eventNotifier, child) {
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        eventNotifier.eventList.length,
                        (index) {
                          final event = eventNotifier.eventList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: BookmarkItem(
                              dateTime: dateFormatter(
                                  event.dateTime, 'dd MMM, yyyy, EEE'),
                              title: event.name,
                              location: event.venue!.name,
                              image: imageUrl(event.photos!.first),
                              iconClick: () {
                                triggerToast(
                                  context,
                                  '${event.name} removed from bookmark',
                                  appRed,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  FlutterToastr.bottom,
                                );
                              },
                              cardClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DetailScreen(
                                        event: event,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
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

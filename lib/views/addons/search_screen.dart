// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/constants/app_data.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/views/components/detail_screen.dart';
import 'package:event_trace/views/utils/event_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.secondaryContainer,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 28,
                          ),
                          prefixIconColor: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Chip(
                        backgroundColor: Colors.blue,
                        avatar: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.filter_list_sharp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        label: Text(
                          "Filter",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      nearbyCollections.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Consumer<EventNotifier>(
                            builder: (context, eventNotifier, child) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    eventNotifier.eventList.length,
                                    (index) {
                                      final event =
                                          eventNotifier.eventList[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: EventListItem(
                                          dateTime: dateFormatter(
                                              event.dateTime,
                                              'dd MMM, yyyy, EEE'),
                                          title: event.name,
                                          location: event.venue!.name,
                                          image: imageUrl(event.photos!.first),
                                          iconClick: () {
                                            triggerToast(
                                              context,
                                              '${event.name} added to bookmark',
                                              appGreen,
                                              Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary,
                                              FlutterToastr.top,
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
                        );
                      },
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

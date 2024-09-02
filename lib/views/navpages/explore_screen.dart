// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, avoid_print
import 'package:event_trace/constants/app_locator.dart';
import 'package:event_trace/models/Event.dart';
import 'package:event_trace/services/request.dart';
import 'package:event_trace/views/utils/no_result_found.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/constants/app_data.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/views/utils/ad_card.dart';
import 'package:event_trace/views/utils/search_box.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();
  String address = 'Unknown location';
  bool loading = true;

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  Future<void> fetchEvents(BuildContext context) async {
    final response = await getRequest('events', null);
    try {
      response.data['events']
          .map<Event>((eventJson) => Event.fromMap(eventJson))
          .where((event) => !context
              .read<EventNotifier>()
              .eventList
              .any((e) => e.id == event.id))
          .forEach((event) => context.read<EventNotifier>().addEvent(event));
    } catch (e) {
      triggerToast(
        context,
        'Failed to fetch events',
        Colors.red,
        Colors.white,
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation().then((value) {
      if (mounted) {
        setState(() {
          address = value;
        });
      }
    });

    fetchEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          onPressed: openDrawer,
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Current Location",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Text(
              address,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          Column(
            children: [
              SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Badge(
                    backgroundColor: appRed,
                    child: Icon(
                      Icons.notifications,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: size.height * 0.17,
                width: double.maxFinite,
              ),
              Container(
                height: 120,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    SearchBox(
                      controller: searchController,
                      onTap: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 100,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      interestCollection.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          avatar: Icon(
                            interestCollection[index]['icon'],
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          backgroundColor: interestCollection[index]['color'],
                          label: Text(
                            interestCollection[index]['name'],
                          ),
                          labelStyle: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming Events',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(
                                Icons.arrow_right_sharp,
                                color: Theme.of(context).colorScheme.tertiary,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : 
                        NoResultFound(errorText: 'No upcoming events found')
                        // Consumer<EventNotifier>(
                        //     builder: (context, eventNotifier, child) {
                        //       return Row(
                        //         children: List.generate(
                        //           eventNotifier.eventList.length,
                        //           (index) {
                        //             final event =
                        //                 eventNotifier.eventList[index];
                        //             return SizedBox(
                        //               width: size.width * 0.7,
                        //               child: EventCard(
                        //                 name: event.name,
                        //                 day: dateFormatter(event.dateTime, "d"),
                        //                 month: dateFormatter(
                        //                     event.dateTime, "MMM"),
                        //                 image: event.photos!.isNotEmpty
                        //                     ? imageUrl(event.photos!.first)
                        //                     : "https://picsum.photos/seed/picsum/200",
                        //                 location: event.venue != null
                        //                     ? event.venue!.name
                        //                     : '',
                        //                 iconClick: () {
                        //                   triggerToast(
                        //                     context,
                        //                     "${event.name} added to bookmark",
                        //                     appGreen,
                        //                     Theme.of(context)
                        //                         .colorScheme
                        //                         .background,
                        //                     FlutterToastr.top,
                        //                   );
                        //                 },
                        //                 cardClick: () {
                        //                   Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                       builder: (context) {
                        //                         return DetailScreen(
                        //                             event: event);
                        //                       },
                        //                     ),
                        //                   );
                        //                 },
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       );
                        //     },
                        //   ),
                
                  ),
                  AdCard(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nearby You',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(
                                Icons.arrow_right_sharp,
                                color: Theme.of(context).colorScheme.tertiary,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : NoResultFound(errorText: 'No nearby events found',),
                  // Consumer<EventNotifier>(
                  //     builder: (context, eventNotifier, child) {
                  //       return ListView.separated(
                  //         physics: const BouncingScrollPhysics(),
                  //         scrollDirection: Axis.vertical,
                  //         shrinkWrap: true,
                  //         padding: EdgeInsets.symmetric(horizontal: 10),
                  //         itemBuilder: (BuildContext context, int index) {
                  //           final event = eventNotifier.eventList[index];
                  //           return EventListItem(
                  //             dateTime: dateFormatter(
                  //                 event.dateTime, "dd MMM yyyy, EEE"),
                  //             title: event.name,
                  //             location: event.venue!.name,
                  //             image: event.photos!.isNotEmpty
                  //                 ? imageUrl(event.photos!.first)
                  //                 : "https://picsum.photos/seed/picsum/200",
                  //             iconClick: () {
                  //               triggerToast(
                  //                 context,
                  //                 "${event.name} added to bookmark",
                  //                 appGreen,
                  //                 Theme.of(context).colorScheme.background,
                  //                 FlutterToastr.top,
                  //               );
                  //             },
                  //             cardClick: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) {
                  //                     return DetailScreen(event: event);
                  //                   },
                  //                 ),
                  //               );
                  //             },
                  //           );
                  //         },
                  //         separatorBuilder:
                  //             (BuildContext context, int index) {
                  //           return SizedBox(height: 10);
                  //         },
                  //         itemCount: eventNotifier.eventList.length,
                  //       );
                  //     },
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


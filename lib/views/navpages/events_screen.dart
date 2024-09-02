// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously


import 'package:event_trace/models/Event.dart';
import 'package:event_trace/views/components/detail_screen.dart';
import 'package:event_trace/views/utils/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:provider/provider.dart';
import 'package:event_trace/services/request.dart';

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool loading = true;

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  String _selectedSegment = 'upcoming';

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

    fetchEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    final events = context.read<EventNotifier>().eventList;
    final upcomingEvents = events
        .where((event) =>
            event.dateTime.isAtSameMomentAs(DateTime.now()) ||
            event.dateTime.isAfter(DateTime.now()))
        .toList();

    final pastEvents = events
        .where((event) => event.dateTime.isBefore(DateTime.now()))
        .toList();

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
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Events',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Color(0xff9B9B9B).withOpacity(0.3),
            ),
            child: Row(
              children: [
                Expanded(child: _buildButton("upcoming", "Upcoming")),
                Expanded(child: _buildButton("past_events", "Past Events")),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _buildContainer(
                pastEvents: pastEvents,
                upcomingEvents: upcomingEvents,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonName, String buttonText) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSegment = buttonName;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedSegment == buttonName
              ? Theme.of(context).colorScheme.inversePrimary
              : null,
          borderRadius:
              _selectedSegment == buttonName ? BorderRadius.circular(20) : null,
        ),
        child: Text(
          buttonText.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _selectedSegment == buttonName
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({
    required List<Event> pastEvents,
    required List<Event> upcomingEvents,
  }) {
    switch (_selectedSegment) {
      case "upcoming":
        return (upcomingEvents.isNotEmpty)
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: ListView.separated(
                          itemCount: upcomingEvents.length,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            final event = upcomingEvents[i];
                            return Column(
                              children: [
                                EventCard(
                                  name: event.name,
                                  day: dateFormatter(event.dateTime, "d"),
                                  month: dateFormatter(event.dateTime, "MMM"),
                                  image: event.photos!.isNotEmpty
                                      ? imageUrl(event.photos!.last)
                                      : "https://picsum.photos/seed/picsum/200",
                                  location: event.venue != null
                                      ? event.venue!.name
                                      : '',
                                  iconClick: () {
                                    triggerToast(
                                      context,
                                      "${event.name} added to bookmark",
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
                                          return DetailScreen(event: event);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10);
                          },
                        ),
                      ),
              )
            : Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // This is placeholder for illustration image
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/no-event.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.calendar_today,
                        size: 100,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        Text(
                          'No Upcoming Event',
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    DynamicButton(buttonText: "EXPLORE EVENTS", onTap: () {}),
                  ],
                ),
              );

      case "past_events":
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : pastEvents.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // This is placeholder for illustration image
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/no-event.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.calendar_today,
                              size: 100,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Text(
                                'No Past Event',
                                style: TextStyle(
                                  fontSize: 24,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          DynamicButton(
                              buttonText: "EXPLORE EVENTS", onTap: () {}),
                        ],
                      ),
                    )
                  : Center(
                      child: ListView.separated(
                        itemCount: pastEvents.length,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          final event = pastEvents[i];
                          return Column(
                            children: [
                              EventCard(
                                name: event.name,
                                day: dateFormatter(event.dateTime, "d"),
                                month: dateFormatter(event.dateTime, "MMM"),
                                image: event.photos!.isNotEmpty
                                    ? imageUrl(event.photos!.last)
                                    : "https://picsum.photos/seed/picsum/200",
                                location: event.venue != null
                                    ? event.venue!.name
                                    : '',
                                iconClick: () {
                                  triggerToast(
                                    context,
                                    "${event.name} added to bookmark",
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
                                        return DetailScreen(event: event);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      ),
                    ),
        );

      default:
        return Container();
    }
  }
}

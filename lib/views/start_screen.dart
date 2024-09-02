// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:event_trace/views/navpages/venue_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:event_trace/models/User.dart';
import 'package:event_trace/views/components/custom_drawer.dart';
import 'package:event_trace/views/navpages/booking_screen.dart';
import 'package:event_trace/views/navpages/category_screen.dart';
import 'package:event_trace/views/navpages/create_event_screen.dart';
import 'package:event_trace/views/navpages/events_screen.dart';
import 'package:event_trace/views/navpages/explore_screen.dart';
import 'package:event_trace/views/navpages/profile_screen.dart';
import 'package:event_trace/views/navpages/tickets_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int currentIndex = 0;
  List<Widget> screenWidgets = [];
  String? token;
  User? user;

  @override
  void initState() {
    super.initState();

    final LocalStorage tokenStorage = LocalStorage('token');
    final LocalStorage userStorage = LocalStorage('user');

    var tokenData = tokenStorage.getItem('token');
    if (tokenData != null) {
      token = tokenData.toString();
    }
    var userData = userStorage.getItem('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }

    if (user == null) {
      screenWidgets = const [
        ExploreScreen(),
        EventsScreen(),
      ];
    } else {
      switch (user!.role) {
        case 'admin':
          screenWidgets = const [
            ExploreScreen(),
            EventsScreen(),
            CategoryScreen(),
            BookingScreen(),
            ProfileScreen(),
          ];
          break;
        case 'attendee':
          screenWidgets = const [
            ExploreScreen(),
            EventsScreen(),
            ProfileScreen(),
          ];
          break;
        case 'venue_owner':
          screenWidgets = const [
            ExploreScreen(),
            EventsScreen(),
            VenueScreen(),
            ProfileScreen(),
          ];
          break;
        case 'event_organizer':
          screenWidgets = const [
            ExploreScreen(),
            EventsScreen(),
            CreateEventScreen(),
            TicketsScreen(),
            ProfileScreen(),
          ];
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: screenWidgets[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          if (user?.role == 'admin') ...[
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.explore_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.explore_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.event_available_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.event_available_rounded),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.category_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.category_rounded),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.bookmark_border_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.bookmark_border_rounded),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
          if (user?.role == "attendee") ...[
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.explore_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.explore_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.event_available_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.event_available_rounded),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
          if (user?.role == "venue_owner") ...[
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.explore_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.explore_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.event_available_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.event_available_rounded),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.category_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.event_seat),
              label: 'Venue',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
          if (user?.role == 'event_organizer') ...[
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.explore_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.explore_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.event_available_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.event_available_rounded),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.add_circle_outline_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: 'New Event',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.confirmation_number_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.confirmation_number_rounded),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ],
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconSize: 30,
        selectedFontSize: 15,
        unselectedFontSize: 15,
      ),
    );
  }
}

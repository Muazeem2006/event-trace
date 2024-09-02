import 'package:flutter/material.dart';

import 'app_colors.dart';

List<Map<String, dynamic>> eventCollections = [
  {
    "name": 'International Band Music Concert',
    "image": 'assets/images/event-01.png',
    "day": '10',
    "month": 'July',
    "location": '36 Guild Street London, UK',
  },
  {
    "name": 'Dance Performance at the Museum of Modern Art',
    "image": 'assets/images/event-02.png',
    "day": '8',
    "month": 'Oct',
    "location": '36 Guild Street London, UK',
  },
];

List<Map<String, dynamic>> nearbyCollections = [
  {
    "title": "Jo Malone London's Mother's Day Presents",
    "location": 'Radius Gallery . Santa Cruz, CA',
    "date": "Wed, Apr 28 . 5:30 PM",
    "image": 'assets/images/event-03.png',
  },
  {
    "title": "A Concert by Florence and the Machine",
    "location": 'The Forum . Inglewood, CA',
    "date": "Sat, May 1 . 7:30 PM",
    "image": 'assets/images/event-04.png',
  },
  {
    "title": "A Cooking Class with Gordon Ramsay",
    "location": 'Sur La Table . San Francisco, CA',
    "date": "Sat, May 8 . 11:00 AM",
    "image": 'assets/images/event-05.png',
  },
  {
    "title": "A Fitness Class at SoulCycle",
    "location": 'SoulCycle . New York, NY',
    "date": "Mon, May 10 . 6:30 AM",
    "image": 'assets/images/event-06.png',
  }
];

List<Map<String, dynamic>> interestCollection = [
  {'name': "Games Online", "color": appPurple, "icon": Icons.games},
  {'name': "Concert", "color": appRed, "icon": Icons.music_note},
  {'name': "Music", "color": appOrange, "icon": Icons.library_music},
  {'name': "Art", "color": appPurple, "icon": Icons.palette},
  {'name': "Movie", "color": appGreen, "icon": Icons.movie},
  {'name': "Others", "color": appCyan, "icon": Icons.category},
];

List<Map<String, String>> notificationData = [
  {
    "image": "assets/images/member-01.png",
    "title": "Samuel Eze invites you to a music concert",
    "detail":
        "Samuel Eze, the host of Alive with Christ Music Concert invites you to his prestigious event"
  },
  {
    "image": "assets/images/member-02.png",
    "title": "New message from Sarah",
    "detail": "You have a new message from your friend Sarah. Check it out!"
  },
  {
    "image": "assets/images/member-03.png",
    "title": "Upcoming event: Tech Conference",
    "detail":
        "Don't miss the upcoming Tech Conference in your area. Register now!"
  },
  {
    "image": "assets/images/member-04.png",
    "title": "Special offer: 50% off on all items",
    "detail":
        "Limited time offer! Get 50% off on all items in our store. Shop now!"
  },
  {
    "image": "assets/images/member-05.png",
    "title": "Reminder: Tomorrow's meeting",
    "detail":
        "Just a friendly reminder about tomorrow's important meeting at 10 AM."
  },
];

List<Map<String, dynamic>> settingsList = [
  {
    'title': 'Account Setting',
    'subtitle': ['Security notification', 'change number'],
  },
  {
    'title': 'Location Setting',
    'subtitle': ['Change Location'],
  },
  {
    'title': 'Interest Setting',
    'subtitle': ['Change or add more interest'],
  },
  {
    'title': 'Notification Setting',
    'subtitle': ['Enable push notifications', 'notification sound'],
  },
  {
    'title': 'Privacy Setting',
    'subtitle': ['Manage data sharing', 'personalization options'],
  },
];

List<Map<String, dynamic>> helpData = [
  {
    'title': 'How to purchase tickets',
    'description': 'Learn how to buy tickets for events using our app.',
    'icon': Icons.shopping_cart_outlined,
  },
  {
    'title': 'Managing your bookings',
    'description': 'Find out how to view and manage your event bookings.',
    'icon': Icons.event_available_outlined,
  },
  {
    'title': 'Event cancellation policy',
    'description': 'Understand our policy for event cancellations and refunds.',
    'icon': Icons.cancel_outlined,
  },
  {
    'title': 'Contacting support',
    'description': 'Get in touch with our support team for assistance.',
    'icon': Icons.headset_outlined,
  },
  {
    'title': 'Account security',
    'description':
        'Tips for keeping your account and personal information secure.',
    'icon': Icons.security_outlined,
  },
  {
    'title': 'Event venue information',
    'description': 'Learn about the venues where the events take place.',
    'icon': Icons.place_outlined,
  },
  {
    'title': 'Payment options and issues',
    'description':
        'Information about payment methods and resolving payment issues.',
    'icon': Icons.attach_money_outlined,
  },
  {
    'title': 'Event ticket transfer',
    'description': 'How to transfer event tickets to another person.',
    'icon': Icons.transfer_within_a_station_outlined,
  },
  {
    'title': 'Accessibility accommodations',
    'description': 'Information about accessibility services at events.',
    'icon': Icons.accessibility_new_outlined,
  },
  {
    'title': 'Event feedback and suggestions',
    'description':
        'Share your feedback and suggestions for improving our app and events.',
    'icon': Icons.feedback_outlined,
  },
];

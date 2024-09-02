// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/booking_notifier.dart';
import 'package:event_trace/models/Booking.dart';
import 'package:event_trace/services/request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    void openDrawer() {
      Scaffold.of(context).openDrawer();
    }

    Future<void> fetchBookings(BuildContext context) async {
      final response = await getRequest('bookings', null);
      try {
        response.data['bookings']
            .map<Booking>((bookingJson) => Booking.fromMap(bookingJson))
            .forEach((booking) =>
                context.read<BookingNotifier>().addBooking(booking));
      } catch (e) {
        triggerToast(
          context,
          'Failed to fetch bookings',
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

      fetchBookings(context);
    }

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
        title: const Text(
          'Bookings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<BookingNotifier>(
              builder: (context, bookingNotifier, child) {
                return ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Upcoming Events',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...bookingNotifier.bookingList.map((booking) {
                      log(bookingNotifier.bookingList.length.toString());
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        leading: Icon(Icons.event_available,
                            size: 40, color: Colors.green[400]),
                        title: Text(booking.event!.name, style: const TextStyle(fontSize: 18)),
                        subtitle: Text(
                          'Hosted by ${booking.event!.organizer!.name} on ${dateFormatter(booking.event!.dateTime, 'yMd')} at ${dateFormatter(booking.event!.dateTime, 'jms')}',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        trailing: Text(
                          '\$${double.parse(booking.ticket!.price!)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),

    );
  }
}

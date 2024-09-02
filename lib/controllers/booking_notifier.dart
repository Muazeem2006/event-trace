import 'package:event_trace/models/Booking.dart';
import 'package:flutter/material.dart';

class BookingNotifier extends ChangeNotifier {
  final List<Booking> _bookingList = [];

  List<Booking> get bookingList => _bookingList;

  BookingNotifier() {
    // Initialization logic can be added here.
  }

  // adding booking
  addBooking(Booking booking) {
    _bookingList.add(booking);
    notifyListeners();
  }

  // removing booking
  removeBooking(Booking booking) {
    _bookingList.remove(booking);
    notifyListeners();
  }

  // updating booking
  void updateBooking(Booking updatedBooking) {
    final index = _bookingList.indexWhere((booking) => booking.id == updatedBooking.id);
    if (index != -1) {
      _bookingList[index] = updatedBooking;
      notifyListeners();
    }
  }

  // loading bookings from server into the provider
  BookingNotifier.all(List<Booking> bookings) {
    _bookingList.addAll(bookings);
    notifyListeners();
  }
}


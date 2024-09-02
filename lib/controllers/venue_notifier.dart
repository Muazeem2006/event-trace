import 'package:event_trace/models/Venue.dart';
import 'package:flutter/material.dart';

class VenueNotifier with ChangeNotifier {
  final List<Venue> _venueList = [];

  List<Venue> get venueList => _venueList;

  VenueNotifier() {
    // Initialization logic can be added here.
  }

  // adding venue
  addVenue(Venue venue) {
    _venueList.add(venue);
    notifyListeners();
  }

  // removing venue
  removeVenue(Venue venue) {
    _venueList.remove(venue);
    notifyListeners();
  }

  // updating venue
  void updateVenue(Venue updatedVenue) {
    final index = _venueList.indexWhere((venue) => venue.id == updatedVenue.id);
    if (index != -1) {
      _venueList[index] = updatedVenue;
      notifyListeners();
    }
  }

  // loading venues from server into the provider
  VenueNotifier.all(List<Venue> venues) {
    _venueList.addAll(venues);
    notifyListeners();
  }
}


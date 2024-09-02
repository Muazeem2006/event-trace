import 'package:event_trace/models/Event.dart';
import 'package:flutter/material.dart';

class EventNotifier extends ChangeNotifier {
  final List<Event> _eventList = [];

  List<Event> get eventList => _eventList;

  EventNotifier() {
    // Initialization logic can be added here.
  }

    String _slug = '';

  String get slug => _slug;

  void setSlug(String newSlug) {
    _slug = newSlug;
    notifyListeners();
  }

  // adding event
  addEvent(Event event) {
    _eventList.add(event);
    notifyListeners();
  }

  // removing event
  removeEvent(Event event) {
    _eventList.remove(event);
    notifyListeners();
  }

  // updating event
  void updateEvent(Event updatedEvent) {
    final index = _eventList.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      _eventList[index] = updatedEvent;
      notifyListeners();
    }
  }

  // loading events from server into the provider
  EventNotifier.all(List<Event> events) {
    _eventList.addAll(events);
    notifyListeners();
  }
}


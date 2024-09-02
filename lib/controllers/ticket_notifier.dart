import 'package:event_trace/models/Ticket.dart';
import 'package:flutter/material.dart';

class TicketNotifier extends ChangeNotifier {
  final List<Ticket> _ticketList = [];

  List<Ticket> get ticketList => _ticketList;

  TicketNotifier() {
    // Initialization logic can be added here.
  }

  // adding ticket
  addTicket(Ticket ticket) {
    _ticketList.add(ticket);
    notifyListeners();
  }

  // removing ticket
  removeTicket(Ticket ticket) {
    _ticketList.remove(ticket);
    notifyListeners();
  }

  // updating ticket
  void updateTicket(Ticket updatedTicket) {
    final index = _ticketList.indexWhere((ticket) => ticket.id == updatedTicket.id);
    if (index != -1) {
      _ticketList[index] = updatedTicket;
      notifyListeners();
    }
  }

  // loading tickets from server into the provider
  TicketNotifier.all(List<Ticket> tickets) {
    _ticketList.addAll(tickets);
    notifyListeners();
  }
}


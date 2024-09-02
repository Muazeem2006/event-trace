
import 'dart:convert';

import 'Event.dart';
import 'Ticket.dart';
import 'User.dart';

class Booking {
  int id;
  final int userId;
  final int eventId;
  final int ticketId;
  int? quantity;
  String? price;
  String? description;
  User? user;
  Event? event;
  Ticket? ticket;
  DateTime createdAt;
  DateTime updatedAt;
  Booking({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.ticketId,
    this.quantity,
    this.price,
    this.description,
    this.user,
    this.event,
    this.ticket,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'event_id': eventId,
      'ticket_id': ticketId,
      'quantity': quantity,
      'price': price,
      'description': description,
      'user': user?.toMap(),
      'event': event?.toMap(),
      'ticket': ticket?.toMap(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as int,
      userId: map['user_id'] as int,
      eventId: map['event_id'] as int,
      ticketId: map['ticket_id'] as int,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      price: map['price'] != null ? map['price'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      user: map['user'] != null ? User.fromMap(map['user'] as Map<String,dynamic>) : null,
      event: map['event'] != null ? Event.fromMap(map['event'] as Map<String,dynamic>) : null,
      ticket: map['ticket'] != null ? Ticket.fromMap(map['ticket'] as Map<String,dynamic>) : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'Event.dart';

class Ticket {
  int? id;
  final String name;
  String? description;
  String? price;
  int? quantity;
  final int eventId;
  DateTime salesStart;
  DateTime salesEnd;
  Event? event;
  DateTime createdAt;
  DateTime updatedAt;
  Ticket({
    this.id,
    required this.name,
    this.description,
    this.price,
    this.quantity,
    required this.eventId,
    required this.salesStart,
    required this.salesEnd,
    this.event,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'event_id': eventId,
      'sales_start': salesStart.toIso8601String(),
      'sales_end': salesEnd.toIso8601String(),
      'event': event?.toMap(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      eventId: map['event_id'] as int,
      salesStart: map['sales_start'] != null
          ? DateTime.parse(map['sales_start'] as String)
          : DateTime.now(),
      salesEnd: map['sales_end'] != null
          ? DateTime.parse(map['sales_end'] as String)
          : DateTime.now(),
      event: map['event'] != null
          ? Event.fromMap(map['event'] as Map<String, dynamic>)
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) =>
      Ticket.fromMap(json.decode(source) as Map<String, dynamic>);
}

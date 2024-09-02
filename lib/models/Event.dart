import 'dart:convert';

import 'Category.dart';
import 'Faq.dart';
import 'Ticket.dart';
import 'User.dart';
import 'Venue.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Event {
  int? id;
  final String name;
  final String slug;
  String? description;
  List<dynamic>? photos;
  final int venueId;
  final int categoryId;
   int? organizerId;
  String? guestCount;
  final DateTime dateTime;
  Category? category;
  Venue? venue;
  User? organizer;
  List<Ticket>? tickets;
  List<Faq>? faqs;
  DateTime createdAt;
  DateTime updatedAt;
  Event(
      {this.id,
      required this.name,
      required this.slug,
      this.description,
      this.photos,
      required this.venueId,
      required this.categoryId,
      this.organizerId,
      this.guestCount,
      required this.dateTime,
      this.category,
      this.venue,
      this.organizer,
      this.tickets,
      this.faqs,
      DateTime? createdAt,
      DateTime? updatedAt})
      : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'photos': photos?.toList(),
      'venue_id': venueId,
      'category_id': categoryId,
      'organizer_id': organizerId,
      'guest_count': guestCount,
      'date_time': dateTime.toIso8601String(),
      'category': category?.toMap(),
      'venue': venue?.toMap(),
      'organizer': organizer?.toMap(),
      'tickets': tickets?.map((x) => x.toMap()).toList(),
      'faqs': faqs?.map((x) => x.toMap()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id:map['id'] != null ? map['id'] as int : null,
      name:map['name'] as String,
      slug:map['slug'] as String,
      description:map['description'] != null ? map['description'] as String : null,
      photos:map['photos'] != null ? map['photos'] as List<dynamic> : null,
      venueId:map['venue_id'] as int,
      categoryId:map['category_id'] as int,
      organizerId:map['organizer_id']!= null ? map['organizer_id'] as int : null,
      guestCount:map['guest_count'] != null ? map['guest_count'] as String : null,
      dateTime:DateTime.parse(map['date_time'] as String),
      category:map['category'] != null ? Category.fromMap(map['category'] as Map<String,dynamic>) : null,
      venue:map['venue'] != null ? Venue.fromMap(map['venue'] as Map<String,dynamic>) : null,
      organizer:map['organizer'] != null ? User.fromMap(map['organizer'] as Map<String,dynamic>) : null,
      tickets:map['tickets'] != null ? List<Ticket>.from((map['tickets'] as List<dynamic>).map<Ticket?>((x) => Ticket.fromMap(x as Map<String,dynamic>),),) : null,
      faqs:map['faqs'] != null ? List<Faq>.from((map['faqs'] as List<dynamic>).map<Faq?>((x) => Faq.fromMap(x as Map<String,dynamic>),),) : null,
      createdAt:DateTime.parse(map['created_at'] as String),
      updatedAt:DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);
}

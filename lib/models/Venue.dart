import 'dart:convert';

import 'package:event_trace/models/Event.dart';
import 'package:event_trace/models/User.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Venue {
  int? id;
  final String name;
  String? address;
  final String phone;
  String? website;
  String? email;
  String? description;
  String? photos;
  final String slug;
  String? status;
  final String capacity;
  String? amenities;
  final int ownerId;
  User? owner;
  List<Event>? events;
  DateTime createdAt;
  DateTime updatedAt;
  Venue({
    this.id,
    required this.name,
    this.address,
    required this.phone,
    this.website,
    required this.email,
    this.description,
    this.photos,
    required this.slug,
    this.status,
    required this.capacity,
    this.amenities,
    required this.ownerId,
    this.owner,
    this.events,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'website': website,
      'email': email,
      'description': description,
     'photos': photos,
      'slug': slug,
      'status': status,
      'capacity': capacity,
      'amenities': amenities,
      'owner_id': ownerId,
      'owner': owner,
      'events': events?.map((x) => x.toMap()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Venue.fromMap(Map<String, dynamic> map) {
    return Venue(
      id: map['id'] == null ? null : map['id'] as int,
      name: map['name'] as String? ?? '',
      address: map['address'] == null ? null : map['address'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      website: map['website'] == null ? null : map['website'] as String? ?? '',
      email: map['email'] == null ? null : map['email'] as String? ?? '',
      description: map['description'] == null
          ? null
          : map['description'] as String? ?? '',
           photos: map['photos'] == null ? null : map['photos'] as String? ?? '',
      slug: map['slug'] as String? ?? '',
      status: map['status'] == null ? null : map['status'] as String? ?? '',
      capacity: map['capacity'] as String? ?? '',
      amenities:
          map['amenities'] == null ? null : map['amenities'] as String? ?? '',
      ownerId: map['owner_id'] as int? ?? 0,
      owner: map['owner'] != null
          ? User.fromMap(map['owner'] as Map<String, dynamic>)
          : null,
      events: map['events'] != null
          ? List<Event>.from((map['events'] as List)
              .map((x) => Event.fromMap(x as Map<String, dynamic>)))
          : null,
          
      createdAt: DateTime.parse(map['created_at'] as String? ?? ''),
      updatedAt: DateTime.parse(map['updated_at'] as String? ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Venue.fromJson(String source) =>
      Venue.fromMap(json.decode(source) as Map<String, dynamic>);
}

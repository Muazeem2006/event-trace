// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'Event.dart';
import 'User.dart';

class Promotion {
  int? id;
  final int userId;
  final int eventId;
  final String platform;
  final User user;
  final Event event;
  DateTime createdAt;
  DateTime updatedAt;
  Promotion({
    this.id,
    required this.userId,
    required this.eventId,
    required this.platform,
    required this.user,
    required this.event,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'event_id': eventId,
      'platform': platform,
      'user': user.toMap(),
      'event': event.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['user_id'] as int,
      eventId: map['event_id'] as int,
      platform: map['platform'] as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      event: Event.fromMap(map['event'] as Map<String, dynamic>),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Promotion.fromJson(String source) =>
      Promotion.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class Faq {
  int? id;
  final List<String> questions;
  final List<String> answers;
  DateTime createdAt;
  DateTime updatedAt;

  Faq({
    this.id,
    required this.questions,
    required this.answers,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'questions': questions,
      'answers': answers,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Faq.fromMap(Map<String, dynamic> map) {
    return Faq(
      id: map['id'] as int?,
      questions: List<String>.from(map['questions']),
      answers: List<String>.from(map['answers']),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Faq.fromJson(String source) =>
      Faq.fromMap(json.decode(source) as Map<String, dynamic>);
}

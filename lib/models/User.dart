import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  int? id;
  String? name;
  final String email;
  String? emailVerifiedAt;
  String? username;
  String? role;
  String? photo;
  String? password;
  String? phone;
  String? gender;
  String? dob;
  String? slug;
  DateTime createdAt;
  DateTime updatedAt;
  User({
    this.id,
    this.name,
    required this.email,
    this.emailVerifiedAt,
    this.username,
    this.role,
    this.photo,
    this.password,
    this.phone,
    this.gender,
    this.dob,
    this.slug,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'username': username,
      'role': role,
      'photo': photo,
      'password': password,
      'phone': phone,
      'gender': gender,
      'dob': dob,
      'slug': slug,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int? : null,
      name: map['name']!= null ? map['name'] as String? : null,
      email: map['email'] as String,
      emailVerifiedAt: map['email_verified_at'] != null ? map['email_verified_at'] as String? : null,
      username: map['username'] != null ? map['username'] as String? : null,
      role: map['role'] != null ? map['role'] as String? : null,
      photo: map['photo'] != null ? map['photo'] as String? : null,
      password: map['password'] != null ? map['password'] as String? : null,
      phone: map['phone'] != null ? map['phone'] as String? : null,
      gender: map['gender'] != null ? map['gender'] as String? : null,
      dob: map['dob'] != null ? map['dob'] as String? : null,
      slug: map['slug'] != null ? map['slug'] as String? : null,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}

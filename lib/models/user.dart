// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// This file contains the structure of the user similar to the Mongoose model.
class User {
  final String id; // MongoDB _id
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final String role; // Added role (Doctor or Patient)

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.role, // New role field
  });

  // Convert User object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'role': role, // Include role in the map
    };
  }

  // Create User object from a Map (from JSON response)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      role: map['role'] ?? '', // Handle missing role
    );
  }

  // Convert User object to JSON string
  String toJson() => json.encode(toMap());

  // Create User object from JSON string
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

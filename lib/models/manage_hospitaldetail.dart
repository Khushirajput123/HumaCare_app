// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// // class Hospital {
// //   final String name;
// //   final String location;
// //   final String phone;
// //   final String image;
// //   final String description;
// //   final List<Doctor> doctors;

// //   Hospital({
// //     required this.name,
// //     required this.location,
// //     required this.phone,
// //     required this.image,
// //     required this.description,
// //     required this.doctors,
// //   });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'name': name,
// //       'location': location,
// //       'phone': phone,
// //       'image': image,
// //       'description': description,
// //       'doctors': doctors.map((d) => d.toJson()).toList(),
// //     };
// //   }

// //   factory Hospital.fromJson(Map<String, dynamic> json) {
// //     return Hospital(
// //       name: json['name'],
// //       location: json['location'],
// //       phone: json['phone'],
// //       image: json['image'],
// //       description: json['description'],
// //       doctors: (json['doctors'] as List)
// //           .map((doc) => Doctor.fromJson(doc))
// //           .toList(),
// //     );
// //   }
// // }

// // class Doctor {
// //   String name;
// //   String specialization;
// //   bool available;

// //   Doctor({
// //     required this.name,
// //     required this.specialization,
// //     required this.available,
// //   });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'name': name,
// //       'specialization': specialization,
// //       'available': available,
// //     };
// //   }

// //   factory Doctor.fromJson(Map<String, dynamic> json) {
// //     return Doctor(
// //       name: json['name'],
// //       specialization: json['specialization'],
// //       available: json['available'],
// //     );
// //   }
// // }

// class Doctor {
//   String name;
//   String specialization;
//   bool available;

//   Doctor({
//     required this.name,
//     required this.specialization,
//     required this.available,
//   });

//   factory Doctor.fromJson(Map<String, dynamic> json) {
//     return Doctor(
//       name: json['name'],
//       specialization: json['specialization'],
//       available: json['available'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'specialization': specialization,
//       'available': available,
//     };
//   }
// }

// class Hospital {
//   final String hospitalId;
//   final String name;
//   final String location;
//   final String phone;
//   final String image;
//   final String description;
//   final List<Doctor> doctors;

//   Hospital({
//     required this.hospitalId,
//     required this.name,
//     required this.location,
//     required this.phone,
//     required this.image,
//     required this.description,
//     required this.doctors,
//   });

//   factory Hospital.fromJson(Map<String, dynamic> json) {
//     return Hospital(
//       hospitalId: json['hospitalId'] ?? '',
//       name: json['name'],
//       location: json['location'],
//       phone: json['phone'],
//       image: json['image'],
//       description: json['description'],
//       doctors: (json['doctors'] as List)
//           .map((doc) => Doctor.fromJson(doc))
//           .toList(),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'hospitalId': hospitalId,
//       'name': name,
//       'location': location,
//       'phone': phone,
//       'image': image,
//       'description': description,
//       'doctors': doctors.map((d) => d.toJson()).toList(),
//     };
//   }
// }

class Hospital {
  final String name;
  final String location;
  final String phone;
  final String image;
  final String description;
  final List<Doctor> doctors;

  Hospital({
    required this.name,
    required this.location,
    required this.phone,
    required this.image,
    required this.description,
    required this.doctors,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'phone': phone,
      'image': image,
      'description': description,
      'doctors': doctors.map((d) => d.toJson()).toList(),
    };
  }

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'],
      location: json['location'],
      phone: json['phone'],
      image: json['image'],
      description: json['description'],
      doctors: (json['doctors'] as List)
          .map((doc) => Doctor.fromJson(doc))
          .toList(),
    );
  }
}

class Doctor {
  String name;
  String specialization;
  bool available;

  Doctor({
    required this.name,
    required this.specialization,
    required this.available,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialization': specialization,
      'available': available,
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      specialization: json['specialization'],
      available: json['available'],
    );
  }
}
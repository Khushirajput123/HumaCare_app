// class HospitalResponse {
//   final String source;
//   final HospitalDetail details;
//   final List<Doctor> doctors;

//   HospitalResponse({
//     required this.source,
//     required this.details,
//     required this.doctors,
//   });

//   factory HospitalResponse.fromJson(Map<String, dynamic> json) {
//     return HospitalResponse(
//       source: json['source'],
//       details: HospitalDetail.fromJson(json['details']),
//       doctors: (json['doctors'] as List)
//           .map((d) => Doctor.fromJson(d))
//           .toList(),
//     );
//   }
// }

// class HospitalDetail {
//   final String name;
//   final String location;
//   final String phone;
//   final String description;
//   final String image;

//   HospitalDetail({
//     required this.name,
//     required this.location,
//     required this.phone,
//     required this.description,
//     required this.image,
//   });

//   factory HospitalDetail.fromJson(Map<String, dynamic> json) {
//     return HospitalDetail(
//       name: json['name'] ?? 'Unknown',
//       location: json['location'] ?? 'Unknown',
//       phone: json['phone'] ?? 'xxxxxxxxxx',
//       description: json['description'] ?? 'No description available.',
//       image: json['image'] ?? 'https://via.placeholder.com/150',
//     );
//   }
// }

// class Doctor {
//   final String name;
//   final String specialization;

//   Doctor({
//     required this.name,
//     required this.specialization,
//   });

//   factory Doctor.fromJson(Map<String, dynamic> json) {
//     return Doctor(
//       name: json['name'],
//       specialization: json['specialization'],
//     );
//   }
// }

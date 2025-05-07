
// import 'package:flutter/material.dart';

// class HospitalDetailDatabaseScreen extends StatelessWidget {
//   final dynamic hospitalData;

//   const HospitalDetailDatabaseScreen({Key? key, required this.hospitalData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<dynamic> doctors = hospitalData['doctors'] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(hospitalData['name'] ?? 'Hospital Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Hospital Image
//             if (hospitalData['image'] != null)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   hospitalData['image'],
//                   width: double.infinity,
//                   height: 200,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     height: 200,
//                     color: Colors.grey[300],
//                     child: const Center(child: Icon(Icons.image_not_supported)),
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 16),

//             // Hospital Info
//             Text("Name: ${hospitalData['name']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             Text("Phone: ${hospitalData['phone'] ?? 'Not provided'}"),
//             const SizedBox(height: 8),
//             Text("Location: ${hospitalData['location'] ?? 'Not provided'}"),
//             const SizedBox(height: 8),
//             Text("Description: ${hospitalData['description'] ?? 'Not provided'}"),
//             const SizedBox(height: 16),

//             // Doctor List
//             Text("Doctors Available:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),

//             if (doctors.isEmpty)
//               const Text("No doctors available currently."),
//             ...doctors.map((doc) {
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 6),
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 child: ListTile(
//                   leading: const Icon(Icons.person),
//                   title: Text(doc['name'] ?? 'No Name'),
//                   subtitle: Text("Specialization: ${doc['specialization'] ?? 'N/A'}"),
//                   trailing: Icon(
//                     doc['available'] == true ? Icons.check_circle : Icons.cancel,
//                     color: doc['available'] == true ? Colors.green : Colors.red,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:huma_care/constants/global_variable.dart';


// class HospitalDetailDatabaseScreen extends StatelessWidget {
//   final Map<String, dynamic> hospitalData;

//   const HospitalDetailDatabaseScreen({super.key, required this.hospitalData});

//   @override
//   Widget build(BuildContext context) {
//     final String name = hospitalData['name'] ?? 'No Name';
//     final String location = hospitalData['location'] ?? 'No Location';
//     final String phone = hospitalData['phone'] ?? 'No Phone';
//     final String description = hospitalData['description'] ?? 'No Description';
//     final String image = hospitalData['image'] ?? '';
//     final List<dynamic> doctors = hospitalData['doctors'] ?? [];

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // HEADER SECTION
//             Container(
//               width: double.infinity,
//               color: GlobalVariables.secondaryColor,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
//                 child: Stack(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.more_vert, color: Colors.black),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         const SizedBox(height: 40),
//                         CircleAvatar(
//                           radius: 80,
//                           backgroundImage: (image.isNotEmpty)
//                               ? NetworkImage(image)
//                               : const AssetImage("assets/images/default_hospital.jpg") as ImageProvider,
//                         ),
//                         const SizedBox(height: 15),
//                         Text(
//                           name,
//                           style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _buildIcon(Icons.call),
//                             const SizedBox(width: 20),
//                             _buildIcon(Icons.chat_bubble),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // DETAILS SECTION
//             Container(
//               width: double.infinity,
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailSection("Name", name),
//                   _buildDetailSection("Phone", phone),
//                   _buildDetailSection("Location", location),
//                   _buildDetailSection("Description", description),

//                   const Divider(thickness: 1),
//                   Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Text("Doctors Available", style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
//                   ),

//                   if (doctors.isEmpty)
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Text("No doctors available currently."),
//                     )
//                   else
//                     ...doctors.map((doc) => _buildDoctorCard(doc)).toList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIcon(IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(color: Color(0xFF9F97E2), shape: BoxShape.circle),
//       child: Icon(icon, color: Colors.white, size: 25),
//     );
//   }

//   Widget _buildDetailSection(String title, String content) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
//           const SizedBox(height: 5),
//           Text(content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54)),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorCard(dynamic doctor) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: const Icon(Icons.person),
//         title: Text(doctor['name'] ?? 'No Name'),
//         subtitle: Text("Specialization: ${doctor['specialization'] ?? 'N/A'}"),
//         trailing: Icon(
//           doctor['available'] == true ? Icons.check_circle : Icons.cancel,
//           color: doctor['available'] == true ? Colors.green : Colors.red,
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:huma_care/constants/global_variable.dart';

// class HospitalDetailDatabaseScreen extends StatelessWidget {
//   final Map<String, dynamic> hospitalData;

//   const HospitalDetailDatabaseScreen({super.key, required this.hospitalData});

//   @override
//   Widget build(BuildContext context) {
//     final String name = hospitalData['name'] ?? 'No Name';
//     final String location = hospitalData['location'] ?? 'No Location';
//     final String phone = hospitalData['phone'] ?? 'No Phone';
//     final String description = hospitalData['description'] ?? 'No Description';
//     final String image = hospitalData['image'] ?? '';
//     final List<dynamic> doctors = hospitalData['doctors'] ?? [];

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // HEADER SECTION
//             Container(
//               width: double.infinity,
//               color: GlobalVariables.secondaryColor,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
//                 child: Stack(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.more_vert, color: Colors.black),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         const SizedBox(height: 40),
//                         CircleAvatar(
//                           radius: 80,
//                           backgroundImage: (image.isNotEmpty)
//                               ? NetworkImage(image)
//                               : const AssetImage("assets/images/default_hospital.jpg") as ImageProvider,
//                         ),
//                         const SizedBox(height: 15),
//                         Text(
//                           name,
//                           style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _buildIcon(Icons.call),
//                             const SizedBox(width: 20),
//                             _buildIcon(Icons.chat_bubble),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // DETAILS SECTION
//             Container(
//               width: double.infinity,
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailSection("Name", name),
//                   _buildDetailSection("Phone", phone),
//                   _buildDetailSection("Location", location),
//                   _buildDetailSection("Description", description),

//                   const Divider(thickness: 1),
//                   const Padding(
//                     padding: EdgeInsets.all(15),
//                     child: Text("Doctors Available", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
//                   ),

//                   if (doctors.isEmpty)
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Text("No doctors available currently."),
//                     )
//                   else
//                     ...doctors.map((doc) => _buildDoctorCard(doc, context)).toList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIcon(IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(color: Color(0xFF9F97E2), shape: BoxShape.circle),
//       child: Icon(icon, color: Colors.white, size: 25),
//     );
//   }

//   Widget _buildDetailSection(String title, String content) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
//           const SizedBox(height: 5),
//           Text(content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54)),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorCard(dynamic doctor, BuildContext context) {
//     final bool isAvailable = doctor['available'] == true;
//     final String doctorName = doctor['name'] ?? 'No Name';
//     final String specialization = doctor['specialization'] ?? 'N/A';

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 25,
//                   child: Icon(Icons.person, size: 30),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         doctorName,
//                         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Specialization: $specialization",
//                         style: const TextStyle(color: Colors.black54),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   isAvailable ? Icons.check_circle : Icons.cancel,
//                   color: isAvailable ? Colors.green : Colors.red,
//                   size: 28,
//                 ),
//               ],
//             ),
//             if (isAvailable) ...[
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // TODO: Navigate to booking screen or show appointment dialog
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Booking appointment with Dr. $doctorName")),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: GlobalVariables.secondaryColor,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text("Book Appointment", style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/features/home/patient/appointment_screen.dart';


class HospitalDetailDatabaseScreen extends StatelessWidget {
  final Map<String, dynamic> hospitalData;

  const HospitalDetailDatabaseScreen({super.key, required this.hospitalData});

  @override
  Widget build(BuildContext context) {
    final String name = hospitalData['name'] ?? 'No Name';
    final String location = hospitalData['location'] ?? 'No Location';
    final String phone = hospitalData['phone'] ?? 'No Phone';
    final String description = hospitalData['description'] ?? 'No Description';
    final String image = hospitalData['image'] ?? '';
    final List<dynamic> doctors = hospitalData['doctors'] ?? [];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER SECTION
            Container(
              width: double.infinity,
              color: GlobalVariables.secondaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 40),
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: (image.isNotEmpty)
                              ? NetworkImage(image)
                              : const AssetImage("assets/images/default_hospital.jpg") as ImageProvider,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          name,
                          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIcon(Icons.call),
                            const SizedBox(width: 20),
                            _buildIcon(Icons.chat_bubble),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // DETAILS SECTION
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection("Name", name),
                  _buildDetailSection("Phone", phone),
                  _buildDetailSection("Location", location),
                  _buildDetailSection("Description", description),

                  const Divider(thickness: 1),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Doctors Available", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                  ),

                  if (doctors.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("No doctors available currently."),
                    )
                  else
                    ...doctors.map((doc) => _buildDoctorCard(doc, context)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color(0xFF9F97E2), shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 25),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
          const SizedBox(height: 5),
          Text(content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(dynamic doctor, BuildContext context) {
    final bool isAvailable = doctor['available'] == true;
    final String doctorName = doctor['name'] ?? 'No Name';
    final String specialization = doctor['specialization'] ?? 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Specialization: $specialization",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isAvailable ? Icons.check_circle : Icons.cancel,
                  color: isAvailable ? Colors.green : Colors.red,
                  size: 28,
                ),
              ],
            ),
            if (isAvailable) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentScreen(doctor: doctor),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.secondaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Book Appointment", style: TextStyle(color: Colors.white)),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

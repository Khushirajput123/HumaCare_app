// import 'package:flutter/material.dart';
// import 'package:huma_care/constants/global_variable.dart';
// import 'package:huma_care/features/home/patient/appointment_screen.dart';
// import 'package:huma_care/search/services/hospital_detailservice.dart';

// class HospitalDetailScreen extends StatefulWidget {
//   final dynamic hospitalData;

//   const HospitalDetailScreen({Key? key, required this.hospitalData, }) : super(key: key);

//   @override
//   _HospitalDetailScreenState createState() => _HospitalDetailScreenState();
// }

// class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
//   Map<String, dynamic>? hospitalDetails;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchHospitalDetails();
//   }

//   Future<void> _fetchHospitalDetails() async {
//     try {
//       final data = await HospitalDetailService.fetchHospitalDetails(widget.hospitalData);
//       setState(() {
//         hospitalDetails = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : hospitalDetails == null
//               ? Center(child: Text("Hospital details not found"))
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // Top header section with background color
//                       Container(
//                         width: double.infinity,
//                         color: GlobalVariables.secondaryColor,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
//                           child: Stack(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
//                                     onPressed: () => Navigator.pop(context),
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.more_vert, color: Colors.black),
//                                     onPressed: () {},
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   SizedBox(height: 40),
//                                   CircleAvatar(
//                                     radius: 80,
//                                     backgroundImage:AssetImage("assets/images/default_hospital.jpg") as ImageProvider ,
//                                     // backgroundImage: hospitalDetails!["details"]["image"] != "Not available"
//                                     //     ? NetworkImage(hospitalDetails!["details"]["image"])
//                                     //     : AssetImage("assets/images/default_hospital.jpg") as ImageProvider,
//                                   ),
//                                   SizedBox(height: 15),
//                                   Text(
//                                     widget.hospitalData,
//                                     style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       _buildIcon(Icons.call),
//                                       SizedBox(width: 20),
//                                       _buildIcon(Icons.chat_bubble),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       // Main content starting with white background
//                       Container(
//                         width: double.infinity,
//                         color: Colors.white,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildDetailSection("Speciality", "Multi-speciality hospital offering services in various medical fields."),
//                             _buildDetailSection("Phone", hospitalDetails!["details"]["phone"] ?? "Not available"),
//                             _buildDetailSection("Website", hospitalDetails!["details"]["website"] ?? "Not available"),
//                             _buildDoctorSection(),
//                             _buildLocationSection(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _buildIcon(IconData icon) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(color: Color(0xFF9F97E2), shape: BoxShape.circle),
//       child: Icon(icon, color: Colors.white, size: 25),
//     );
//   }

//   Widget _buildDetailSection(String title, String content) {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, color: Colors.black)),
//           SizedBox(height: 5),
//           Text(content, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorSection() {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Best Doctors", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
//           SizedBox(height: 10),
//           ...hospitalDetails!["doctors"].map<Widget>((doctor) => _buildDoctorRow(doctor)).toList(),
//         ],
//       ),
//     );
//   }

//   // Widget _buildDoctorRow(Map<String, dynamic> doctor) {
//   //   return ListTile(
//   //     leading: CircleAvatar(
//   //       radius: 20,
//   //       backgroundImage: AssetImage("assets/images/default_ospital.jpg"),
//   //     ),
//   //     title: Text(doctor["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54)),
//   //     subtitle: Text(doctor["specialization"], style: TextStyle(fontSize: 14, color: Colors.black45)),
//   //   );
//   // }
//   Widget _buildDoctorRow(Map<String, dynamic> doctor) {
//   return ListTile(
//     leading: CircleAvatar(
//       radius: 20,
//       backgroundImage: AssetImage("assets/images/default_ospital.jpg"),
//     ),
//     title: Text(doctor["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54)),
//     subtitle: Text(doctor["specialization"], style: TextStyle(fontSize: 14, color: Colors.black45)),
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AppointmentScreen(doctor: doctor),
//         ),
//       );
//     },
//   );
// }


//   Widget _buildLocationSection() {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Location", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23)),
//           ListTile(
//             leading: Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(color: Color(0xFFF0EEFA), shape: BoxShape.circle),
//               child: Icon(Icons.location_on, color: Color(0xFF7165D6), size: 30),
//             ),
//             title: Text(hospitalDetails!["details"]["address"]["road"] ?? "Address not available",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//           ),
//           Divider(height: 20),
//         ],
//       ),
//     );
//   }
// }


// HospitalDetailScreen.dart
import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';

class HospitalDetailScreen extends StatefulWidget {
  final dynamic hospitalData;

  const HospitalDetailScreen({Key? key, required this.hospitalData}) : super(key: key);

  @override
  _HospitalDetailScreenState createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  Map<String, dynamic>? hospitalDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    hospitalDetails = widget.hospitalData;
    isLoading = false; // Directly use the passed data for now
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospitalDetails!['name'] ?? 'Unknown Hospital'),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hospitalDetails == null
              ? Center(child: Text("Hospital details not found"))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Top header section with background color
                      Container(
                        width: double.infinity,
                        color: GlobalVariables.secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 40),
                              CircleAvatar(
                                radius: 80,
                                backgroundImage: hospitalDetails!["image"] != "Not available"
                                    ? NetworkImage(hospitalDetails!["image"])
                                    : AssetImage("assets/images/default_hospital.jpg") as ImageProvider,
                              ),
                              SizedBox(height: 15),
                              Text(
                                hospitalDetails!["name"] ?? "Unknown",
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              // Add more sections as needed
                            ],
                          ),
                        ),
                      ),
                      // Main content starting with white background
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailSection("Speciality", "Multi-speciality hospital offering services in various medical fields."),
                            _buildDetailSection("Phone", hospitalDetails!["phone"] ?? "Not available"),
                            _buildDetailSection("Website", hospitalDetails!["website"] ?? "Not available"),
                            _buildLocationSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, color: Colors.black)),
          SizedBox(height: 5),
          Text(content, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23)),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Color(0xFFF0EEFA), shape: BoxShape.circle),
              child: Icon(Icons.location_on, color: Color(0xFF7165D6), size: 30),
            ),
            title: Text(hospitalDetails!["address"]?["road"] ?? "Address not available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Divider(height: 20),
        ],
      ),
    );
  }
}

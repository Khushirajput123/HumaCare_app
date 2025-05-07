// import 'package:flutter/material.dart';
// import 'package:huma_care/search/screen/hospital_detail_realtime.dart';
// import 'package:huma_care/search/screen/hospital_detalildatabase.dart';
// import 'package:huma_care/search/services/hospital_detailservice.dart';


// class HospitalDetailScreen extends StatefulWidget {
//   final String hospitalName;

//   HospitalDetailScreen({required this.hospitalName});

//   @override
//   _HospitalDetailScreenState createState() => _HospitalDetailScreenState();
// }

// class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
//   late Future<Map<String, dynamic>?> hospitalDetails;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch hospital details by name
//     hospitalDetails = HospitalDetailService.fetchHospitalDetails(widget.hospitalName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.hospitalName)),
//       body: FutureBuilder<Map<String, dynamic>?>(
//         future: hospitalDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('Hospital details not found.'));
//           }

//           var hospitalData = snapshot.data!;
//           var source = hospitalData['source']; // "database" or "osm"

//           if (source == 'database') {
//             return HospitalDetailFromDatabaseScreen(details: hospitalData['details']);
//           } else {
//             return HospitalDetailFromOSMScreen(details: hospitalData['details'], doctors: hospitalData['doctors']);
//           }
//         },
//       ),
//     );
//   }
// }

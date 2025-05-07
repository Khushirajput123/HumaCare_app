// import 'package:flutter/material.dart';
// import 'package:huma_care/provider/user_provider.dart';
// import 'package:huma_care/search/screen/hospital_detailscreen.dart';
// import 'package:huma_care/search/services/search_service.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   final String searchQuery;

//   const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   List<dynamic> hospitals = [];
//   bool isLoading = true;
//   bool isError = false;
//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _searchController.text = widget.searchQuery;
//     _fetchHospitals();
//   }

//   Future<void> _fetchHospitals() async {
//     setState(() {
//       isLoading = true;
//       isError = false;
//     });

//     try {
//       final results = await SearchService.fetchHospitals(widget.searchQuery);
//       setState(() {
//         hospitals = results ?? [];
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isError = true;
//         isLoading = false;
//       });
//       print("Error fetching hospitals: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Hello ${user.name}",
//           style: TextStyle(
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Color(0xFF7165D6),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 10),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 22,
//                   backgroundImage: AssetImage("assets/username.jpg"),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(child: _buildSearchBar()),
//               ],
//             ),
//           ),
//           Expanded(
//             child: isLoading
//                 ? Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         CircularProgressIndicator(),
//                         SizedBox(height: 10),
//                         Text("Searching for hospitals..."),
//                       ],
//                     ),
//                   )
//                 : isError
//                     ? Center(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Icons.error, color: Colors.red, size: 40),
//                             SizedBox(height: 10),
//                             Text("Failed to fetch hospitals. Try again."),
//                             SizedBox(height: 10),
//                             ElevatedButton(
//                               onPressed: _fetchHospitals,
//                               child: Text("Retry"),
//                             ),
//                           ],
//                         ),
//                       )
//                     : hospitals.isEmpty
//                         ? Center(child: Text("No hospitals found"))
//                         : GridView.builder(
//                             padding: EdgeInsets.all(10),
//                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               crossAxisSpacing: 10,
//                               mainAxisSpacing: 10,
//                               childAspectRatio: 0.8,
//                             ),
//                             itemCount: hospitals.length,
//                             itemBuilder: (context, index) {
//                               final hospital = hospitals[index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => HospitalDetailScreen(
//                                         name: hospital['name'],
//                                         lat: double.tryParse(hospital['lat'].toString()) ?? 0.0,
//                                         lon: double.tryParse(hospital['lon'].toString()) ?? 0.0,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: _buildHospitalCard(hospital),
//                               );
//                             },
//                           ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHospitalCard(Map<String, dynamic> hospital) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           hospital['image'] != null && hospital['image'].toString().isNotEmpty
//               ? Image.network(
//                   hospital['image'],
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Icon(Icons.local_hospital, size: 80, color: Colors.grey),
//                 )
//               : Icon(Icons.local_hospital, size: 80, color: Colors.grey),
//           SizedBox(height: 10),
//           Text(
//             hospital['name'] ?? 'Unknown Hospital',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 5),
//           Text("Rating: ${hospital['rating'] ?? 'Not available'}"),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: _searchController,
//         onSubmitted: (query) {
//           if (query.isNotEmpty && query != widget.searchQuery) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SearchScreen(searchQuery: query),
//               ),
//             );
//           }
//         },
//         decoration: InputDecoration(
//           hintText: "Search hospitals",
//           border: InputBorder.none,
//           suffixIcon: IconButton(
//             icon: Icon(Icons.search, color: Color(0xFF7165D6)),
//             onPressed: () {
//               String query = _searchController.text.trim();
//               if (query.isNotEmpty && query != widget.searchQuery) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SearchScreen(searchQuery: query),
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:huma_care/provider/user_provider.dart';
import 'package:huma_care/search/screen/hospital_detail_realtime.dart';
import 'package:huma_care/search/screen/hospital_detailscreen.dart';
import 'package:huma_care/search/screen/hospital_detalildatabase.dart';
import 'package:huma_care/search/services/hospital_detailservice.dart';
import 'package:huma_care/search/services/search_service.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> hospitals = [];
  bool isLoading = true;
  bool isError = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
    _fetchHospitals();
  }

  Future<void> _fetchHospitals() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final results = await SearchService.fetchHospitals(widget.searchQuery);
      setState(() {
        hospitals = results ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
      print("Error fetching hospitals: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Hello ${user.name}",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF7165D6),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage("assets/username.jpg"),
                ),
                SizedBox(width: 10),
                Expanded(child: _buildSearchBar()),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Searching for hospitals..."),
                      ],
                    ),
                  )
                : isError
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 40),
                            SizedBox(height: 10),
                            Text("Failed to fetch hospitals. Try again."),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _fetchHospitals,
                              child: Text("Retry"),
                            ),
                          ],
                        ),
                      )
                    : hospitals.isEmpty
                        ? Center(child: Text("No hospitals found"))
                        : GridView.builder(
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: hospitals.length,
                            itemBuilder: (context, index) {
                              final hospital = hospitals[index];

                              // Ensure hospital data is not null before accessing
                              final name =
                                  hospital['name'] ?? 'Unknown Hospital';
                              final rating =
                                  hospital['rating'] ?? 'Not available';
                              final imageUrl =
                                  hospital['image'] ?? 'default_image_url';

                              // Ensure source exists
                              final source = hospital['source'] ??
                                  'unknown'; // Default to 'unknown'

                              return GestureDetector(
                                // onTap: ()
                                onTap: () async {
  final name = hospital['name'];

  final details = await HospitalDetailService.fetchHospitalDetails(name);

  if (details == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to load hospital details"))
    );
    return;
  }

  if (details['source'] == 'database') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HospitalDetailDatabaseScreen(hospitalData: details['details']),
      ),
    );
  } else if (details['source'] == 'osm') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HospitalDetailScreen(hospitalData: details['details']),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Unknown source")),
    );
  }
},

                                child:
                                    _buildHospitalCard(name, rating, imageUrl),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard(String name, String rating, String imageUrl) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.local_hospital, size: 80, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text("Rating: $rating"),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onSubmitted: (query) {
          if (query.isNotEmpty && query != widget.searchQuery) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(searchQuery: query),
              ),
            );
          }
        },
        decoration: InputDecoration(
          hintText: "Search hospitals",
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Color(0xFF7165D6)),
            onPressed: () {
              String query = _searchController.text.trim();
              if (query.isNotEmpty && query != widget.searchQuery) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(searchQuery: query),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

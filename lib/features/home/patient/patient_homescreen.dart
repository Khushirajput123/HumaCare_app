


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:huma_care/search/screen/hospital_detail_realtime.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:huma_care/search/screen/hospital_detailscreen.dart';
import 'package:huma_care/search/screen/search_screen.dart';
import 'package:huma_care/provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isManualAddress = false;
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String currentLocation = "Fetching location...";
  List<dynamic> hospitals = [];
  bool isLoading = false;

  File? _profileImage;
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null && mounted) {
      setState(() => _profileImage = File(imagePath));
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', picked.path);
      setState(() => _profileImage = File(picked.path));
    }
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse("https://ipapi.co/json/"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final lat = data["latitude"].toString();
        final lon = data["longitude"].toString();
        setState(() => currentLocation = "${data['city']}, ${data['region']}");
        await _fetchHospitals(lat, lon);
      } else {
        setState(() => currentLocation = "Location unavailable");
      }
    } catch (e) {
      print("Error fetching location: $e");
      setState(() => currentLocation = "Error fetching location");
    }
    setState(() => isLoading = false);
  }

  Future<void> _fetchLocationFromAddress(String address) async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse("https://nominatim.openstreetmap.org/search?format=json&q=$address"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = data[0]['lat'];
          final lon = data[0]['lon'];
          setState(() => currentLocation = address);
          await _fetchHospitals(lat.toString(), lon.toString());
        } else {
          setState(() => currentLocation = "Location not found");
        }
      }
    } catch (e) {
      print("Error fetching address: $e");
      setState(() => currentLocation = "Error fetching address");
    }
    setState(() => isLoading = false);
  }

  Future<void> _fetchHospitals(String lat, String lon) async {
    setState(() => isLoading = true);
    try {
      final url = Uri.parse("https://overpass-api.de/api/interpreter?data=[out:json];node(around:5000,$lat,$lon)[amenity=hospital];out;");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final hospitalList = data["elements"] ?? [];
        setState(() => hospitals = hospitalList);
      }
    } catch (e) {
      print("Error fetching hospitals: $e");
    }
    setState(() => isLoading = false);
  }

  void _onSearch() {
    if (searchController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchScreen(searchQuery: searchController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Color(0xFF7165D6),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage("assets/username.jpg") as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(user.name, style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text(user.email ?? "user@example.com", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('My Appointments'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile Settings'),
              onTap: () {
                // TODO: Navigate to profile settings
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              onTap: () {
                // TODO: Navigate to support screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // TODO: Handle logout logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF7165D6),
        centerTitle: true,
        title: Text(
          "Hello ${user.name}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage("assets/username.jpg") as ImageProvider,
                ),
                SizedBox(width: 10),
                Expanded(child: _buildSearchBar()),
              ],
            ),
          ),
          SizedBox(height: 15),
          _buildLocationToggle(),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text("Nearby Hospitals", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black54)),
          ),
          SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : hospitals.isEmpty
                    ? Center(child: Text("No hospitals found. Try another location."))
                    : _buildHospitalGrid(),
          ),
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
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search hospitals",
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Color(0xFF7165D6)),
            onPressed: _onSearch,
          ),
        ),
        onSubmitted: (_) => _onSearch(),
      ),
    );
  }

  Widget _buildLocationToggle() {
    return Row(
      children: [
        Expanded(
          child: isManualAddress
              ? TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Enter an address",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.location_on, color: Color(0xFF7165D6)),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) _fetchLocationFromAddress(value);
                  },
                )
              : Text("  Current Location: $currentLocation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Switch(
          value: isManualAddress,
          onChanged: (value) {
            setState(() {
              isManualAddress = value;
              if (!value) _fetchCurrentLocation();
            });
          },
        ),
      ],
    );
  }

  Widget _buildHospitalGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: hospitals.length,
      itemBuilder: (context, index) {
        final hospital = hospitals[index];
        final name = hospital['tags']?['name'] ?? 'Unknown Hospital';
        final lat = hospital['lat'];
        final lon = hospital['lon'];

        return GestureDetector(
          onTap: () {
            if (lat != null && lon != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HospitalDetailScreen(
                    hospitalData: hospital,
                  ),
                ),
              );
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_hospital, size: 40, color: Color(0xFF7165D6)),
                  SizedBox(height: 10),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Lat: $lat, Lon: $lon",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

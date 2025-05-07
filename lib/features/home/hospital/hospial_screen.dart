

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:huma_care/features/home/hospital/manage_hospitaldetailscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:huma_care/features/home/hospital/hospital_profile.dart';


class HospitalDashboardScreen extends StatefulWidget {
  const HospitalDashboardScreen({super.key});

  @override
  State<HospitalDashboardScreen> createState() => _HospitalDashboardScreenState();
}

class _HospitalDashboardScreenState extends State<HospitalDashboardScreen> {
  String hospitalName = "City Hospital";
  String hospitalLocation = "Downtown, City";
  String hospitalImage = "";

  @override
  void initState() {
    super.initState();
    loadHospitalDetails();
  }

  Future<void> loadHospitalDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hospitalName = prefs.getString('hospital_name') ?? hospitalName;
      hospitalLocation = prefs.getString('hospital_location') ?? hospitalLocation;
      hospitalImage = prefs.getString('hospital_image') ?? hospitalImage;
    });
  }

  void navigateToProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HospitalProfileScreen(
          hospitalName: hospitalName,
          hospitalLocation: hospitalLocation,
          hospitalImage: hospitalImage,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        hospitalName = result["name"];
        hospitalLocation = result["location"];
        hospitalImage = result["image"];
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('hospital_name', hospitalName);
      await prefs.setString('hospital_location', hospitalLocation);
      await prefs.setString('hospital_image', hospitalImage);
    }
  }

  void navigateToAvailability() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditHospitalDetailScreen()
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Doctor availability updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (hospitalImage.isNotEmpty) {
      imageProvider = (hospitalImage.startsWith("http")
          ? NetworkImage(hospitalImage)
          : FileImage(File(hospitalImage))) as ImageProvider<Object>?;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hospital Dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7165D6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: navigateToProfile,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: imageProvider != null
                      ? CircleAvatar(radius: 20, backgroundImage: imageProvider)
                      : const Icon(Icons.local_hospital, size: 40, color: Color(0xFF7165D6)),
                  title: Text(hospitalName,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  subtitle: Text("Location: $hospitalLocation"),
                  trailing: const Icon(Icons.info, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildDashboardItem(Icons.person_add, "Doctor Requests", () {
                    Navigator.pushNamed(context, '/doctor-requests');
                  }),
                  _buildDashboardItem(Icons.verified_user, "Hired Doctors", () {
                    Navigator.pushNamed(context, '/hired-doctors');
                  }),
                  _buildDashboardItem(Icons.schedule, "Manage Availability", navigateToAvailability),
                  _buildDashboardItem(Icons.analytics, "Hospital Stats", () {
                    Navigator.pushNamed(context, '/hospital-stats');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF7165D6)),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
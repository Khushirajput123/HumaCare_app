import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/features/home/doctor/doctor_profile.dart';
import 'package:provider/provider.dart';
import 'package:huma_care/provider/user_provider.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GlobalVariables.secondaryColor,
        centerTitle: true,
        title: Text(
          'Hello ${user.name}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _DashboardTile(
               title: 'Profile',
              icon: Icons.person_outline,
          color: Colors.pinkAccent,
              onTap: () {
                // TODO: Navigate to Profile Screen
                Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DoctorProfileScreen()),
);
              },
            ),   
              
            _DashboardTile(
              title: 'Apply to Hospitals',
              icon: Icons.local_hospital_outlined,
              color: Colors.green,
              onTap: () {
                // TODO: Navigate to Apply Hospitals Screen
              },
            ),
            _DashboardTile(
              title: 'Hospital Offers',
              icon: Icons.link_outlined,
              color: Colors.deepPurple,
              onTap: () {
                // TODO: Navigate to Hospital Offers Screen
              },
            ),
            _DashboardTile(
              title: 'Hired Status',
              icon: Icons.verified_user,
              color: Colors.teal,
              onTap: () {
                // TODO: Navigate to Hired Status Screen
              },
            ),
            _DashboardTile(
              title: 'Consultation History',
              icon: Icons.history,
              color: Colors.orangeAccent,
              onTap: () {
                // TODO: Navigate to Consultation History Screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFF9F9F9),
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3B3B3B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

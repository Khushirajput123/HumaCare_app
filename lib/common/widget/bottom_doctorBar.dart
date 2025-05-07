import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/features/home/doctor/doctor_screen.dart';
import 'package:huma_care/features/home/patient/message.dart';

import 'package:huma_care/settings/screen/setting_screen.dart';

class BottomBarDoctor extends StatefulWidget {
  static const String routeName = '/doctor-home';
  const BottomBarDoctor({super.key});

  @override
  State<BottomBarDoctor> createState() => _BottomBarDoctorState();
}

class _BottomBarDoctorState extends State<BottomBarDoctor> {
  int _currentPage = 0;
  final double _bottomBarWidth = 42;
  final double _bottomBarBorderWidth = 5;

  final List<Widget> _pages = [
     DoctorDashboardScreen(),
        Center(
    child: Text('Appointment page'),
   ),
    const MessageScreen(),
    const SettingsScreen(),
  ];

  void _updatePage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: _updatePage,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavItem(Icons.dashboard, 'Dashboard', 0),
          _buildBottomNavItem(Icons.event_note, 'Appointments', 1),
          _buildBottomNavItem(Icons.chat_bubble_outline, 'Messages', 2),
          _buildBottomNavItem(Icons.settings, 'Settings', 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        width: _bottomBarWidth,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _currentPage == index
                  ? GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
              width: _bottomBarBorderWidth,
            ),
          ),
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}

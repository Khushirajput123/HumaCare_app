import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/features/home/hospital/hospial_screen.dart';

import 'package:huma_care/settings/screen/setting_screen.dart';

class BottomBarHospital extends StatefulWidget {
  static const String routeName = '/hospital-home';
  const BottomBarHospital({super.key});

  @override
  State<BottomBarHospital> createState() => _BottomBarHospitalState();
}

class _BottomBarHospitalState extends State<BottomBarHospital> {
  int _page = 0;
  final double bottomBarWidth = 42;
  final double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HospitalDashboardScreen(),
    const Center(child: Text('Messages Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Doctors Management', style: TextStyle(fontSize: 24))),
    const SettingsScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.dashboard, 0),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.message_outlined, 1),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.medical_services_outlined, 2),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.settings_outlined, 3),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Container(
      width: bottomBarWidth,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: _page == index
                ? GlobalVariables.selectedNavBarColor
                : GlobalVariables.backgroundColor,
            width: bottomBarBorderWidth,
          ),
        ),
      ),
      child: Icon(icon),
    );
  }
}

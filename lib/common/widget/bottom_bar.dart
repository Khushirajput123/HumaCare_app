import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/features/home/patient/message.dart';
import 'package:huma_care/features/home/patient/patient_homescreen.dart';
import 'package:huma_care/settings/screen/setting_screen.dart';


class BottomBarPatient extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBarPatient({super.key});

  @override
  State<BottomBarPatient> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBarPatient> {
  int _page = 0; // Track the current index
  final double bottomBarWidth = 42;
  final double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    HomeScreen(),
    MessageScreen(),
    SettingsScreen()
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
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home),
            ),
            label: 'Home',
          ),
          // MESSAGES
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.message_outlined),
            ),
            label: 'Messages',
          ),
          // SETTINGS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.settings_outlined),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

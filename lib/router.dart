
import 'package:flutter/material.dart';
import 'package:huma_care/common/widget/bottom_bar.dart';
import 'package:huma_care/common/widget/bottom_doctorBar.dart';
import 'package:huma_care/common/widget/bottombar_hospital.dart';
import 'package:huma_care/features/Auth/screen/auth_screen.dart';
import 'package:huma_care/features/home/doctor/doctor_screen.dart';
import 'package:huma_care/features/home/hospital/hospital_profile.dart';



Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

  

      
   
        case BottomBarPatient.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBarPatient(),
      );
  
   case BottomBarHospital.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBarHospital(),
      );
        case BottomBarDoctor.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBarDoctor(),
      );
case HospitalProfileScreen.routeName:
  final args = routeSettings.arguments as Map<String, dynamic>?;
  return MaterialPageRoute(
    settings: routeSettings,
    builder: (_) => HospitalProfileScreen(
      hospitalName: args?["name"] ?? "",
      hospitalLocation: args?["location"] ?? "",
      hospitalImage: args?["imageUrl"] ?? "",
    ),
  );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Error 404 - Page Not Found'),
          ),
        ),
      );
  }
}

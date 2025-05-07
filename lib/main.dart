// import 'package:flutter/material.dart';
// import 'package:huma_care/common/widget/bottom_bar.dart';
// import 'package:huma_care/features/Auth/screen/auth_screen.dart';
// import 'package:huma_care/features/Auth/service/auth_service.dart';
// import 'package:huma_care/features/home/doctor/doctor_screen.dart';
// import 'package:huma_care/provider/user_provider.dart';
// import 'package:huma_care/router.dart';


// import 'package:provider/provider.dart';

// void main() {
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider(
//       create: (context) => UserProvider(),
//     ) // it is so that we can use provider anywhere in our app
//   ], child: MyApp()));
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final AuthService authService = AuthService(); // creation of instance(object)
//   @override
//   void initState() {
//     super.initState();
//     authService.getUserData(context); // this is binding the getUserData with UI
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;

//     Widget homeScreen;
//     if (user.token.isNotEmpty) {
//       if (user.role == 'Doctor') {
//         homeScreen = DoctorScreen();
//       } else {
//         homeScreen = const BottomBarPatient();
//       }
//     } else {
//       homeScreen = const AuthScreen();
//     }
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: ((settings) => generateRoute(settings)),
//       home: homeScreen,
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:huma_care/common/widget/bottom_bar.dart';
import 'package:huma_care/common/widget/bottom_doctorBar.dart';
import 'package:huma_care/common/widget/bottombar_hospital.dart';
import 'package:huma_care/features/Auth/screen/auth_screen.dart';
import 'package:huma_care/features/Auth/service/auth_service.dart';
import 'package:huma_care/features/home/doctor/doctor_screen.dart';
import 'package:huma_care/features/home/hospital/hospial_screen.dart';

import 'package:huma_care/provider/user_provider.dart';
import 'package:huma_care/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    Widget homeScreen;
    if (user.token.isNotEmpty) {
      if (user.role == 'Doctor') {
        homeScreen = BottomBarDoctor();
      } else if (user.role == 'Hospital') {
        homeScreen = BottomBarHospital();
      } else {
        homeScreen = const BottomBarPatient();
      }
    } else {
      homeScreen = const AuthScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: homeScreen,
    );
  }
}

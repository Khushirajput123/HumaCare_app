import 'package:flutter/material.dart';

// String uri = 'http://192.168.36.213:3000'; // uri for ip address
 String uri = 'http://192.168.218.121:3000';
class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
      // static because this color is not going to change any where
      colors: [
        Color.fromARGB(255, 29, 201, 192),
        Color.fromARGB(255, 125, 221, 216),
      ],
      stops: [
        0.5,
        1.0
      ]);

  // static const secondaryColor =Color.fromARGB(255, 24, 248, 196) ;
  static const secondaryColor = Color.fromARGB(255, 121, 108, 238);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}

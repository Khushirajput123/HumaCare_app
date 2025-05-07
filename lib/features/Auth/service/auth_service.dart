
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:huma_care/common/widget/bottom_bar.dart';
// import 'package:huma_care/constants/error_handleling.dart';
// import 'package:huma_care/constants/global_variable.dart';
// import 'package:huma_care/constants/util.dart';
// import 'package:huma_care/features/home/doctor/doctor_screen.dart';
// import 'package:huma_care/provider/user_provider.dart';



// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';


// class AuthService {
//   // Sign Up Function
//   void signUpUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//     required String name,
//     required String role,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signup'),
//         body: jsonEncode({
//           'name': name,
//           'email': email,
//           'password': password,
//           'role': role,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json;charset=UTF-8',
//         },
//       );

//       if (!context.mounted) return;

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           showSnackBar(context, 'Account created! Login with same credentials');
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   // Sign In Function
//   void signInUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signin'),
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json;charset=UTF-8',
//         },
//       );

//       if (!context.mounted) return;

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () async {
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           final Map<String, dynamic> responseData = jsonDecode(res.body);
//           String userRole = responseData['role'];

//           // ignore: use_build_context_synchronously
//           Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//           await prefs.setString('x-auth-token', responseData['token']);

//           if (userRole == 'Doctor') {
//             // ignore: use_build_context_synchronously
//             Navigator.pushReplacementNamed(context, DoctorScreen.routeName);
//           } else {
//             // ignore: use_build_context_synchronously
//             Navigator.pushReplacementNamed(context, BottomBarPatient.routeName);
//           }
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
//   //get User Data function
//   void getUserData(
//     BuildContext context,
//   ) async {
//     try {
//       SharedPreferences prefs=await SharedPreferences.getInstance();
//       String? token=prefs.getString('x-auth-token'); //token can be null at first time Or can return data
//       if(token==null){
//         prefs.setString('x-auth-token', ''); //this shows that user has used the applivation for very first time
//       }
//       var tokenRes=await http.post(
//         Uri.parse('$uri/tokenIsValid'),
//         headers: <String,String>{
//           'Content-Type': 'application/json;charset=UTF-8',
//           'x-auth-token':token!// as above we have already checked so not assign the token is not null to the key
//         },
        
//       );
//       var response=jsonDecode(tokenRes.body);
//       if(response == true){// if the response is true means token is valid then we need to get the data 
//         http.Response userRes=await http.get(
//           Uri.parse('$uri/'),
//             headers: <String,String>{
//           'Content-Type': 'application/json;charset=UTF-8',
//           'x-auth-token':token // no need of ! because we already say that token can never be null
//         },
//         );

//         // ignore: use_build_context_synchronously
//         var userProvider=Provider.of<UserProvider>(context,listen: false);
//         userProvider.setUser(userRes.body);
//       }
//     }catch(e){
//       // ignore: use_build_context_synchronously
//       showSnackBar(context,e.toString());
//     }
//     }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:huma_care/common/widget/bottom_bar.dart';
import 'package:huma_care/common/widget/bottom_doctorBar.dart';
import 'package:huma_care/common/widget/bottombar_hospital.dart';
import 'package:huma_care/constants/error_handleling.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/constants/util.dart';
import 'package:huma_care/features/home/doctor/doctor_screen.dart';
import 'package:huma_care/features/home/hospital/hospial_screen.dart';

import 'package:huma_care/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      if (!context.mounted) return;

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created! Login with same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      if (!context.mounted) return;

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final Map<String, dynamic> responseData = jsonDecode(res.body);
          String userRole = responseData['role'];

          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', responseData['token']);

          if (userRole == 'Doctor') {
            Navigator.pushReplacementNamed(context, BottomBarDoctor.routeName);
          } else if (userRole == 'Hospital') {
            Navigator.pushReplacementNamed(context, BottomBarHospital.routeName);
          } else {
            Navigator.pushReplacementNamed(context, BottomBarPatient.routeName);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': token,
          },
        );

        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

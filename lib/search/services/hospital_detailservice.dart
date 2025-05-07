

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:huma_care/constants/global_variable.dart';

// class HospitalDetailService {
//   static Future<Map<String, dynamic>?> fetchHospitalDetails(
//       String name, double lat, double lon) async {
//     try {
//       final Uri url = Uri.parse("$uri/api/details?name=$name&lat=$lat&lon=$lon");

//       print("Fetching details from: $url"); // Debugging

//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         print("Response: ${response.body}"); // Debugging
//         return json.decode(response.body);
//       } else {
//         print("Error: ${response.body}"); // Debugging
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching hospital details: $e");
//       return null;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:huma_care/constants/global_variable.dart';

class HospitalDetailService {
  static Future<Map<String, dynamic>?> fetchHospitalDetails(String name) async {
    try {
      final Uri url = Uri.parse("$uri/api/detailss?name=$name");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
 
}

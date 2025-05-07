


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:huma_care/constants/global_variable.dart';
// class SearchService {
//   static Future<List<dynamic>> fetchHospitals(String query) async {
//     final url = Uri.parse("$uri/api/search_hospitals?q=$query");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['hospitals'] ?? [];
//     } else {
//       return [];
//     }
//   }
// }



// SearchService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:huma_care/constants/global_variable.dart';

class SearchService {
  static Future<List<dynamic>> fetchHospitals(String query) async {
    final url = Uri.parse("$uri/api/search_hospitals?q=$query");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['hospitals'] ?? [];
    } else {
      return [];
    }
  }
}

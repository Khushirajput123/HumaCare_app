import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/models/manage_hospitaldetail.dart';

class HospitalAvailabilityService {
  static Future<void> submitHospitalAvailability(Hospital hospital) async {
    final url = Uri.parse('$uri/api/manage-hospital');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(hospital.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to save hospital details");
    }
  }

  static Future<Hospital> fetchHospitalAvailability(String hospitalName) async {
    final url = Uri.parse('$uri/api/manage-hospital/$hospitalName');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Hospital.fromJson(data);
    } else {
      throw Exception("Failed to load hospital availability");
    }
  }
}

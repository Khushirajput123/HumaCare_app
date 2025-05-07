import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:huma_care/constants/global_variable.dart';

class HospitalProfileService {
  // ✅ Save hospital details using multipart/form-data
  Future<void> saveHospitalDetails({
    required BuildContext context,
    required String name,
    required String location,
    File? image,
  }) async {
    try {
      var urii = Uri.parse('$uri/api/hospitals');
      var request = http.MultipartRequest('POST', urii);

      request.fields['name'] = name;
      request.fields['location'] = location;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image.path));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        showSnackBar(context, "Hospital details saved successfully");
      } else {
        showSnackBar(context, "Failed to save hospital details");
        print("Response code: ${response.statusCode}");
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      showSnackBar(context, "An error occurred: $e");
    }
  }

  // ✅ Show snackbar
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

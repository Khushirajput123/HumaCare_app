// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final int maxLines;
//   final bool obscureText; // 🔹 Added for password fields

//   const CustomTextField({
//     Key? key,
//     required this.controller,
//     required this.hintText,
//     this.maxLines = 1,
//     this.obscureText = false, // 🔹 Default is false
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText, // 🔹 Toggle password visibility
//       maxLines: obscureText ? 1 : maxLines, // 🔹 Ensure password fields have one line
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8), // 🔹 Slightly rounded corners
//           borderSide: const BorderSide(color: Colors.black38),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       ),
//       validator: (val) {
//         if (val == null || val.isEmpty) {
//           return 'Enter your $hintText';
//         }
//         return null;
//       },
      
//     );
//   }
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final int maxLines;
//   final bool obscureText;
//   final Function(String)? onChanged; // 🔹 Added onChanged

//   const CustomTextField({
//     Key? key,
//     required this.controller,
//     required this.hintText,
//     this.maxLines = 1,
//     this.obscureText = false,
//     this.onChanged,  TextInputType keyboardType, // 🔹 Accept onChanged
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       maxLines: obscureText ? 1 : maxLines,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.black38),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       ),
//       validator: (val) {
//         if (val == null || val.isEmpty) {
//           return 'Enter your $hintText';
//         }
//         return null;
//       },
//       onChanged: onChanged, // 🔹 Pass onChanged callback
//     );
//   }
// }
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType; // ✅ Made it optional

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType, // ✅ Optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : maxLines,
      keyboardType: keyboardType, // ✅ Will be null if not provided
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black38),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

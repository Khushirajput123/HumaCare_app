// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
  
//   final Color? color;
//   final Color? textColor; // Added textColor parameter

//   const CustomButton({
//     Key? key,
//     required this.text,
  
//     this.color,
//     this.textColor = Colors.black, required void Function() onPressed, required void Function() onTap, // Default text color
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
     
//       style: ElevatedButton.styleFrom(
//         shape: const BeveledRectangleBorder(),
//         minimumSize: const Size(double.infinity, 50),
//         backgroundColor: color,
//       ),
//       onPressed: () {  },
//       child: Text(
//         text,
//         style: TextStyle(color: textColor), // Apply text color
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor; // Added textColor parameter

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor = Colors.black, // Default text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const BeveledRectangleBorder(),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color,
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor), // Apply text color
      ),
    );
  }
}


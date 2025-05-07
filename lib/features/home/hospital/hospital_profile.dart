// import 'package:flutter/material.dart';
// import 'package:huma_care/common/widget/custom_button.dart';
// import 'package:huma_care/common/widget/custom_textfield.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class HospitalProfileScreen extends StatefulWidget {
//   static const String routeName = '/hospital-profile';
//   final String hospitalName;
//   final String hospitalLocation;
//   final String hospitalImage;

//   const HospitalProfileScreen({
//     super.key,
//     required this.hospitalName,
//     required this.hospitalLocation,
//     required this.hospitalImage,
//   });

//   @override
//   State<HospitalProfileScreen> createState() => _HospitalProfileScreenState();
// }

// class _HospitalProfileScreenState extends State<HospitalProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   File? _image;

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.hospitalName;
//     locationController.text = widget.hospitalLocation;
//     if (widget.hospitalImage.isNotEmpty) {
//       _image = File(widget.hospitalImage);
//     }
//   }

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   void saveHospitalDetails() {
//     if (_formKey.currentState!.validate()) {
//       Navigator.pop(context, {
//         "name": nameController.text,
//         "location": locationController.text,
//         "image": _image?.path ?? "",
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Hospital Profile"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _image != null ? FileImage(_image!) : null,
//                   child: _image == null ? const Icon(Icons.add_a_photo, size: 40) : null,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: nameController,
//                 hintText: "Hospital Name",
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: locationController,
//                 hintText: "Location",
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 text: "Save Details",
//                 onTap: saveHospitalDetails,
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:huma_care/common/widget/custom_button.dart';
// import 'package:huma_care/common/widget/custom_textfield.dart';
// import 'package:huma_care/features/home/service/Hospitalprofile_service.dart';

// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class HospitalProfileScreen extends StatefulWidget {
//   static const String routeName = '/hospital-profile';
//   final String hospitalName;
//   final String hospitalLocation;
//   final String hospitalImage;

//   const HospitalProfileScreen({
//     super.key,
//     required this.hospitalName,
//     required this.hospitalLocation,
//     required this.hospitalImage,
//   });

//   @override
//   State<HospitalProfileScreen> createState() => _HospitalProfileScreenState();
// }

// class _HospitalProfileScreenState extends State<HospitalProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   File? _image;
//   final HospitalProfileService _hospitalService = HospitalProfileService();

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.hospitalName;
//     locationController.text = widget.hospitalLocation;
//     if (widget.hospitalImage.isNotEmpty) {
//       _image = File(widget.hospitalImage);
//     }
//   }

//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   void saveHospitalDetails() async {
//     if (_formKey.currentState!.validate()) {
//       await _hospitalService.saveHospitalDetails(
//         context: context,
//         name: nameController.text,
//         location: locationController.text,
//         image: _image,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Hospital Profile"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _image != null ? FileImage(_image!) : null,
//                   child: _image == null
//                       ? const Icon(Icons.add_a_photo, size: 40)
//                       : null,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: nameController,
//                 hintText: "Hospital Name",
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: locationController,
//                 hintText: "Location",
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 text: "Save Details",
//                 onTap: saveHospitalDetails,
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:huma_care/common/widget/custom_button.dart';
// import 'package:huma_care/common/widget/custom_textfield.dart';
// import 'package:huma_care/features/home/service/Hospitalprofile_service.dart';

// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class HospitalProfileScreen extends StatefulWidget {
//   static const String routeName = '/hospital-profile';

//   final String? hospitalName;
//   final String? hospitalLocation;
//   final String? hospitalImage;

//   const HospitalProfileScreen({
//     super.key,
//     this.hospitalName,
//     this.hospitalLocation,
//     this.hospitalImage,
//   });

//   @override
//   State<HospitalProfileScreen> createState() => _HospitalProfileScreenState();
// }

// class _HospitalProfileScreenState extends State<HospitalProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   File? _image;

//   final HospitalProfileService _hospitalService = HospitalProfileService();

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.hospitalName ?? '';
//     locationController.text = widget.hospitalLocation ?? '';
//   }

//   Future<void> pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   void saveHospitalDetails() async {
//     if (_formKey.currentState!.validate()) {
//       await _hospitalService.saveHospitalDetails(
//         context: context,
//         name: nameController.text.trim(),
//         location: locationController.text.trim(),
//         image: _image,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     ImageProvider? imageProvider;
//     if (_image != null) {
//       imageProvider = FileImage(_image!);
//     } else if (widget.hospitalImage != null &&
//         widget.hospitalImage!.isNotEmpty) {
//       imageProvider = NetworkImage(widget.hospitalImage!);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Hospital Profile"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: imageProvider,
//                   child: imageProvider == null
//                       ? const Icon(Icons.add_a_photo, size: 40)
//                       : null,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: nameController,
//                 hintText: "Hospital Name",
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: locationController,
//                 hintText: "Location",
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 text: "Save Details",
//                 onTap: saveHospitalDetails,
//                 color: Colors.blueAccent,
//                 textColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:huma_care/common/widget/custom_button.dart';
import 'package:huma_care/common/widget/custom_textfield.dart';
import 'package:huma_care/features/home/service/Hospitalprofile_service.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HospitalProfileScreen extends StatefulWidget {
  static const String routeName = '/hospital-profile';

  final String? hospitalName;
  final String? hospitalLocation;
  final String? hospitalImage;

  const HospitalProfileScreen({
    super.key,
    this.hospitalName,
    this.hospitalLocation,
    this.hospitalImage,
  });

  @override
  State<HospitalProfileScreen> createState() => _HospitalProfileScreenState();
}

class _HospitalProfileScreenState extends State<HospitalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  File? _image;

  final HospitalProfileService _hospitalService = HospitalProfileService();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.hospitalName ?? '';
    locationController.text = widget.hospitalLocation ?? '';
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void saveHospitalDetails() async {
    if (_formKey.currentState!.validate()) {
      await _hospitalService.saveHospitalDetails(
        context: context,
        name: nameController.text.trim(),
        location: locationController.text.trim(),
        image: _image,
      );

      // Return data to dashboard after save
      Navigator.pop(context, {
        'name': nameController.text.trim(),
        'location': locationController.text.trim(),
        'image': _image?.path ?? widget.hospitalImage ?? '',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (_image != null) {
      imageProvider = FileImage(_image!);
    } else if (widget.hospitalImage != null &&
        widget.hospitalImage!.isNotEmpty) {
      imageProvider = NetworkImage(widget.hospitalImage!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imageProvider,
                  child: imageProvider == null
                      ? const Icon(Icons.add_a_photo, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: nameController,
                hintText: "Hospital Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: locationController,
                hintText: "Location",
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Save Details",
                onTap: saveHospitalDetails,
                color: Colors.blueAccent,
                textColor: Colors.white, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

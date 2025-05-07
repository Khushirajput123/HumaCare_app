// import 'package:flutter/material.dart';
// import 'package:huma_care/common/widget/custom_button.dart';
// import 'package:huma_care/common/widget/custom_textfield.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:huma_care/constants/global_variable.dart';

// import 'package:huma_care/provider/user_provider.dart';

// class DoctorProfileScreen extends StatefulWidget {
//   const DoctorProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
// }

// class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController nameController;
//   late TextEditingController emailController;
//   late TextEditingController specializationController;
//   late TextEditingController bioController;

//   @override
//   void initState() {
//     super.initState();
//     final user = Provider.of<UserProvider>(context, listen: false).user;
//     nameController = TextEditingController(text: user.name);
//     emailController = TextEditingController(text: user.email);
//     specializationController = TextEditingController();
//     bioController = TextEditingController();
//     _loadSavedProfile();
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     specializationController.dispose();
//     bioController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadSavedProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       specializationController.text = prefs.getString('specialization') ?? '';
//       bioController.text = prefs.getString('bio') ?? '';
//     });
//   }

//   Future<void> saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('specialization', specializationController.text);
//       await prefs.setString('bio', bioController.text);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile saved locally')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: GlobalVariables.secondaryColor,
//         title: const Text(
//           'Doctor Profile',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 45,
//                 backgroundColor: GlobalVariables.secondaryColor,
//                 child: Text(
//                   user.name.isNotEmpty ? user.name[0].toUpperCase() : '',
//                   style: const TextStyle(fontSize: 32, color: Colors.white),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Name (non-editable)
//               CustomTextField(
//                 controller: nameController,
//                 hintText: 'Name',

//               ),
//               const SizedBox(height: 12),

//               // Email (non-editable)
//               CustomTextField(
//                 controller: emailController,
//                 hintText: 'Email',
                
//               ),
//               const SizedBox(height: 12),

//               // Specialization
//               CustomTextField(
//                 controller: specializationController,
//                 hintText: 'Specialization',
//               ),
//               const SizedBox(height: 12),

//               // Bio
//               CustomTextField(
//                 controller: bioController,
//                 hintText: 'Short Bio',
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 24),

//               CustomButton(
//                 text: 'Save Profile',
//                 color: GlobalVariables.secondaryColor,
//                 textColor: Colors.white,
//                 onTap: saveProfile,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:huma_care/common/widget/custom_button.dart';
import 'package:huma_care/common/widget/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:huma_care/constants/global_variable.dart';

import 'package:huma_care/provider/user_provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController specializationController;
  late TextEditingController bioController;
  late TextEditingController phoneController;
  late TextEditingController experienceController;

  File? _pickedImage;
  String? _pickedFileName;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    specializationController = TextEditingController();
    bioController = TextEditingController();
    phoneController = TextEditingController();
    experienceController = TextEditingController();
    _loadSavedProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    specializationController.dispose();
    bioController.dispose();
    phoneController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      specializationController.text = prefs.getString('specialization') ?? '';
      bioController.text = prefs.getString('bio') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      experienceController.text = prefs.getString('experience') ?? '';
      _pickedFileName = prefs.getString('fileName');
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _pickedImage = File(file.path);
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedFileName = result.files.single.name;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fileName', _pickedFileName!);
    }
  }

  Future<void> saveProfile() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('specialization', specializationController.text);
      await prefs.setString('bio', bioController.text);
      await prefs.setString('phone', phoneController.text);
      await prefs.setString('experience', experienceController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved locally')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.secondaryColor,
        title: const Text(
          'Doctor Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: GlobalVariables.secondaryColor,
                    backgroundImage:
                        _pickedImage != null ? FileImage(_pickedImage!) : null,
                    child: _pickedImage == null
                        ? Text(
                            user.name.isNotEmpty
                                ? user.name[0].toUpperCase()
                                : '',
                            style: const TextStyle(
                                fontSize: 32, color: Colors.white),
                          )
                        : null,
                  ),
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name
              CustomTextField(
                controller: nameController,
                hintText: 'Name',
              
              ),
              const SizedBox(height: 12),

              // Email
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
               
              ),
              const SizedBox(height: 12),

              // Phone
              CustomTextField(
                controller: phoneController,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              // Specialization
              CustomTextField(
                controller: specializationController,
                hintText: 'Specialization',
              ),
              const SizedBox(height: 12),

              // Experience
              CustomTextField(
                controller: experienceController,
                hintText: 'Experience (e.g. 5 years)',
              ),
              const SizedBox(height: 12),

              // Bio
              CustomTextField(
                controller: bioController,
                hintText: 'Short Bio',
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // File picker
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       _pickedFileName != null
              //           ? 'Picked File: $_pickedFileName'
              //           : 'No file selected',
              //       style: const TextStyle(fontSize: 14),
              //     ),
              //     IconButton(
              //       onPressed: _pickFile,
              //       icon: const Icon(Icons.attach_file),
              //     ),
              //   ],
              // ),
             
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      'Upload Experience Certificate',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
    const SizedBox(height: 8),
    GestureDetector(
      onTap: _pickFile,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black38),
        ),
        child: Row(
          children: [
            const Icon(Icons.attach_file, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _pickedFileName != null
                    ? _pickedFileName!
                    : 'Tap to select a file',
                style: TextStyle(
                  fontSize: 14,
                  color: _pickedFileName != null ? Colors.black87 : Colors.black54,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
              const SizedBox(height: 24),

              // Save button
              CustomButton(
                text: 'Save Profile',
                color: GlobalVariables.secondaryColor,
                textColor: Colors.white,
                onTap: saveProfile, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

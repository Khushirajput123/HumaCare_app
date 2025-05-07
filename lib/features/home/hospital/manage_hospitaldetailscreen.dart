// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:huma_care/common/widget/custom_button.dart';
// import 'package:huma_care/common/widget/custom_textfield.dart';
// import 'package:huma_care/constants/global_variable.dart';
// import 'package:huma_care/features/home/service/manage_hospitaldetail_service.dart';
// import 'package:huma_care/models/manage_hospitaldetail.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditHospitalDetailScreen extends StatefulWidget {
//   final Hospital? hospital;
//   const EditHospitalDetailScreen({super.key, this.hospital});

//   @override
//   State<EditHospitalDetailScreen> createState() => _EditHospitalDetailScreenState();
// }

// class _EditHospitalDetailScreenState extends State<EditHospitalDetailScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController nameController;
//   late TextEditingController locationController;
//   late TextEditingController phoneController;
//   late TextEditingController imageController;
//   late TextEditingController descriptionController;

//   List<Doctor> doctorList = [];
//   bool _isEdited = false;

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController();
//     locationController = TextEditingController();
//     phoneController = TextEditingController();
//     imageController = TextEditingController();
//     descriptionController = TextEditingController();

//     loadSavedData();

//     final hospital = widget.hospital;
//     if (hospital != null) {
//       nameController.text = hospital.name;
//       locationController.text = hospital.location;
//       phoneController.text = hospital.phone;
//       imageController.text = hospital.image;
//       descriptionController.text = hospital.description;
//       doctorList = hospital.doctors;
//     }
//   }

//   void loadSavedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       nameController.text = prefs.getString('hospital_name') ?? '';
//       locationController.text = prefs.getString('hospital_location') ?? '';
//       phoneController.text = prefs.getString('hospital_phone') ?? '';
//       imageController.text = prefs.getString('hospital_image') ?? '';
//       descriptionController.text = prefs.getString('hospital_description') ?? '';

//       final doctorsJson = prefs.getString('hospital_doctors');
//       if (doctorsJson != null) {
//         List decoded = json.decode(doctorsJson);
//         doctorList = decoded.map((d) => Doctor(
//           name: d['name'],
//           specialization: d['specialization'],
//           available: d['available'],
//         )).toList().cast<Doctor>();
//       }
//     });
//   }

//   void saveFormData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('hospital_name', nameController.text);
//     await prefs.setString('hospital_location', locationController.text);
//     await prefs.setString('hospital_phone', phoneController.text);
//     await prefs.setString('hospital_image', imageController.text);
//     await prefs.setString('hospital_description', descriptionController.text);

//     final doctorJsonList = doctorList.map((d) => {
//       'name': d.name,
//       'specialization': d.specialization,
//       'available': d.available,
//     }).toList();

//     await prefs.setString('hospital_doctors', json.encode(doctorJsonList));
//   }

//   void addDoctor() {
//     setState(() {
//       doctorList.add(Doctor(name: "", specialization: "", available: true));
//       _isEdited = true;
//     });
//   }

//   void submitForm() async {
//     if (!_isEdited) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No changes made")),
//       );
//       return;
//     }

//     if (_formKey.currentState!.validate()) {
//       final hospital = Hospital(
//         name: nameController.text.trim(),
//         location: locationController.text.trim(),
//         phone: phoneController.text.trim(),
//         image: imageController.text.trim(),
//         description: descriptionController.text.trim(),
//         doctors: doctorList,
//       );

//       await HospitalAvailabilityService.submitHospitalAvailability(hospital);
//       saveFormData(); // <-- Save only when edited and submitted

//       if (context.mounted) {
//         Navigator.pop(context, true);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Hospital details saved successfully")),
//         );
//       }
//     }
//   }

//   Widget buildDoctorForm(int index) {
//     final doctor = doctorList[index];
//     final nameCtrl = TextEditingController(text: doctor.name);
//     final specCtrl = TextEditingController(text: doctor.specialization);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomTextField(
//           controller: nameCtrl,
//           hintText: "Doctor Name",
//           maxLines: 1,
//           onChanged: (val) {
//             doctorList[index].name = val;
//             _isEdited = true;
//           },
//         ),
//         const SizedBox(height: 8),
//         CustomTextField(
//           controller: specCtrl,
//           hintText: "Specialization",
//           maxLines: 1,
//           onChanged: (val) {
//             doctorList[index].specialization = val;
//             _isEdited = true;
//           },
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             const Text("Available: "),
//             Switch(
//               value: doctor.available,
//               onChanged: (value) {
//                 setState(() {
//                   doctorList[index].available = value;
//                   _isEdited = true;
//                 });
//               },
//             ),
//           ],
//         ),
//         const Divider(),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Hospital Details", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: GlobalVariables.secondaryColor,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               CustomTextField(
//                 controller: nameController,
//                 hintText: "Hospital Name",
//                 onChanged: (_) => _isEdited = true,
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: locationController,
//                 hintText: "Location",
//                 onChanged: (_) => _isEdited = true,
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: phoneController,
//                 hintText: "Phone Number",
//                 onChanged: (_) => _isEdited = true,
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: imageController,
//                 hintText: "Image URL",
//                 onChanged: (_) => _isEdited = true,
//               ),
//               const SizedBox(height: 10),
//               CustomTextField(
//                 controller: descriptionController,
//                 hintText: "Description",
//                 maxLines: 3,
//                 onChanged: (_) => _isEdited = true,
//               ),
//               const SizedBox(height: 16),
//               const Text("Doctors", style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               ...doctorList.asMap().entries.map((e) => buildDoctorForm(e.key)),
//               TextButton.icon(
//                 onPressed: addDoctor,
//                 icon: const Icon(Icons.add),
//                 label: const Text("Add Doctor"),
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 text: "Save",
//                 textColor: Colors.white,
//                 onTap: submitForm,
//                 color: GlobalVariables.secondaryColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:huma_care/common/widget/custom_button.dart';
import 'package:huma_care/common/widget/custom_textfield.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/features/home/service/manage_hospitaldetail_service.dart';
import 'package:huma_care/models/manage_hospitaldetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditHospitalDetailScreen extends StatefulWidget {
  final Hospital? hospital;
  const EditHospitalDetailScreen({super.key, this.hospital});

  @override
  State<EditHospitalDetailScreen> createState() => _EditHospitalDetailScreenState();
}

class _EditHospitalDetailScreenState extends State<EditHospitalDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController phoneController;
  late TextEditingController imageController;
  late TextEditingController descriptionController;

  List<Doctor> doctorList = [];
  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    locationController = TextEditingController();
    phoneController = TextEditingController();
    imageController = TextEditingController();
    descriptionController = TextEditingController();

    loadSavedData();

    final hospital = widget.hospital;
    if (hospital != null) {
      nameController.text = hospital.name;
      locationController.text = hospital.location;
      phoneController.text = hospital.phone;
      imageController.text = hospital.image;
      descriptionController.text = hospital.description;
      doctorList = hospital.doctors;
    }
  }

  void loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('hospital_name') ?? '';
      locationController.text = prefs.getString('hospital_location') ?? '';
      phoneController.text = prefs.getString('hospital_phone') ?? '';
      imageController.text = prefs.getString('hospital_image') ?? '';
      descriptionController.text = prefs.getString('hospital_description') ?? '';

      final doctorsJson = prefs.getString('hospital_doctors');
      if (doctorsJson != null) {
        List decoded = json.decode(doctorsJson);
        doctorList = decoded.map((d) => Doctor(
          name: d['name'],
          specialization: d['specialization'],
          available: d['available'],
        )).toList().cast<Doctor>();
      }
    });
  }

  void saveFormData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('hospital_name', nameController.text);
    await prefs.setString('hospital_location', locationController.text);
    await prefs.setString('hospital_phone', phoneController.text);
    await prefs.setString('hospital_image', imageController.text);
    await prefs.setString('hospital_description', descriptionController.text);

    final doctorJsonList = doctorList.map((d) => {
      'name': d.name,
      'specialization': d.specialization,
      'available': d.available,
    }).toList();

    await prefs.setString('hospital_doctors', json.encode(doctorJsonList));
  }

  void addDoctor() {
    setState(() {
      doctorList.add(Doctor(name: "", specialization: "", available: true));
      _isEdited = true;
    });
  }

  void submitForm() async {
    if (!_isEdited) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No changes made")),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final hospital = Hospital(
        name: nameController.text.trim(),
        location: locationController.text.trim(),
        phone: phoneController.text.trim(),
        image: imageController.text.trim(),
        description: descriptionController.text.trim(),
        doctors: doctorList,
      );

      await HospitalAvailabilityService.submitHospitalAvailability(hospital);
      saveFormData(); // <-- Save only when edited and submitted

      if (context.mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hospital details saved successfully")),
        );
      }
    }
  }

  Widget buildDoctorForm(int index) {
    final doctor = doctorList[index];
    final nameCtrl = TextEditingController(text: doctor.name);
    final specCtrl = TextEditingController(text: doctor.specialization);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Doctor Details", style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      doctorList.removeAt(index);
                      _isEdited = true;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: nameCtrl,
              hintText: "Doctor Name",
              maxLines: 1,
              onChanged: (val) {
                doctorList[index].name = val;
                _isEdited = true;
              },
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: specCtrl,
              hintText: "Specialization",
              maxLines: 1,
              onChanged: (val) {
                doctorList[index].specialization = val;
                _isEdited = true;
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("Available: "),
                Switch(
                  value: doctor.available,
                  onChanged: (value) {
                    setState(() {
                      doctorList[index].available = value;
                      _isEdited = true;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Hospital Details", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                hintText: "Hospital Name",
                onChanged: (_) => _isEdited = true,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: locationController,
                hintText: "Location",
                onChanged: (_) => _isEdited = true,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: phoneController,
                hintText: "Phone Number",
                onChanged: (_) => _isEdited = true,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: imageController,
                hintText: "Image URL",
                onChanged: (_) => _isEdited = true,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: descriptionController,
                hintText: "Description",
                maxLines: 3,
                onChanged: (_) => _isEdited = true,
              ),
              const SizedBox(height: 16),
              const Text("Doctors", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...doctorList.asMap().entries.map((e) => buildDoctorForm(e.key)),
              TextButton.icon(
                onPressed: addDoctor,
                icon: const Icon(Icons.add),
                label: const Text("Add Doctor"),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Save",
                textColor: Colors.white,
                onTap: submitForm,
                color: GlobalVariables.secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

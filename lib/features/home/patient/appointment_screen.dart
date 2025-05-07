import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const AppointmentScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  final TextEditingController reasonController = TextEditingController();

  final List<String> availableTimes = [
    "09:00 AM",
    "10:30 AM",
    "12:00 PM",
    "02:00 PM",
    "03:30 PM",
    "05:00 PM",
  ];

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _confirmAppointment() {
    if (selectedTime.isEmpty || reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select time and reason')));
      return;
    }

    // Handle actual appointment logic here

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment Confirmed')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Book Appointment",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF7165D6),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF0EEFA),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/default_ospital.jpg"),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(doctor['specialization'], style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            // Select Date
            Text("Select Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  DateFormat.yMMMMd().format(selectedDate),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 25),

            // Select Time Slot
            Text("Select Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: availableTimes.map((time) {
                final isSelected = selectedTime == time;
                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: (_) => setState(() => selectedTime = time),
                  selectedColor: Color(0xFF7165D6),
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            SizedBox(height: 25),

            // Reason Input
            Text("Reason for Visit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Describe your symptoms or reason...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 30),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7165D6),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Confirm Appointment", style: TextStyle(fontSize: 18,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool isDarkMode = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Settings",
//         style: TextStyle(
//           color: Colors.white,
//         ),),
//         backgroundColor: const Color(0xFF7165D6),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _buildProfileSection(),
//           const SizedBox(height: 20),
//           _buildSettingsOption(Icons.person, "Account", "Manage your account"),
//           _buildSettingsOption(Icons.notifications, "Notifications", "Set notification preferences"),
//           _buildDarkModeSwitch(),
//           _buildSettingsOption(Icons.info, "About", "App version and info"),
//           _buildLogoutButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileSection() {
//     return const Row(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           backgroundImage: AssetImage("assets/username.jpg"),
//         ),
//         SizedBox(width: 15),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Hello, XYZ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             Text("xyz@email.com", style: TextStyle(color: Colors.grey)),
//           ],
//         )
//       ],
//     );
//   }

//   Widget _buildSettingsOption(IconData icon, String title, String subtitle) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFF7165D6)),
//       title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//       subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
//       trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
//       onTap: () {},
//     );
//   }

//   Widget _buildDarkModeSwitch() {
//     return SwitchListTile(
//       title: const Text("Dark Mode", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//       secondary: const Icon(Icons.dark_mode, color: Color(0xFF7165D6)),
//       value: isDarkMode,
//       onChanged: (value) {
//         setState(() {
//           isDarkMode = value;
//         });
//       },
//     );
//   }

//   Widget _buildLogoutButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Center(
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.red,
//             padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//           onPressed: () {},
//           child: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.white)),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:huma_care/features/Auth/screen/auth_screen.dart';
import 'package:huma_care/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadDarkModePreference();
  }

  // Load dark mode preference from shared preferences
  Future<void> _loadDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save dark mode preference to shared preferences
  Future<void> _saveDarkModePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  // Logout function
  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('x-auth-token'); // Remove stored token

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF7165D6),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileSection(user),
          const SizedBox(height: 20),
          _buildSettingsOption(Icons.person, "Account", "Manage your account"),
          _buildSettingsOption(Icons.notifications, "Notifications", "Set notification preferences"),
          _buildDarkModeSwitch(),
          _buildSettingsOption(Icons.info, "About", "App version and info"),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildProfileSection(user) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage("assets/username.jpg"),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsOption(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF7165D6)),
      title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildDarkModeSwitch() {
    return SwitchListTile(
      title: const Text("Dark Mode", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      secondary: const Icon(Icons.dark_mode, color: Color(0xFF7165D6)),
      value: isDarkMode,
      onChanged: (value) {
        setState(() {
          isDarkMode = value;
        });
        _saveDarkModePreference(value);
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => logout(context),
          child: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}

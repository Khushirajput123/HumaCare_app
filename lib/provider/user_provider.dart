import 'package:flutter/material.dart';
import 'package:huma_care/models/user.dart';



class UserProvider extends ChangeNotifier {
  // Private user variable
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    role: '', // Added role field
  );

  // Getter to access user data
  User get user => _user;

  // Function to update user data from JSON string
  void setUser(String userJson) {
    _user = User.fromJson(userJson);
    notifyListeners(); // Notify listeners to rebuild UI
  }
}

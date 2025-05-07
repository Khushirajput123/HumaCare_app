
import 'package:flutter/material.dart';
import 'package:huma_care/common/widget/custom_button.dart';
import 'package:huma_care/common/widget/custom_textfield.dart';
import 'package:huma_care/constants/global_variable.dart';
import 'package:huma_care/features/Auth/service/auth_service.dart';


enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = '/auth_screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
   final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  
  // Role selection (default: Patient)
  String _selectedRole = 'Patient';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
    void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      role: _selectedRole, // Pass selected role
    );
  }

   void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/healthlogo.webp', 
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                "HumaCare",
                style: TextStyle(
                  color: Color(0xFF7165D6),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Instant Assistance",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  wordSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up Section
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'E-mail',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),

                        // Role Selection Dropdown
                        // DropdownButtonFormField<String>(
                        //   value: _selectedRole,
                        //   decoration: const InputDecoration(
                        //     labelText: 'Select Role',
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   items: ['Doctor', 'Patient']
                        //       .map((role) => DropdownMenuItem(
                        //             value: role,
                        //             child: Text(role),
                        //           ))
                        //       .toList(),
                        //   onChanged: (val) {
                        //     setState(() {
                        //       _selectedRole = val!;
                        //     });
                        //   },
                        // ),

                        DropdownButtonFormField<String>(
  value: _selectedRole,
  decoration: const InputDecoration(
    labelText: 'Select Role',
    border: OutlineInputBorder(),
  ),
  items: ['Doctor', 'Patient', 'Hospital']
      .map((role) => DropdownMenuItem(
            value: role,
            child: Text(role),
          ))
      .toList(),
  onChanged: (val) {
    setState(() {
      _selectedRole = val!;
    });
  },
),
                        const SizedBox(height: 10),

                        CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                              // binding signUpUser() for when we click on button it shows there function
                              if (_signUpFormKey.currentState!.validate()) {
                                // if the validation goes well good it will return true and then ....
                                signUpUser();
                              }
                          },
                        
                          
                          color: GlobalVariables.secondaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

              // Sign In Section
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'E-mail',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                                // if the validation goes well good it will return true and then ....
                                signInUser();
                              }
                          },
                          color: GlobalVariables.secondaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

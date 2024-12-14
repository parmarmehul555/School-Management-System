import 'package:flutter/material.dart';
import 'package:school_management_system/Dashboard.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailMobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailMobileController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email or mobile number';
                  }
        
                  // Pattern for email validation
                  String emailPattern =
                      r'^[a-zA-z]+[0-9]+@gmail.com$';
                  // Pattern for mobile number validation
                  String mobilePattern = r'^[0-9]{10}$';
        
                  RegExp emailRegEx = RegExp(emailPattern);
                  RegExp mobileRegEx = RegExp(mobilePattern);
        
                  if (!emailRegEx.hasMatch(value) &&
                      !mobileRegEx.hasMatch(value)) {
                    return 'Enter a valid email or 10-digit mobile number';
                  }
        
                  return null; // Input is valid
                },
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Email/Mobile No. / Employee...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Password Input
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty || value == null){
                    return "Please Enter Password";
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text(
                        'Remember Me',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

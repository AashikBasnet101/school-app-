import 'package:flutter/material.dart';
import 'package:school_app/core/utils/color_const.dart';
import 'package:school_app/core/utils/string_const.dart';
import 'package:school_app/features/login/presentation/login.dart';
import 'package:school_app/widgets/custom_dropdown.dart';
import 'package:school_app/widgets/custom_textformfield.dart';
import 'package:school_app/widgets/custom_elevatedbutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  bool isObscurePassword = true;
  Future<void> signupUser(Map<String, dynamic> userData) async {
    const String apiUrl = "https://9e24f3e873c1.ngrok-free.app/createUser";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success logic
        final responseData = json.decode(response.body);
        print("Signup Success: $responseData");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );

        // Navigate to Login screen or Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Login()),
        );
      } else {
        final errorData = json.decode(response.body);
        print("Signup Failed: ${errorData['message']}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${errorData['message']}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Try again.')),
      );
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 Top blue background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 60),
                Icon(Icons.person_add_alt_1, color: Colors.white, size: 50),
                SizedBox(height: 10),
                Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Fill in your details below to register',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // 🧾 White card overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextform(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? 'Email is required' : null,
                        onChanged: (val) => emailController.text = val,
                      ),
                      // Change Full Name field to use nameController
                      CustomTextform(
                        controller: nameController,
                        labelText: 'Full Name',
                        prefixIcon: const Icon(Icons.badge),
                        validator: (value) =>
                            value!.isEmpty ? 'Name is required' : null,
                        onChanged: (val) => nameController.text = val,
                      ),

                      CustomTextform(
                        controller: usernameController,
                        labelText: 'username',
                        prefixIcon: const Icon(Icons.badge),
                        validator: (value) =>
                            value!.isEmpty ? 'Name is required' : null,
                        onChanged: (val) => usernameController.text = val,
                      ),
                      CustomTextform(
                        controller: contactController,
                        labelText: 'Contact Number',
                        prefixIcon: const Icon(Icons.phone),
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? 'Contact is required' : null,
                        onChanged: (val) => contactController.text = val,
                      ),
                      CustomTextform(
                        controller: passwordController,
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        obscureText: isObscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscurePassword = !isObscurePassword;
                            });
                          },
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Password is required' : null,
                        onChanged: (val) => passwordController.text = val,
                      ),
                      DropDown(
                        labelText: 'Gender',
                        items: genderOptions,
                        value: selectedGender,
                        onChanged: (val) {
                          setState(() {
                            selectedGender = val!;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select gender' : null,
                      ),
                      const SizedBox(height: 10),
                      DropDown(
                        labelText: 'Role',
                        items: roleOptions,
                        value: selectedRole,
                        onChanged: (val) {
                          setState(() {
                            selectedRole = val!;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select role' : null,
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        backgroundColor: secondaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final userData = {
                              "email": emailController.text,
                              "username": usernameController.text,
                              "password": passwordController.text,
                              "name": nameController.text,
                              "gender": selectedGender,
                              "role": selectedRole,
                              "contact": contactController.text,
                            };

                            signupUser(userData); // Call API
                          }
                        },

                        child: const Text("Sign Up"),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              ); // back to login
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

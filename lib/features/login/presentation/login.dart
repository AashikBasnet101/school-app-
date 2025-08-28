import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/assignmet/presentation/create.dart';
import 'package:school_app/core/utils/color_const.dart';
import 'package:school_app/core/utils/string_const.dart';
import 'package:school_app/features/dashboard/presentation/dashboard.dart';
import 'package:school_app/features/signup/presentation/signup.dart';
import 'package:school_app/widgets/custom_elevatedbutton.dart';
import 'package:school_app/widgets/custom_textformfield.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscurePassword = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(Map<String, dynamic> userData) async {
    const String apiUrl = "https://9e24f3e873c1.ngrok-free.app/login";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final token = responseData['data']['token'];

        if (token == null || token is! String) {
          throw Exception('Token is missing or invalid');
        }
        print("Login Success: $responseData");

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('LoggedIn successfully!')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CreateAssignment(token: token)),
        );
      } else {
        final errorData = json.decode(response.body);
        print("Login Failed: ${errorData['message']}");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 Blue background
          Container(
            height: double.infinity,
            width: double.infinity,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Icon(Icons.verified_user, color: Colors.white, size: 50),
                SizedBox(height: 10),
                Text(
                  'Sign in to your\nAccount',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Enter your email and password to log in',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // 🧾 White Card Overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.72,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {
                          // Handle Google login
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('Or login with'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// ✉️ Email Field
                      CustomTextform(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? 'Email is required' : null,
                        onChanged: (val) => emailController.text = val,
                      ),
                      const SizedBox(height: 15),

                      /// 🔒 Password Field
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

                      /// ✅ Remember & Forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (val) {}),
                              Text("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(color: secondaryColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      /// 🔵 Login Button
                      CustomElevatedButton(
                        backgroundColor: secondaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final userData = {
                              "email": emailController.text,

                              "password": passwordController.text,
                            };

                            loginUser(userData); // Call API
                          }
                        },

                        child: const Text("Sign Up"),
                      ),

                      const SizedBox(height: 20),

                      /// 🆕 Sign Up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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

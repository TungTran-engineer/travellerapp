import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart'; // Import clipper đã tạo
import 'package:flutter_application_1/sign_in_screen.dart'; // Import màn hình Sign In

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 120, 233, 124),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: const Color.fromARGB(255, 120, 233, 124),
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 60,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                right: 83,
                child: Image.asset('assets/line.png', height: 60),
              ),
              Positioned(
                top: 70,
                right: 60,
                child: Image.asset('assets/cloud.png', height: 60),
              ),
              Positioned(
                top: 50,
                right: 30,
                child: Image.asset('assets/maybay.png', height: 60),
              ),
            ],
          ),
          Expanded(
            child: ClipPath(
              clipper: MyCustomClipper(), // Áp dụng clipper
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Forgot Password',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Input your email, we will send you an instruction to reset your password.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nhấn nút SEND
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                        child: const Text(
                          'SEND',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Chuyển hướng về màn hình Sign In
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignInScreen()),
                            );
                          },
                          child: const Text(
                            'Back to Sign In',
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
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

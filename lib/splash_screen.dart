import 'package:flutter/material.dart';
import 'package:knee_app/sign_in_page.dart';
import 'sign_up_page.dart'; // Import SignUpPage

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 3 seconds before navigating to the sign-up page
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF06607B), // Set the background color
      body: Container(
        margin: EdgeInsets.all(20.0), // Add margin of 20 pixels to all sides
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 90.0), // Add padding only to the top
            child: Text(
              'Welcome to \nKnee Osteoarthritis \nDetection and Prediction.',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 33, color: Color(0xFFF0F8FF)), // Set text color to F0F8FF
            ),
          ),
        ),
      ),
    );
  }
}

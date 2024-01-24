import 'package:flutter/material.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:lottie/lottie.dart';
import 'sign_up_page.dart'; // Import SignUpPage

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,),SizedBox(height: 10,),
                Text(
                  'Welcome to \nKnee Osteoarthritis \nDetection and Prediction.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, color: Color(0xFFF0F8FF)), // Set text color to F0F8FF
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

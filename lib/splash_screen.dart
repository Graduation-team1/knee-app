import 'package:flutter/material.dart';
import 'package:knee_app/bottomNavbar.dart';
import 'package:knee_app/constants.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/sign_up_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _name;
  String? _email;
  String? _pass;
  String? _passs;

  @override
  void initState() {
    super.initState();
    loadUserData();
    Future.delayed(const Duration(seconds: 5), () {
      if(_name == null && _email == null && _pass==null){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpPage()));
      }
      else if (_pass != null || _passs!=null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBar()));
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      }
    });
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name=prefs.getString('username');
    _email=prefs.getString('email');
    _pass= prefs.getString('pass');
    _passs= prefs.getString('passs');
    // Ensure the widget is rebuilt after the data is loaded
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  kScaffoldColor, // Set the background color
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,),const SizedBox(height: 10,),
                const Text(
                  'Welcome to \nKnee Osteoarthritis \nDetection and Prediction.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, color: kPrimaryColor), // Set text color to F0F8FF
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

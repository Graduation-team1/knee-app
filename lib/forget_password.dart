import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:knee_app/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: kScaffoldColor,
      ),
      body: Container(
        color: kScaffoldColor,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'No worries! Enter your email below, and we\'ll send you a link to reset your password.',
              style: TextStyle(fontSize: 18.0, color: kPrimaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: kPrimaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
              style: TextStyle(color: kPrimaryColor),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _sendResetPasswordEmail(context);
              },
              child: Text('Send Reset Email',style: TextStyle(fontSize: 17.0,
                  fontWeight: FontWeight.bold,color: kScaffoldColor)),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendResetPasswordEmail(BuildContext context) async {
    String email = _emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: 'Password reset email sent. Check your email.',
        backgroundColor: kPrimaryColor,
        textColor: kScaffoldColor,
      );
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to send reset email : Invalid Email Please enter a valid email address.',
        backgroundColor: kPrimaryColor,
        textColor: kScaffoldColor,
      );
    }
  }
}
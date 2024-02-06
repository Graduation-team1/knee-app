import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:knee_app/bottomNavbar.dart';
import 'package:knee_app/copy.dart';
import 'package:knee_app/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Knee Osteoarthritis Detection and \nPrediction.',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Color(0xFF06607B),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF06607B),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildInputField('Email', _emailController),
                      SizedBox(height: 40),
                      _buildPasswordField(),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => _handleSignIn(context),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFF0F8FF),
                          onPrimary: Color(0xFF06607B),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          _showResetPasswordDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              'Forget your password?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFF0F8FF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF314441)),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(color: Color(0xFFF0F8FF)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16, color: Color(0xFFF0F8FF)),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Color(0xFFF0F8FF)),
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFFF0F8FF), style: BorderStyle.solid),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFFF0F8FF), style: BorderStyle.solid),
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
          obscureText: obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(fontSize: 16, color: Color(0xFFF0F8FF)),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          style: TextStyle(color: Color(0xFFF0F8FF)),
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFFF0F8FF), style: BorderStyle.solid),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFFF0F8FF), style: BorderStyle.solid),
            ),
            filled: true,
            fillColor: Colors.transparent,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Color(0xFFF0F8FF),
              ),
            ),
          ),
          obscureText: !_isPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Password';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _handleSignIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('passs', _passwordController.text);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: 'Incorrect username or password.',
          backgroundColor: Color(0xFFF0F8FF),
          textColor: Color(0xFF054E65),
        );
      }
    }
  }


  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Reset Password',
            style: TextStyle(
              color: Color(0xFF054E65), // Set the text color
            ),
          ),
          backgroundColor: Color(0xFFF0F8FF), // Set the background color
          content: Text(
            'Enter your email to receive a password reset link:',
            style: TextStyle(
              color: Color(0xFF054E65), // Set the text color
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF054E65), // Set the text color
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                _handleResetPassword(context);
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  color: Color(0xFF054E65), // Set the text color
                ),
              ),
            ),
          ],
          contentPadding: EdgeInsets.all(20),
        );
      },
    );
  }

  void _handleResetPassword(BuildContext context) async {
    if (_emailController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );

        Fluttertoast.showToast(
          msg: 'Password reset email sent. Check your email.',
          backgroundColor: Color(0xFFF0F8FF),
          textColor: Color(0xFF054E65),
        );
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: 'Error: ${e.message}',
          backgroundColor: Color(0xFFF0F8FF),
          textColor: Color(0xFF054E65),
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Please enter your email.',
        backgroundColor: Color(0xFFF0F8FF),
        textColor: Color(0xFF054E65),
      );
    }
  }
}

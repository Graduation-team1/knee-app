import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/user_model.dart';
import 'package:knee_app/x_rays_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
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
          width: double.infinity,
          height: double.infinity,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildInputField('User Name', _userNameController,
                          textCapitalization: TextCapitalization.words),
                      SizedBox(height: 40),
                      _buildInputField('Email', _emailController,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 40),
                      _buildPasswordField(),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _handleSignUp(context),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFF0F8FF),
                          onPrimary: Color(0xFF435C59),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF314441)),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(color: Color(0xFFF0F8FF)),
                                ),
                              ],
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
      {bool obscureText = false,
        TextCapitalization? textCapitalization,
        TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 18, color: Color(0xFFF0F8FF)),
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
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          keyboardType: keyboardType ?? TextInputType.text,
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
          style: TextStyle(fontSize: 18, color: Color(0xFFF0F8FF)),
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

  void _handleSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        // Set user information using Provider
        Provider.of<UserModel>(context, listen: false).setUserInformation(
          _userNameController.text,
          _emailController.text,
        );

        // Show a dialog for 2 seconds
        Fluttertoast.showToast(
            msg: 'You have successfully signed up!',
            backgroundColor: Color(0xFFF0F8FF),
            textColor: Color(0xFF054E65),
            );

        // Delay navigation for 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Close the dialog
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => XRaysPage()),
          );
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          Fluttertoast.showToast(
            msg: 'Weak Password Please enter a Strong Password.',
            backgroundColor: Color(0xFFF0F8FF),
            textColor: Color(0xFF054E65),
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          Fluttertoast.showToast(
            msg: 'The account already exists for that email.',
            backgroundColor: Color(0xFFF0F8FF),
            textColor: Color(0xFF054E65),
          );
        } else if (e.code == 'invalid-email') {
          Fluttertoast.showToast(
            msg: 'Invalid Email Please enter a valid email address.',
            backgroundColor: Color(0xFFF0F8FF),
            textColor: Color(0xFF054E65),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xFF06607B),
            ), // Change title text color
          ),
          content: Text(
            content,
            style: TextStyle(
                color: Color(0xFF054E65)), // Change content text color
          ),
          backgroundColor: Color(0xFFF0F8FF),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK',
                  style: TextStyle(
                    color: Color(0xFF06607B),
                  )), // Change button text color
            ),
          ],
        );
      },
    );
  }
}
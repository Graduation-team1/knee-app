import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knee_app/copy.dart';
import 'package:knee_app/sign_up_page.dart';

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
                          onPrimary: Color(0xFF435C59),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 20, color: Color(0xFF06607B)
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
        );
        Navigator.of(context).pushReplacementNamed('HomePage');
      } on FirebaseAuthException catch (e) {
        String errorMessage;

        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage =
              'An unexpected error occurred. Please try again later.';
        }

        // Display the error message in a dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(
                // Customize the colors as needed
                primaryColor: Color(0xFF06607B), // Change the color of the title and button text
                backgroundColor: Color(0xFFF0F8FF), // Change the color of the alert background
                textTheme: TextTheme(),
              ),
              child: AlertDialog(
                title: Text('Sign In Failed',
                style: TextStyle(color: Color(0xFF06607B)),),
                content: Text(errorMessage,style: TextStyle(color: Color(
                    0xFF054E65)),),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('OK',style: TextStyle(color: Color(0xFF06607B)),),
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }
}

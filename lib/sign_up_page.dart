import 'package:flutter/material.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/x_rays_page.dart';


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
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF06607B),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildInputField('User Name', _userNameController, textCapitalization: TextCapitalization.words),
                  SizedBox(height: 40),
                  _buildInputField('Email', _emailController, keyboardType: TextInputType.emailAddress),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(fontSize: 16, color: Color(0xFF314441)),
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
              borderSide: BorderSide(color: Color(0xFFF0F8FF), style: BorderStyle.solid),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF0F8FF), style: BorderStyle.solid),
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
              borderSide: BorderSide(color: Color(0xFFF0F8FF), style: BorderStyle.solid),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF0F8FF), style: BorderStyle.solid),
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

  void _handleSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Add your sign-up logic here
      // Navigate to the next screen on success
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => XRaysPage()));
    }
  }
}

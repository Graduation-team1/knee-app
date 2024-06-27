// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:knee_app/constants.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulating an asynchronous task with a delay
      await Future.delayed(Duration(seconds: 2));

      // Clear text controllers
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();

      // Hide loading indicator
      setState(() {
        _isLoading = false;
      });

      // Show toast message
      Fluttertoast.showToast(
        msg: 'Thank you for reaching out! Your message has been sent successfully.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kPrimaryColor,
        textColor: kScaffoldColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: kScaffoldColor, // Change to your desired app bar color
      ),
      backgroundColor: kScaffoldColor, // Change to your desired background color
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'How can we help you?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Your Name',
                          labelStyle: TextStyle(color: kPrimaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                        ),
                        style: TextStyle(color: kPrimaryColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Your Email',
                          labelStyle: TextStyle(color: kPrimaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                        ),
                        style: TextStyle(color: kPrimaryColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          labelStyle: TextStyle(color: kPrimaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                        ),
                        style: TextStyle(color: kPrimaryColor),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            _isLoading ? kPrimaryColor : kPrimaryColor,
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(kScaffoldColor),
                        )
                            : Text('Submit', style: TextStyle(color: kScaffoldColor)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
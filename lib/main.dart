import 'package:flutter/material.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/x_rays_page.dart';
import 'splash_screen.dart';
import 'sign_up_page.dart';
import 'home_page.dart';
import 'chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Knee Osteoarthritis App",
      theme: ThemeData(brightness: Brightness.dark,),
      debugShowCheckedModeBanner: false,
      home: SignUpPage(), // Use Chat widget as the home
    );
  }
}

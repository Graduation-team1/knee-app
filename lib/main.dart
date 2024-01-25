import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knee_app/radiology.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/user_model.dart';
import 'package:knee_app/x_rays_page.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'sign_up_page.dart';
import 'home_page.dart';
import 'chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:knee_app/navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDpMe_rxQyEC2jtA1X8Hvyi8qtfijXKg8E",
      appId: "1:1056750729374:android:f4936e33e01590a5e7238f",
      messagingSenderId: "1056750729374",
      projectId: "knee-app-34a86",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        routes: {'HomePage': (context) => XRaysPage()},
        title: "Knee Osteoarthritis App",
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

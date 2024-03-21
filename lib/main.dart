import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knee_app/bottomNavbar.dart';
import 'package:knee_app/exercise.dart';
import 'package:knee_app/global_bloc.dart';
import 'package:knee_app/help.dart';
import 'package:knee_app/osteroNutrition.dart';
import 'package:knee_app/pages/home_page.dart';
import 'package:knee_app/radiology.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/x_rays_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'splash_screen.dart';
import 'sign_up_page.dart';
import 'chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:knee_app/navbar.dart';

void main() async {
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: "Knee Osteoarthritis App",
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          routes: {
            '/help': (context) => Help(),
            '/rating': (context) => RatingPage(),
            '/exercise': (context) => ExercisePage(),
            '/xray':(context) => XRaysPage(),
            '/osteroNutrition':(context) => OsteoarthritisPage(),
          },
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                return _buildHomePage(snapshot.data);
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildHomePage(User? user) {
    if (user != null) {
      return Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return SplashScreen();
            },
          );
        },
      );
    } else {
      return SplashScreen();
    }
  }
}


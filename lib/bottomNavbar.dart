// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:knee_app/chat.dart';
// import 'package:knee_app/exercise.dart';
// import 'package:knee_app/help.dart';
// import 'package:knee_app/radiology.dart';
// import 'package:knee_app/rating_bar.dart';
// import 'package:knee_app/x_rays_page.dart';
//
// class BottomNavBar extends StatefulWidget {
//   static final GlobalKey<_BottomNavBarState> navKey =
//   GlobalKey<_BottomNavBarState>();
//   static final GlobalKey<NavigatorState> navigatorKey =
//   GlobalKey<NavigatorState>();
//
//   const BottomNavBar({Key? key}) : super(key: key);
//
//   static void toggleBottomNavBar(bool show) {
//     navKey.currentState?.toggleBottomNavBar(show);
//   }
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
// class _BottomNavBarState extends State<BottomNavBar> {
//   void toggleBottomNavBar(bool show) {
//     setState(() {
//       _showBottomNavBar = show;
//     });
//
//     if (show && _selectedIndex == 1) {
//       _navigatorKey.currentState?.maybePop();
//     }
//   }
//
//   List<Widget> screens = [
//     XRaysPage(),
//     Chat(),
//     RadiologyPage(),
//   ];
//   int _selectedIndex = 0;
//   bool _showBottomNavBar = true;
//
//   GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: BottomNavBar.navKey,
//       backgroundColor: Color(0xFF06607B),
//       bottomNavigationBar: _showBottomNavBar
//           ? Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
//             color: Color(0xFFF0F8FF),
//             boxShadow: [
//               BoxShadow(
//                   blurRadius: 20,
//                   color: Colors.black.withOpacity(.1))
//             ]),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
//             child: GNav(
//               gap: 3,
//               activeColor: Color(0xFF06607B),
//               iconSize: 26,
//               padding:
//               EdgeInsets.symmetric(horizontal: 18, vertical: 5),
//               duration: Duration(milliseconds: 600),
//               tabs: const [
//                 GButton(
//                   icon: Icons.document_scanner_outlined,
//                   iconColor: Color(0xFF06607B),
//                   text: 'X-Ray',
//                   iconSize: 26,
//                   textSize: 26,
//                 ),
//                 GButton(
//                   icon: Icons.chat_outlined,
//                   iconColor: Color(0xFF06607B),
//                   text: 'Chat',
//                   iconSize: 26,
//                   textSize: 26,
//                 ),
//                 GButton(
//                   icon: Icons.history,
//                   iconColor: Color(0xFF06607B),
//                   text: 'Radiology',
//                   iconSize: 26,
//                   textSize: 26,
//                 ),
//               ],
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   if (_selectedIndex != index) {
//                     _selectedIndex = index;
//                     _navigatorKey.currentState
//                         ?.popUntil((route) => route.isFirst);
//                   }
//                   if (index == 1) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => Chat()),
//                     );
//                   }
//                 });
//               },
//             ),
//           ),
//         ),
//       )
//           : SizedBox(), // Placeholder for when _showBottomNavBar is false
//       body: Navigator(
//         key: _navigatorKey,
//         onGenerateRoute: (settings) {
//           return MaterialPageRoute(
//             settings: settings,
//             builder: (context) {
//               switch (settings.name) {
//                 case '/help':
//                   _selectedIndex = -1;
//                   _showBottomNavBar = true; // Show the bottom nav bar
//                   return Help();
//                 case '/rating':
//                   _selectedIndex = -1;
//                   _showBottomNavBar = true; // Show the bottom nav bar
//                   return RatingPage();
//                 case '/exercise':
//                   _selectedIndex = -1;
//                   _showBottomNavBar = true; // Show the bottom nav bar
//                   return ExercisePage();
//                 default:
//                 // If none of the above, show the selected screen
//                   return screens[_selectedIndex];
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:knee_app/bottomnavclipper.dart';
import 'package:knee_app/chat.dart';
import 'package:knee_app/constants.dart';
import 'package:knee_app/contacts.dart';
import 'package:knee_app/exercise.dart';
import 'package:knee_app/help.dart';
import 'package:knee_app/osteroNutrition.dart';
import 'package:knee_app/pages/home_page.dart';
import 'package:knee_app/radiology.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:knee_app/x_rays_page.dart';
import 'package:lottie/lottie.dart';

import 'lottie.dart';

class BottomNavBar extends StatefulWidget {
  static final GlobalKey<_BottomNavBarState> navKey =
  GlobalKey<_BottomNavBarState>();
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  const BottomNavBar({Key? key}) : super(key: key);

  static void toggleBottomNavBar(bool show) {
    navKey.currentState?.toggleBottomNavBar(show);
  }

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void toggleBottomNavBar(bool show) {
    setState(() {
      _showBottomNavBar = show;
    });

    if (show && _selectedIndex == 1) {
      _navigatorKey.currentState?.maybePop();
    }
    if (show && _selectedIndex == 3) {
      _navigatorKey.currentState?.maybePop();
    }
  }

  List<Widget> screens = [
    XRaysPage(),
    Chat(),
    RadiologyPage(),
    HomePage(),
  ];
  int _selectedIndex = 0;
  bool _showBottomNavBar = true;

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: BottomNavBar.navKey,
      bottomNavigationBar: _showBottomNavBar
          ? Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFFF0F8FF),
        ),
        child: Container(
          height: 65,
          child: ClipPath(
            clipper: BottomNavBarClipper(),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  if (_selectedIndex != index) {
                    _selectedIndex = index;
                    _navigatorKey.currentState
                        ?.popUntil((route) => route.isFirst);
                  }
                  if (index == 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Chat()),
                    );
                  }
                  if (index == 3) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                });
              },
              elevation: 0.0,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: LottieIcon(
                    animationAsset: 'assets/icons/animationhome.json',
                    size: 25.0,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: LottieIcon(
                    animationAsset: 'assets/icons/animationchat.json',
                    size: 35.0,
                  ),
                  label: 'AI Assistant',
                ),
                BottomNavigationBarItem(
                  icon: LottieIcon(
                    animationAsset: 'assets/icons/animationhistory.json',
                    size: 25.0,
                  ),
                  label: 'Radiology',
                ),
                BottomNavigationBarItem(
                  icon: LottieIcon(
                    animationAsset: 'assets/icons/animationbell.json',
                    size: 35.0,
                  ),
                  label: 'Reminder',
                ),
              ],
            ),
          ),
        ),
      )
          : SizedBox(),

      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                case '/help':
                  _selectedIndex = -1;
                  _showBottomNavBar = true; // Show the bottom nav bar
                  return Help();
                case '/rating':
                  _selectedIndex = -1;
                  _showBottomNavBar = true; // Show the bottom nav bar
                  return RatingPage();
                case '/exercise':
                  _selectedIndex = -1;
                  _showBottomNavBar = true; // Show the bottom nav bar
                  return ExercisePage();
                case '/osteroNutrition':
                  _selectedIndex = -1;
                  _showBottomNavBar = true; // Show the bottom nav bar
                  return OsteoarthritisPage();
                case '/contacts':
                  _selectedIndex = -1;
                  _showBottomNavBar = true; // Show the bottom nav bar
                  return ContactUsPage();
                default:
                  return screens[_selectedIndex];
              }
            },
          );
        },
      ),
    );
  }
}


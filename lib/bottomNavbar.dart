import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:knee_app/chat.dart';
import 'package:knee_app/radiology.dart';
import 'package:knee_app/x_rays_page.dart';

class BottomNavBar extends StatefulWidget {
  static final GlobalKey<_BottomNavBarState> navKey =
  GlobalKey<_BottomNavBarState>();
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  const BottomNavBar({Key? key}) : super(key: key);

  // New method to toggle bottom navbar from outside the state
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
  }

  List<Widget> screens = [
    XRaysPage(),
    Chat(),
    RadiologyPage(),
  ];
  int _selectedIndex = 0;
  bool _showBottomNavBar = true;

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: BottomNavBar.navKey,
      backgroundColor: Color(0xFF06607B),
      bottomNavigationBar: _showBottomNavBar
          ? CurvedNavigationBar(
        color: Color(0xFFF0F8FF),
        index: _selectedIndex,
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.document_scanner_outlined,
                  size: 28,
                  color: _selectedIndex == 0
                      ? Color(0xFFF0F8FF)
                      : Color(0xFF06607B)),
              Text('X_Ray',
                  style: TextStyle(
                      fontSize: 12,
                      color: _selectedIndex == 0
                          ? Color(0xFFF0F8FF)
                          : Color(0xFF06607B))),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat_outlined,
                  size: 28,
                  color: _selectedIndex == 1
                      ? Color(0xFFF0F8FF)
                      : Color(0xFF06607B)),
              Text('AI Assistant',
                  style: TextStyle(
                      fontSize: 12,
                      color: _selectedIndex == 1
                          ? Color(0xFFF0F8FF)
                          : Color(0xFF06607B))),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history,
                  size: 28,
                  color: _selectedIndex == 2
                      ? Color(0xFFF0F8FF)
                      : Color(0xFF06607B)),
              Text('Radiology',
                  style: TextStyle(
                      fontSize: 12,
                      color: _selectedIndex == 2
                          ? Color(0xFFF0F8FF)
                          : Color(0xFF06607B))),
            ],
          ),
        ],
        backgroundColor: Color(0xFF06607B),
        buttonBackgroundColor: Colors.transparent,
        height: 55,
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
          });
        },
      )
          : null,
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => screens[_selectedIndex],
          );
        },
      ),
    );
  }
}

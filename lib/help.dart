import 'package:flutter/material.dart';

import 'navbar.dart';
class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: NavBar(),
      appBar: AppBar(backgroundColor: Color(0xFF06607B),
        title: Text('Help'),elevation: 0,
      ),
      backgroundColor: Color(0xFF06607B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Help Page',
              style: TextStyle(fontSize: 20),
            ),
            // Add your home page content here
          ],
        ),
      ),
    );
  }
}

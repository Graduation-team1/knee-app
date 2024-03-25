import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'navbar.dart';

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Color(0xFF06607B),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      elevation: 0,
    ),
      // drawer: NavBar(),
      backgroundColor: Color(0xFF06607B),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               // Adjust the spacing as needed
              Text(
                'Thank you for using the Application.',
                style: TextStyle(fontSize: 28, color: Color(0xFFF0F8FF)),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 80),
              Text(
                'Percentage of Application users',
                style: TextStyle(fontSize: 20, color: Color(0xFFF0F8FF)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              // Circular progress bar with percentage
              CircularProgressIndicatorWidget(),
              SizedBox(height: 40),
              Text(
                'How would you rate our app?',
                style: TextStyle(fontSize: 20, color: Color(0xFFF0F8FF)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 48,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  // color: Colors.amber,
                  color: Color(0xF5034759),
                ),
                onRatingUpdate: (value) {
                  // Handle the selected rating
                  print('Rated: $value');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle the submission or navigation logic
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF435C59), backgroundColor: Color(0xFFF0F8FF),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Submit Rating',
                  style: TextStyle(fontSize: 20),
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}

class CircularProgressIndicatorWidget extends StatelessWidget {
  final double percentage;

  CircularProgressIndicatorWidget({this.percentage = 80.0}); // Set your desired percentage

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed
      height: 180, // Adjust the height as needed
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 10, // Adjust the strokeWidth for a thicker circle
            strokeAlign: 10.0,
            backgroundColor: Color(0x99F0F8FF),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xF5034759)),
          ),
          Text(
            '$percentage%',
            style: TextStyle(fontSize: 30, color: Color(0xFFF0F8FF)),
          ),
        ],
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:knee_app/bottomNavbar.dart';
import 'package:knee_app/constants.dart';
import 'package:knee_app/navbar.dart'; // Replace with the actual path to your bottom_nav_bar.dart file

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        title: Text('Help'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      backgroundColor: kScaffoldColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Welcome to the Knee Osteoarthritis App Help Center!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),
          SizedBox(height: 16),
          Text(
            'How to use the app:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),SizedBox(height: 3),
          Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
                ,color:  kPrimaryColor,
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(12, 194, 199, 1.0),
                  blurRadius: 20,
                  offset: Offset(0,10),
                )]
          ),
              child: Container(padding: EdgeInsets.all(15),

                child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Center(
                    child: Icon(
                      Icons.help,
                      size: 30,
                      color: Color.fromRGBO(73, 73, 70, 1.0)
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '1- Image Upload:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kScaffoldColor),
                  ),
                  Text(
                    '  - Select an existing X-ray image from your gallery if needed.',
                    style: TextStyle(fontSize: 16, color: kScaffoldColor),
                  ),
                  Text(
                    '  - Click on the image to view and confirm before proceeding.',
                    style: TextStyle(fontSize: 16, color: kScaffoldColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '2- Enter Patient Information:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kScaffoldColor),
                  ),
                  Text(
                    '  - Type the patient\'s name in the provided field for better record-keeping.',
                    style: TextStyle(fontSize: 16, color:  kScaffoldColor),
                  ),
                  Text(
                    '  - This step is crucial for tracking and analysis.',
                    style: TextStyle(fontSize: 16, color:  kScaffoldColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '3- Prediction:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  kScaffoldColor),
                  ),
                  Text(
                    '  - Click on the "Predict" button.',
                    style: TextStyle(fontSize: 16, color:  kScaffoldColor),
                  ),
                  Text(
                    '  - The app will analyze the X-ray and provide predictions related to knee osteoarthritis.',
                    style: TextStyle(fontSize: 16, color:  kScaffoldColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '4- View Results:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  kScaffoldColor),
                  ),
                  Text(
                    '  - Once the prediction is complete, results will be displayed on the same screen.',
                    style: TextStyle(fontSize: 16, color:  kScaffoldColor),
                  ),
                  Text(
                    '  - Results include the predicted condition and confidence level.',
                    style: TextStyle(fontSize: 16, color: kScaffoldColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '5- Radiology Reports:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  kScaffoldColor),
                  ),
                  Text(
                    '  - Access the "Radiology" section to view historical reports.',
                    style: TextStyle(fontSize: 16, color:  kScaffoldColor),
                  ),
                  Text(
                    '  - Reports include details about different X-ray scans.',
                    style: TextStyle(fontSize: 16, color:  kScaffoldColor),
                  ),
                  // Add more steps as needed





                ],),
              ),
          ),
          SizedBox(height: 16),
          Text(
            'FAQs:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),
          SizedBox(height: 3),
          Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
              ,color:  kPrimaryColor,
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(12, 194, 199, 1.0),
                  blurRadius: 20,
                  offset: Offset(0,10),
                )]
          ),
             child:Container(padding: EdgeInsets.all(15),
               child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text(
                 '1. Q: How often should I use the app?',
                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kScaffoldColor),
               ),Text(
                 'A: For regular monitoring, use the app whenever you have new X-ray images. Consult your healthcare provider for a recommended frequency.',
                 style: TextStyle(fontSize: 16, color: kScaffoldColor),
               ),],),
             )
          ),
          SizedBox(height: 2),
          Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
              ,color:  kPrimaryColor,
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(12, 194, 199, 1.0),
                  blurRadius: 20,
                  offset: Offset(0,10),
                )]
          ),
              child:Container(padding: EdgeInsets.all(15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text(
                  '2. Q: How accurate are the predictions?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kScaffoldColor),
                ),Text(
                  'A: The app provides predictions based on the analysis of X-ray images. Consult with a healthcare professional for a comprehensive diagnosis.',
                  style: TextStyle(fontSize: 16, color: kScaffoldColor),
                ),],),
              )

          ),SizedBox(height: 2),
          Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
              ,color:  kPrimaryColor,
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(12, 194, 199, 1.0),
                  blurRadius: 20,
                  offset: Offset(0,10),
                )]
          ),
              child:Container(padding: EdgeInsets.all(15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text(
                  '3. Q: Can I share reports with my doctor?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kScaffoldColor),
                ),Text(
                  'A: Yes, you can save and share the radiology reports generated by the app. It\'s recommended to consult with your doctor for a detailed analysis.',
                  style: TextStyle(fontSize: 16, color: kScaffoldColor),
                ),],),
              )
          ),
          SizedBox(height: 2),
          Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
              ,color:  kPrimaryColor,
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(12, 194, 199, 1.0),
                  blurRadius: 20,
                  offset: Offset(0,10),
                )]
          ),
              child:Container(padding: EdgeInsets.all(15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text(
                  '4. Q: What do the confidence levels mean?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kScaffoldColor),
                ),Text(
                  'A: Confidence levels represent the app\'s certainty about the predicted condition. Higher confidence indicates a more reliable prediction.',
                  style: TextStyle(fontSize: 16, color: kScaffoldColor),
                ),],),
              )
          ),
          // Add more FAQs as needed
        ],
      ),
    );
  }
}


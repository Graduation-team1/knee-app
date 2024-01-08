import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class XRaysPage extends StatefulWidget {
  @override
  _XRaysPageState createState() => _XRaysPageState();
}

class _XRaysPageState extends State<XRaysPage> {
  String? imagePath;
  String? machineResponse; // Variable to hold the response from the machine

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'X-Rays',
          style: TextStyle(color: Color(0xFFF0F8FF)),
        ),
        backgroundColor: Color(0xFF06607B),
      ),
      body: Container(
        color: Color(0xFF06607B), // Background color of the body
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the chosen image if available, otherwise display the default photo
              imagePath != null
                  ? Image.file(
                File(imagePath!),
                height: 200,
                width: 200,
              )
                  : Image.asset(
                'assets/Moderate (3).png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.image , color: Color(0xFFF0F8FF)),
                onPressed: () async {
                  String? chosenImagePath = await getImagePath();
                  if (chosenImagePath != null) {
                    setState(() {
                      imagePath = chosenImagePath;
                    });
                    await uploadPhoto(chosenImagePath);
                  }
                },
              ),
              SizedBox(height: 20),
              // Display the machine response if available
              machineResponse != null
                  ? Text(
                'Machine Response: $machineResponse',
                style: TextStyle(color: Color(0xFFF0F8FF),
                    fontSize: 20),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getImagePath() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  Future<void> uploadPhoto(String imagePath) async {
    final apiUrl = 'http://192.168.1.5:5000/predictApi'; // Replace with your actual API endpoint

    // Prepare the image file
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(http.MultipartFile.fromBytes(
      'fileup',
      imageBytes,
      filename: 'xray_image.jpg', // Provide a filename for the image
    ));

    try {
      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        // Parse and handle the response
        String responseBody = await response.stream.bytesToString();
        // Update the UI or perform actions based on the response
        setState(() {
          machineResponse = responseBody;
        });
        print('API Response: $responseBody');
      } else {
        // Handle errors or display appropriate messages
        print('Failed to upload image. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}

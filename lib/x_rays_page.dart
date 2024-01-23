import 'dart:convert';
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
  String? machineResponse;
  TextEditingController _userInputController = TextEditingController();

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
        color: Color(0xFF06607B),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagePath != null
                  ? Image.file(
                File(imagePath!),
                height: 200,
                width: 200,
              )
                  : Image.asset(
                'assets/bonee.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.image, color: Color(0xFFF0F8FF)),
                    onPressed: () async {
                      String? chosenImagePath = await getImagePath();
                      if (chosenImagePath != null) {
                        setState(() {
                          imagePath = chosenImagePath;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: _userInputController,
                      decoration: InputDecoration(
                        hintText: 'Type a name...',
                        hintStyle: TextStyle(color: Color(0xFF06607B)),
                        filled: true,
                        fillColor: Color(0xFFF0F8FF),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                          BorderSide(color: Color(0xFFF0F8FF)), // Color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                          BorderSide(color: Color(0xFF06607B)), // Color when focused
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                      ),
                      cursorColor: Color(0xFF06607B), // Color of the cursor
                      style: TextStyle(
                        color: Color(0xFF06607B), // Color of the text
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              machineResponse != null
                  ? Center(
                child: Text(
                  '${formatMachineResponse(machineResponse!)}',
                  style: TextStyle(
                    color: Color(0xFFF0F8FF),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (imagePath != null) {
            uploadPhoto(imagePath!);
          }
        },
        tooltip: 'Predict',
        child: Icon(Icons.send,color:Color(0xFF06607B)),
        backgroundColor: Color(0xFFF0F8FF),
      ),
    );
  }

  Future<String?> getImagePath() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  Future<void> uploadPhoto(String imagePath) async {
    final apiUrl = 'http://192.168.1.5:5000/predictApi';

    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(http.MultipartFile.fromBytes(
      'fileup',
      imageBytes,
      filename: 'xray_image.jpg',
    ));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        setState(() {
          machineResponse = responseBody;
        });
        print('API Response: $responseBody');
      } else {
        print('Failed to upload image. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  String formatMachineResponse(String response) {
    Map<String, dynamic> parsedResponse = json.decode(response);
    double confidence = parsedResponse['confidence'];
    String result = parsedResponse['result'];

    return ' Result: $result,\nConfidence: ${(confidence * 100).toStringAsFixed(2)}%';
  }
}

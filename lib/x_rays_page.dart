import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:knee_app/bottomNavbar.dart';
import 'package:knee_app/constants.dart';
import 'package:knee_app/navbar.dart';
import 'package:knee_app/database.dart'; // Import your database helper

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
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          'X-Rays',
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: kScaffoldColor,
      ),
      body: Container(
        color: kScaffoldColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imagePath != null
                    ? ClipRRect(
            borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            child: Image.file(
              File(imagePath!),
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
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
                      icon: Icon(Icons.image, color: kPrimaryColor),
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
                      height: 50,
                      child: TextFormField(
                        controller: _userInputController,
                        decoration: InputDecoration(
                          hintText: 'Type a name...',
                          hintStyle: TextStyle(color: kScaffoldColor),
                          filled: true,
                          fillColor: kPrimaryColor,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: kPrimaryColor), // Color when not focused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: kScaffoldColor), // Color when focused
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                        ),
                        cursorColor: kScaffoldColor, // Color of the cursor
                        style: TextStyle(
                          color: kScaffoldColor, // Color of the text
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
                      color: kPrimaryColor,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (imagePath != null) {
            String? response = await uploadPhoto(imagePath!);
            if (response != null) {
              // Store information locally
              saveToHistory(
                userInput: _userInputController.text,
                imagePath: imagePath!,
                machineResponse: response,
              );
              setState(() {
                machineResponse = response;
              });
            }
          }
        },
        tooltip: 'Predict',
        child: Icon(Icons.send, color: kScaffoldColor),
        backgroundColor: kPrimaryColor,
        splashColor: Color(0x98021E3D), // Set your desired splash color
      ),

    );
  }

  Future<String?> getImagePath() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  Future<String?> uploadPhoto(String imagePath) async {
    final apiUrl = 'http://192.168.1.13:5000/predictApi';

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
        print('API Response: $responseBody');
        return responseBody;
      } else {
        print('Failed to upload image. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  String formatMachineResponse(String response) {
    Map<String, dynamic> parsedResponse = json.decode(response);
    double confidence = parsedResponse['confidence'];
    String result = parsedResponse['result'];

    return ' Result: $result,\nConfidence: ${(confidence * 100).toStringAsFixed(2)}%';
  }

  Future<void> saveToHistory({
    required String userInput,
    required String imagePath,
    required String machineResponse,
  }) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.insertHistory(
      userInput: userInput,
      imagePath: imagePath,
      machineResponse: machineResponse,
    );
  }
}

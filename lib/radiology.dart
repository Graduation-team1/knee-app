import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:knee_app/navbar.dart';
import 'package:knee_app/database.dart'; // Import your database helper

class RadiologyPage extends StatefulWidget {
  @override
  _RadiologyPageState createState() => _RadiologyPageState();
}

class _RadiologyPageState extends State<RadiologyPage> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  Future<void> loadHistory() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String, dynamic>> history = await helper.queryAllRows();
    setState(() {
      _history = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Radiology'),
        backgroundColor: Color(0xFF06607B),
      ),
      backgroundColor: Color(0xFF06607B),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/logo-no-background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String value) {
                      // Implement search logic here if needed
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Color(0xFFF0F8FF),
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(File(_history[index]['imagePath'])),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${_history[index]['userInput']}',
                                style: TextStyle(color: Color(0xFF06607B)),
                              ),
                              Text(
                                formatMachineResponse(_history[index]['machineResponse']),
                                style: TextStyle(color: Color(0xFF06607B)),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete, color: Color(0xFF065972)),
                            onPressed: () {
                              deleteHistory(_history[index]['_id']);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatMachineResponse(String response) {
    Map<String, dynamic> parsedResponse = json.decode(response);
    double confidence = parsedResponse['confidence'];
    String result = parsedResponse['result'];

    return 'Result: $result,\nConfidence: ${(confidence * 100).toStringAsFixed(2)}%';
  }

  Future<void> deleteHistory(int id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int result = await helper.deleteHistory(id);
    if (result > 0) {
      // Row deleted successfully, refresh the UI
      loadHistory();
    }
  }
}

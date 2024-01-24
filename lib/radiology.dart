import 'package:flutter/material.dart';

import 'navbar.dart';

class RadiologyPage extends StatefulWidget {
  @override
  _RadiologyPageState createState() => _RadiologyPageState();
}

class _RadiologyPageState extends State<RadiologyPage> {
  final List<String> _suggestions = [
    'Brain MRI',
    'Chest X-ray',
    'Abdominal CT',
    'Spine MRI',
    'Bone Scan',
    'Mammography',
    'Ultrasound',
    'PET Scan',
    'Angiography',
    'Fluoroscopy',
    'BADR',
    'HAMED',
    'ABDULLAH',
  ];

  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredSuggestions = <String>[];

  @override
  void initState() {
    _filteredSuggestions = _suggestions;
    super.initState();
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
                      image: AssetImage('assets/Moderate (3).png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _filteredSuggestions = _suggestions
                            .where((String suggestion) =>
                            suggestion.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
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
                itemCount: _filteredSuggestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Color(0xFFF0F8FF),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/Moderate (3).png'),
                      ),
                      title: Text(
                        _filteredSuggestions[index],
                        style: TextStyle(color: Color(0xFF06607B)),
                      ),
                      trailing: Text(
                        'Report Result',
                        style: TextStyle(color: Color(0xFF06607B)),
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
}

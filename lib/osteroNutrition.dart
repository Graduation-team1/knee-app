import 'package:flutter/material.dart';
import 'package:knee_app/constants.dart';

class OsteoarthritisPage extends StatefulWidget {
  @override
  _OsteoarthritisPageState createState() => _OsteoarthritisPageState();
}

class _OsteoarthritisPageState extends State<OsteoarthritisPage> {
  String _selectedType = 'Healthy'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor, // Set background color for the screen
      appBar: AppBar(
        title: Text('Osteoarthritis Nutrition'),
        backgroundColor: kScaffoldColor, // Set background color for the AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Nutritional Awareness for Osteoarthritis',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor, // Set text color for the title
                ),
              ),
            ),
            _buildTypeSelector(),
            SizedBox(height: 16.0),
            _buildAdviceSection(),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select Osteoarthritis Type:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor, // Text color for the label
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity, // Make the dropdown take full width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: kPrimaryColor, // Background color for the dropdown button
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                items: <String>['Healthy', 'Moderate', 'Severe']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: kScaffoldColor, // Text color for the dropdown item
                      ),
                    ),
                  );
                }).toList(),
                style: TextStyle(
                  color: kScaffoldColor, // Text color for the selected item
                ),
                dropdownColor: kPrimaryColor, // Background color for the dropdown list
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceSection() {
    Map<String, List<String>> adviceMap = {
      'Healthy': [
        'Follow a balanced diet with plenty of fruits, vegetables, lean proteins, and whole grains.',
        'Stay physically active to maintain joint health and flexibility.',
        'Maintain a healthy weight to reduce stress on your joints.',
        'Include calcium-rich foods in your diet to support bone health, such as dairy products, leafy greens, and fortified foods.',
        'Limit processed foods, sugary beverages, and excessive sodium intake, as they can contribute to inflammation and weight gain.',
      ],
      'Moderate': [
        'Incorporate anti-inflammatory foods such as fatty fish, nuts, seeds, and leafy greens into your diet.',
        'Consider taking glucosamine and chondroitin supplements to support joint function.',
        'Limit processed foods, refined sugars, and saturated fats to reduce inflammation in the body.',
        'Stay physically active with low-impact exercises such as swimming, cycling, or yoga to maintain joint mobility and strength.',
        'Manage stress through relaxation techniques like deep breathing, meditation, or gentle stretching exercises.',
      ],
      'Severe': [
        'Prioritize foods rich in omega-3 fatty acids, antioxidants, and vitamin D to reduce inflammation and support joint health.',
        'Consult with a registered dietitian to develop a personalized meal plan that meets your nutritional needs and supports your overall health.',
        'Stay hydrated by drinking plenty of water throughout the day to keep your joints lubricated and functioning properly.',
        'Consider alternative therapies such as acupuncture, massage therapy, or physical therapy to alleviate pain and improve joint function.',
        'Take breaks and avoid overexertion when performing repetitive tasks to prevent further damage to your joints.',
      ],
    };

    List<String> tips = adviceMap[_selectedType] ?? [];

    Color backgroundColor;
    Color textColor;

    switch (_selectedType) {
      case 'Healthy':
        backgroundColor = kPrimaryColor; // Set background color for Healthy advice
        textColor = kScaffoldColor; // Set text color for Healthy advice
        break;
      case 'Moderate':
        backgroundColor = kPrimaryColor; // Set background color for Moderate advice
        textColor = kScaffoldColor; // Set text color for Moderate advice
        break;
      case 'Severe':
        backgroundColor = kPrimaryColor; // Set background color for Severe advice
        textColor = kScaffoldColor; // Set text color for Severe advice
        break;
      default:
        backgroundColor = kPrimaryColor; // Default background color
        textColor = kScaffoldColor; // Default text color
    }

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: tips.isNotEmpty
            ? Card(
          key: ValueKey<String>(_selectedType),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Advice for $_selectedType Osteoarthritis:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 8.0),
                for (int i = 0; i < tips.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${i + 1}. ${tips[i]}',
                      style: TextStyle(color: textColor),
                    ),
                  ),
              ],
            ),
          ),
        )
            : SizedBox.shrink(),
      ),
    );
  }
}

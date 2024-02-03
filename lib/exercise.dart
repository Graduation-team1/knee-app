import 'package:flutter/material.dart';
import 'navbar.dart';

class ExercisePage extends StatelessWidget {
  ExercisePage({Key? key}) : super(key: key);

  // Define a list of exercises
  final List<String> exercises = [
    'Exercise 1',
    'Exercise 2',
    'Exercise 3',
    'Exercise 4',
    'Exercise 5',
    'Exercise 6',
    'Exercise 7',
    'Exercise 8',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color(0xFF06607B),
        title: Text('Exercises'),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF06607B),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFFF0F8FF),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            child: ListTile(
              title: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/exercise${index + 1}.jpg', // Replace with the actual path to your image
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    exercises[index],
                    style: TextStyle(fontSize: 18, color: Color(0xFF06607B)),
                  ),
                ],
              ),
              onTap: () {
                // Navigate to the details page for the selected exercise
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDetailsPage(exerciseName: exercises[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Create a new page for displaying exercise details
class ExerciseDetailsPage extends StatelessWidget {
  final String exerciseName;

  ExerciseDetailsPage({required this.exerciseName});

  // Map to store details for each exercise
  static Map<String, ExerciseDetails> exerciseDetailsMap = {
    'Exercise 1': ExerciseDetails(
      description: '* Knee extension while sitting *'
          '\n\n- Sit upright with your legs dangling, and then lift it up from the knee to straighten your knee.'
          '\n\n- Wait 5 seconds in this position and slowly lower your leg.'
          '\n\n- Repeat the movement 10 times.',
      imagePath: 'assets/exercise1.jpg', // Replace with the actual path to your image
    ),
    'Exercise 2': ExerciseDetails(
      description: '* Knee flexion while lying prone *'
          '\n\n- Lie prone. Try to touch your heel towards your hip by bending your knee.'
          '\n\n- Then repeat for the other knee.'
          '\n\n- Repeat the movement 10 times.',
      imagePath: 'assets/exercise2.jpg', // Replace with the actual path to your image
    ),
    'Exercise 3': ExerciseDetails(
      description: '* Hamstring stretching *'
          '\n\n- Lie in supine position. Fold a sheet and make it into a string and put it under your feet.'
          '\n\n- Stretch the back of your patient leg by pulling the sheet without lifting your sturdy leg from the bed and bending your knees.'
          '\n\n- Wait 5 seconds in this position and slowly lower the leg. Then repeat for the other leg.',
      imagePath: 'assets/exercise3.jpg', // Replace with the actual path to your image
    ),
    'Exercise 4': ExerciseDetails(
      description: '* Isometric knee extension *'
          '\n\n- Put a towel roll under your knee. By pulling your knee cap bone upwards and pressing the bottom of your knee towards the towel roll, muscle your thigh (thigh muscle) at the front of your leg.'
          '\n\n- Wait for 5 seconds in this position and relax.'
          '\n\n- Repeat the movement 10 times for each knee',
      imagePath: 'assets/exercise4.jpg', // Replace with the actual path to your image
    ),
    'Exercise 5': ExerciseDetails(
      description: '* Lie in the prone position *'
          '\n\n- Put a thin pillow on the bottom of your thigh bone and hang your leg from the bed from your knee.'
          '\n\n- In this position, wait 10 minutes with the back of your leg stretched.',
      imagePath: 'assets/exercise5.jpg', // Replace with the actual path to your image
    ),
    'Exercise 6': ExerciseDetails(
      description: '* Short Arcs Quad *'
          '\n\n- Place rolled towel or pillow under injured knee. Slowly raise the foot until the knee is straight.'
          '\n\n- Hold for 5 seconds and slowly return to starting position. back of your knee against the roll.'
          '\n\n- Repeat 10 times.',
      imagePath: 'assets/exercise6.jpg', // Replace with the actual path to your image
    ),
    'Exercise 7': ExerciseDetails(
      description: '* Leg abduction *'
          '\n\n- Lie down on your unaffected side, with your head supported by a pillow.'
          '\n\n- Bend the bottom (unaffected) leg, keeping the affected leg straight and your body perpendicular to the bed.'
          '\n\n- Lift the affected leg off the bed.'
          '\n\n- Hold your leg up for 10sec. Repeat 10 times',
      imagePath: 'assets/exercise7.jpg', // Replace with the actual path to your image
    ),
    'Exercise 8': ExerciseDetails(
      description: '* Calf Stretch *'
          '\n\n- Stand facing a wall with the leg to be stretched behind you and the other leg in front. Place your hands or forearms on the wall for support.'
          '\n\n- Slowly bend the front knee, keeping the heel of the leg behind you down on the floor. Once you feel a stretch in you calf muscle at the back of your ankle, hold for 30 seconds.'
          '\n\n- Slowly relax. Perform 3 repetitions.',
      imagePath: 'assets/exercise8.jpg', // Replace with the actual path to your image
    ),


    // Add details for other exercises
  };

  @override
  Widget build(BuildContext context) {
    ExerciseDetails exerciseDetails = exerciseDetailsMap[exerciseName] ?? ExerciseDetails();

    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
        backgroundColor: Color(0xFF06607B),
      ),
      backgroundColor: Color(0xFF06607B),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              child: Image.asset(
                exerciseDetails.imagePath,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  exerciseDetails.description,
                  style: TextStyle(fontSize: 18, color: Color(0xFFF0F8FF)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Class to store exercise details
class ExerciseDetails {
  final String description;
  final String imagePath;

  ExerciseDetails({this.description = 'No description available', this.imagePath = 'assets/default_image.jpg'});
}

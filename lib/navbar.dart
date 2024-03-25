import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knee_app/exercise.dart';
import 'package:knee_app/help.dart';
import 'package:knee_app/lottie.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/sign_up_page.dart';
import 'package:knee_app/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'databaseHelperforProfile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Uint8List? _image;
  String? _userName;
  String? _userEmail;
  void readData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        String email = userData['email'];
        String user_name = userData['user_name'];

        setState(() {
          _userEmail = email;
          _userName = user_name;// Update the email value in the state
        });
      });
    }).catchError((e) {
      print('Error getting documents: $e');
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
    loadImage();
  //  loadUserData();
  }

  Future<void> loadImage() async {
    _image ??= (await loadProfileImage()) as Uint8List?;
    if (mounted) {
      setState(() {});
    }
  }

  Future<Uint8List?> loadProfileImage() async {
    try {
      Database db = await DatabaseHelper.database;
      List<Map<String, dynamic>> result = await db.query('profile_images', orderBy: 'id DESC', limit: 1);
      if (result.isNotEmpty) {
        return result.first['image'] as Uint8List;
      }
    } catch (e) {
      print('Error loading profile image: $e');
      Fluttertoast.showToast(
        msg: 'Error loading profile image: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    }
  }

  /*Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('username');
    _userEmail = prefs.getString('email');
    if (mounted) {
      setState(() {});
    }
  }*/

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFF0F8FF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_userName ?? ''),
            accountEmail: Text(_userEmail ?? ''),
            currentAccountPicture: Stack(
              children: [
                _image != null
                    ? CircleAvatar(radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(radius: 64, backgroundImage: AssetImage('assets/pro.png')),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo, color: Color(0xFFF0F8FF), size: 19,),
                  ),
                  bottom: -15,
                  left: 33,
                ),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B5266),
                  Color(0xFF044E5F),
                  Color(0xFF08849A),
                  Color(0xFF0C6C7D),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListTile(
            leading:LottieIcon(
              animationAsset: 'assets/icons/animationnuitrition.json',
              size: 25.0,
            ),
            minVerticalPadding: 1,
            title: Text('Nutrition', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context,'/osteroNutrition');
            },
          ),
          ListTile(
            leading:LottieIcon(
              animationAsset: 'assets/icons/animationexe.json',
              size: 25.0,
            ),
            minVerticalPadding: 1,
            title: Text('Exercises', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/exercise');
            },
          ),
          ListTile(
            leading:LottieIcon(
              animationAsset: 'assets/icons/animationhelp.json',
              size: 25.0,
            ),
            minVerticalPadding: 1,
            title: Text('Help', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          // Divider(
          //   color: Colors.grey,
          // ),
          ExpansionTile(
            title: Text(
              'Setting',
              style: TextStyle(color: Color(0xFF06607B)),
            ),
            leading: LottieIcon(
              animationAsset: 'assets/icons/animationsetting.json',
              size: 25,
            ),
            collapsedIconColor: Colors.black,
            iconColor: Colors.black,
            childrenPadding: EdgeInsets.only(left: 15),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      leading: Icon(Icons.logout, color: Colors.black, size: 20),
                      minVerticalPadding: 1,
                      title: Text(
                        'Sign Out',
                        style: TextStyle(color: Color(0xFF06607B), fontSize: 13),
                      ),
                      onTap: () => _showSignOutDialog(context),
                    ),
                    Divider(height: 0, color: Colors.grey,indent: 30,endIndent: 30,),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      leading: Icon(Icons.delete, color: Colors.black, size: 20),
                      minVerticalPadding: 1,
                      title: Text(
                        'Delete Account',
                        style: TextStyle(color: Color(0xFF06607B), fontSize: 13),
                      ),
                      onTap: () => _showDeleteAccountDialog(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            leading:LottieIcon(
              animationAsset: 'assets/icons/animationrate.json',
              size: 25.0,
            ),
            minVerticalPadding: 1,
            title: Text('Rate Us', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () async {
              Navigator.pop(context);
              _showRatingDialog(context);
            },

          ),
          ListTile(
            leading:LottieIcon(
              animationAsset: 'assets/icons/animationshare.json',
              size: 25.0,
            ),
            minVerticalPadding: 1,
            title: Text('Share App', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () {
              _shareApp();
            },
          ),

        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Sign Out', style: TextStyle(color: Color(0xFF06607B))),
          content: Text('Are you sure you want to sign out?', style: TextStyle(color: Color(0xFF06607B))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Color(0xFF06607B))),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await deletePassword();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Text('Yes', style: TextStyle(color: Color(0xFF06607B))),
            ),
          ],
        );
      },
    );
  }
  Future<void> deletePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pass');
    await prefs.remove('passs');
  }

  @override
  void dispose() {
    _handleDispose();
    super.dispose();
  }
  Future<void> _handleDispose() async {
    if (_image != null) {
      await DatabaseHelper.saveProfileImage(_image!);
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Delete Account', style: TextStyle(color: Color(0xFF06607B))),
          content: Text('Are you sure you want to delete your account? This action is irreversible.', style: TextStyle(color: Color(0xFF06607B))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Color(0xFF06607B))),
            ),
            TextButton(
              onPressed: () async {
                await _deleteAccount(context);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('pass');
                await prefs.remove('username');
                await prefs.remove('email');
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Delete', style: TextStyle(color: Color(0xFF06607B))),
            ),
          ],
        );
      },
    );
  }
  Future<void> _deleteAccount(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      ByteData defaultImageData = await rootBundle.load('assets/pro.png');
      Uint8List defaultImage = defaultImageData.buffer.asUint8List();
      await DatabaseHelper.saveProfileImage(defaultImage);
    } catch (e) {
      print('Error deleting account: $e');
    }
  }


  void _shareApp() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/app-release.apk');
      final List<int> apkBytes = bytes.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/app-release.apk');
      await tempFile.writeAsBytes(apkBytes);

      Share.shareFiles(['${tempFile.path}'], text: 'Check out this amazing app!');
    } catch (e) {
      print('Error sharing app: $e');
      Fluttertoast.showToast(
        msg: 'Error sharing app: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    }
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = 0;
        return AlertDialog(
          backgroundColor: Color(0xFFF0F8FF),
          title: Text('Rate Us', style: TextStyle(color: Color(0xFF06607B))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color(0xFF06607B),
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
              SizedBox(height: 10),
              Text(
                'Please rate our app',
                style: TextStyle(color: Color(0xFF06607B)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Color(0xFF06607B))),
            ),
            TextButton(
              onPressed: () {
                // Process the rating (save it, send it to a server, etc.)
                print('User rated: $rating');
                Navigator.of(context).pop();
                String message;
                if (rating == 1) {
                  message = 'We\'re sorry to hear that. Please let us know how we can improve.';
                } else if (rating == 2) {
                  message = 'Thank you for your feedback!';
                } else if (rating == 4) {
                  message = 'We\'re glad you liked it!';
                } else if (rating == 5) {
                  message = 'Thank you for your support!';
                } else {
                  message = 'Thank you for rating!';
                }
                Fluttertoast.showToast(
                  msg: message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xFFF0F8FF),
                  textColor:  Color(0xFF06607B),
                );
              },
              child: Text('Submit', style: TextStyle(color: Color(0xFF06607B))),
            ),
          ],
        );
      },
    );
  }


}


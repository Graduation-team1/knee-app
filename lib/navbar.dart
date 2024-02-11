import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knee_app/exercise.dart';
import 'package:knee_app/help.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/sign_up_page.dart';
import 'package:knee_app/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'databaseHelperforProfile.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Uint8List? _image;
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    loadImage();
    loadUserData();
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

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('username');
    _userEmail = prefs.getString('email');
    if (mounted) {
      setState(() {});
    }
  }

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
            leading: Icon(Icons.directions_walk, color: Color(0xFF06607B)),
            title: Text('Exercises', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/exercise');
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Color(0xFF06607B)),
            title: Text('Help', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            leading: Icon(Icons.star_rate_outlined, color: Color(0xFF06607B)),
            title: Text('Rating Us', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/rating');
            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: Color(0xFF06607B)),
            title: Text('Share App', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () {
              _shareApp();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded, color: Color(0xFF06607B)),
            title: Text('Sign Out', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () => _showSignOutDialog(context),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Color(0xFF06607B)),
            title: Text('Delete Account', style: TextStyle(color: Color(0xFF06607B))),
            onTap: () => _showDeleteAccountDialog(context),
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
}


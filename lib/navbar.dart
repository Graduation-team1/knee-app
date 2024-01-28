import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knee_app/chat.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/user_model.dart';
import 'package:knee_app/utils.dart';
import 'package:knee_app/x_rays_page.dart';
import 'package:knee_app/help.dart';
import 'package:knee_app/radiology.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    _image ??= await loadProfileImage();
    // Ensure the widget is rebuilt after the image is loaded
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Drawer(
      backgroundColor: Color(0xFFF0F8FF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userModel.userName ?? ''),
            accountEmail: Text(userModel.userEmail ?? ''),
            currentAccountPicture: Stack(
              children: [
                _image != null
                    ? CircleAvatar(radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(radius: 64, backgroundImage: AssetImage('assets/pro.png')),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo, color: Color(0xFFF0F8FF),size: 19,),
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
          ListTile(leading: Icon(Icons.document_scanner_outlined,color: Color(0xFF06607B),),title: Text('X-Ray Scan',style: TextStyle(color: Color(0xFF06607B)),),onTap:()=>{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>XRaysPage()))
          },),
          ListTile(leading: Icon(Icons.chat_outlined,color: Color(0xFF06607B),),title: Text('AI Assistant',style: TextStyle(color: Color(0xFF06607B)),),onTap:()=>{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Chat()))
          },),
          ListTile(leading: Icon(Icons.settings_backup_restore_outlined,color: Color(0xFF06607B),),title: Text('Radiology',style: TextStyle(color: Color(0xFF06607B)),),onTap:()=>{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RadiologyPage()))
          },),
          ListTile(leading: Icon(Icons.star_rate_outlined,color: Color(0xFF06607B),),title: Text('Rating us',style: TextStyle(color: Color(0xFF06607B)),),onTap:()=>{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RatingPage()))
          },),
          ListTile(leading: Icon(Icons.help_outline,color: Color(0xFF06607B),),title: Text('Help',style: TextStyle(color: Color(0xFF06607B)),),onTap:()=>{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Help()))
          },),
          ListTile(leading: Icon(Icons.logout_rounded,color: Color(0xFF06607B),),title: Text('Sign Out',style: TextStyle(color: Color(0xFF06607B)),),onTap:()=> _showSignOutDialog(),),
        ],
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Sign Out',style: TextStyle(color: Color(0xFF06607B))),
          content: Text('Are you sure you want to sign out?',style: TextStyle(color: Color(0xFF06607B))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(color: Color(0xFF06607B))),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Text('Yes',style: TextStyle(color: Color(0xFF06607B))),
            ),
          ],
        );
      },
    );
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image=img;
    });
  }

  void saveProfileImage(Uint8List image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(image);
    prefs.setString('profile_image', base64Image);
  }



  @override
  void dispose() {
    if (_image != null) {
      saveProfileImage(_image!);
    }
    super.dispose();
  }
}

Future<Uint8List?> loadProfileImage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? base64Image = prefs.getString('profile_image');
  if (base64Image != null) {
    return base64Decode(base64Image);
  }
  return null;
}







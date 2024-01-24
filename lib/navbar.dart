import 'package:knee_app/chat.dart';
import 'package:knee_app/sign_in_page.dart';
import 'package:knee_app/user_model.dart';
import 'package:knee_app/x_rays_page.dart';
import 'package:knee_app/help.dart';
import 'package:knee_app/radiology.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  File? _selectedImage;

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
            currentAccountPicture: GestureDetector(
              onTap: () async {
                // Call function to handle image selection
                File? image = await _pickImage();
                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: _selectedImage != null
                      ? Image.file(
                    _selectedImage!,
                  )
                      : Image.asset('assets/pro.png'),
                ),
              ),
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

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
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
              onPressed: () {
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
}


import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:knee_app/pages/home_page.dart';
import 'package:knee_app/pages/new_entry/new_entry_page.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      // Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),

          ),
              (route) => false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.white,
      child: Center(
        child: FlareActor(
          'assets/animations/Success Check.flr',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: 'Untitiled',
        ),
      ),
    );
  }
}

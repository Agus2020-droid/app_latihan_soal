// import 'dart:async';
// import 'dart:html';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:latihan_soal/constants/r.dart';
import 'package:latihan_soal/views/login_page.dart';
import 'package:latihan_soal/views/main_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      //kondisi
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        //TODO redirect to register or home
        Navigator.of(context).pushReplacementNamed(MainPage.route);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
    });
    return Scaffold(
      backgroundColor: Color(0xff01bdc2),
      body: Center(
          child: Image.asset(
        R.assets.icSplash,
        width: MediaQuery.of(context).size.width * 0.5,
      )),
    );
  }
}

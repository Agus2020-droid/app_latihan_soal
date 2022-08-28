// import 'dart:async';
// import 'dart:html';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:latihan_soal/constants/r.dart';
import 'package:latihan_soal/helpers/preference_helper.dart';
import 'package:latihan_soal/helpers/user_email.dart';
import 'package:latihan_soal/models/network_response.dart';
import 'package:latihan_soal/models/user_by_email.dart';
import 'package:latihan_soal/repository/auth_api.dart';
import 'package:latihan_soal/views/login_page.dart';
import 'package:latihan_soal/views/main_page.dart';
import 'package:latihan_soal/views/register_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail();
      print(user);
      if (user != null) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final dataUser = await AuthApi().getUserByEmail();
          if (dataUser.status == Status.success) {
            final data = UserByEmail.fromJson(dataUser.data!);
            if (data.status == 1) {
              Navigator.of(context).pushReplacementNamed(MainPage.route);
              // print(dataUser.status);

              // await PreferenceHelper().setUserData(data.data!);
            } else {
              Navigator.of(context).pushReplacementNamed(RegisterPage.route);
              // print(dataUser.status);

            }
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });
    // Timer(const Duration(seconds: 2), () async {
    //   final user = UserEmail.getUserEmail();
    //   if (user != null) {
    //     final dataUser = await AuthApi().getUserByEmail();
    //     if (dataUser.status == Status.success) {
    //       final data = UserByEmail.fromJson(dataUser.data!);
    //       if (data.status == 1) {
    //         Navigator.of(context).pushNamed(MainPage.route);
    //       } else {
    //         Navigator.of(context).pushNamed(LoginPage.route);
    //       }
    //     }
    //   }
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => LoginPage()));
    // });
    return Scaffold(
      backgroundColor: Color(0xff01bdc2),
      body: Center(child: Image.asset(R.assets.icSplash)),
    );
  }
}

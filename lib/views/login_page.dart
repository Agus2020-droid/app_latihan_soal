import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:latihan_soal/constants/R/assets.dart';
import 'package:latihan_soal/constants/r.dart';
import 'package:latihan_soal/helpers/preference_helper.dart';
import 'package:latihan_soal/models/network_response.dart';
import 'package:latihan_soal/models/user_by_email.dart';
import 'package:latihan_soal/repository/auth_api.dart';
import 'package:latihan_soal/views/main_page.dart';
import 'package:latihan_soal/views/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f7f8),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                R.strings.login,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(R.assets.imgLogin),
            SizedBox(
              height: 35,
            ),
            Text(
              R.strings.welcome,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              R.strings.loginDesc,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: R.colors.greySubtitle,
              ),
            ),
            Spacer(),
            // if (Platform.isAndroid)
            ButtonLogin(
                onTap: () async {
                  // kondisi sign-in google
                  await signInWithGoogle();

                  // final user = FirebaseAuth.instance.currentUser;
                  // if (user != null) {
                  //   Navigator.of(context).pushNamed(RegisterPage.route);
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text("Gagal Masuk"),
                  //     //durasi snackbar
                  //     duration: Duration(seconds: 2),
                  //   ));
                  // }

                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final dataUser = await AuthApi().getUserByEmail();
                    if (dataUser.status == Status.success) {
                      final data = UserByEmail.fromJson(dataUser.data!);
                      if (data.status == 1) {
                        Navigator.of(context).pushNamed(MainPage.route);

                        await PreferenceHelper().setUserData(data.data!);
                      } else {
                        Navigator.of(context).pushNamed(RegisterPage.route);
                        print(data);
                        // print(user.uid);
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Gagal Masuk"),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                backgroundColor: Colors.white,
                borderColor: R.colors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(R.assets.imgGoogle),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      R.strings.loginWithGoogle,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: R.colors.blackLogin),
                    ),
                  ],
                )),
            // if (Platform.isIOS)
            ButtonLogin(
                onTap: () {},
                backgroundColor: Colors.black,
                borderColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(R.assets.imgApple),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      R.strings.loginWithApple,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.borderColor,
    required this.onTap,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: backgroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: borderColor)),
              fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50)),
          onPressed: onTap,
          child: child,
        ));
  }
}

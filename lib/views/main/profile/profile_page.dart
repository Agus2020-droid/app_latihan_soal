import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:latihan_soal/constants/r.dart';
import 'package:latihan_soal/views/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Akun Saya"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text("Edit", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 28, bottom: 50, left: 15, right: 15),
            decoration: BoxDecoration(
                color: R.colors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9))),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama User",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      Text(
                        "Nama Sekolah User",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  R.assets.imgUser,
                  height: 50,
                  width: 50,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black.withOpacity(0.25))
                ]),
            margin: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Identitas Diri",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Nama Lengkap",
                  style:
                      TextStyle(color: R.colors.greySubtitleHome, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  "Agus Dwi Anggoro",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  "Email",
                  style:
                      TextStyle(color: R.colors.greySubtitleHome, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  "Agus@gmail.com",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  "Jenis Kelamin",
                  style:
                      TextStyle(color: R.colors.greySubtitleHome, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  "Laki-laki",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  "Kelas",
                  style:
                      TextStyle(color: R.colors.greySubtitleHome, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  "XII-IPA",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  "Sekolah",
                  style:
                      TextStyle(color: R.colors.greySubtitleHome, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  "SMK Negeri 1 Purbalingga",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10, color: Colors.black.withOpacity(0.25))
                  ]),
              child: Row(children: [
                Text(
                  "Keluar",
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}

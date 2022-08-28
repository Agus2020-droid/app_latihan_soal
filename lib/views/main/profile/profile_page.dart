import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:latihan_soal/constants/r.dart';
import 'package:latihan_soal/helpers/preference_helper.dart';
import 'package:latihan_soal/models/user_by_email.dart';
import 'package:latihan_soal/views/login_page.dart';
import 'package:latihan_soal/views/main/profile/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData? user;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    user = data;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Akun Saya"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                final result = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return EditProfilePage();
                }));
                print("result");
                print(result);
                if (result == true) {
                  getUserData();
                }
              },
              child: Text("Edit", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 28, bottom: 50, left: 15, right: 15),
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
                              user!.userName!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                            Text(
                              user!.userAsalSekolah!,
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
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.25))
                      ]),
                  margin: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Identitas Diri",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Nama Lengkap",
                        style: TextStyle(
                            color: R.colors.greySubtitleHome, fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user!.userName!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Email",
                        style: TextStyle(
                            color: R.colors.greySubtitleHome, fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user!.userEmail!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                            color: R.colors.greySubtitleHome, fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user!.userGender!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Kelas",
                        style: TextStyle(
                            color: R.colors.greySubtitleHome, fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user!.jenjang!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Sekolah",
                        style: TextStyle(
                            color: R.colors.greySubtitleHome, fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user!.userAsalSekolah!,
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
                    if (kIsWeb) {
                      await GoogleSignIn(
                              clientId:
                                  "951632455737-nk1crkifqs0ph540ifp4g8asiclsncla.apps.googleusercontent.com"
                              // scopes: <String>[
                              //   'email',
                              //   'https://www.googleapis.com/auth/contacts.readonly',
                              // ]
                              )
                          .signOut();
                    } else {
                      await GoogleSignIn().signOut();
                    }
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.route, (route) => false);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            color: Colors.black.withOpacity(0.25))
                      ],
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Keluar",
                        style: TextStyle(
                          color: Colors.red,
                          // fontSize: 12,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
    );
  }
}

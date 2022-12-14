import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:latihan_soal/constants/r.dart';
import 'package:latihan_soal/views/login_page.dart';
import 'package:latihan_soal/views/main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String route = "register_page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { lakiLaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  String gender = "Laki-laki";
  List<String> classSlta = ["10", "11", "12"];
  String selectedClass = "10";
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();

  onTapGender(Gender genderInput) {
    if (genderInput == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f3f5),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          )),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Yuk isi data diri",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
              onTap: () {
                // print(emailController.text);
                // print(namaController.text);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     MainPage.route, (context) => false);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainPage.route, (context) => false);
              },
              backgroundColor: R.colors.primary,
              borderColor: R.colors.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  R.strings.daftar,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegisterTextFileld(
                controller: fullNameController,
                title: 'Nama Lengkap',
                hintText: 'Contoh: Agus Dwi Anggoro',
              ),
              RegisterTextFileld(
                controller: emailController,
                title: 'Email',
                hintText: 'Contoh: agus@example.com',
              ),
              Text(
                "Jenis Kelamin",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: gender == "Laki-laki"
                                ? R.colors.primary
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    width: 1, color: R.colors.greyborder))),
                        onPressed: () {
                          onTapGender(Gender.lakiLaki);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Laki-laki",
                            style: TextStyle(
                                fontSize: 16,
                                color: gender == "Laki-laki"
                                    ? Colors.white
                                    : Color(0xff282828)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: gender == "Perempuan"
                                ? R.colors.primary
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    width: 1, color: R.colors.greyborder))),
                        onPressed: () {
                          onTapGender(Gender.perempuan);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Perempuan",
                            style: TextStyle(
                                fontSize: 16,
                                color: gender == "Perempuan"
                                    ? Colors.white
                                    : Color(0xff282828)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Kelas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: R.colors.greyborder),
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedClass,
                      items: classSlta
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (String? val) {
                        selectedClass = val!;
                        setState(() {});
                      }),
                ),
              ),
              SizedBox(height: 5),
              RegisterTextFileld(
                title: 'Nama Sekolah',
                hintText: 'Nama Sekolah',
              ),
              // Spacer();
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterTextFileld extends StatelessWidget {
  const RegisterTextFileld({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
  }) : super(key: key);
  final String title;
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: R.colors.greyborder),
              borderRadius: BorderRadius.circular(8)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: R.colors.greyHintText)),
          ),
        )
      ],
    );
  }
}

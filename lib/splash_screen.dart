import 'package:flutter/material.dart';
import 'package:penjor_driver/landingpage/v_landingpage.dart';
import 'dart:async';
// import 'dashboard/home_page.dart';
import 'login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String idUser = '';

  ambilProfil() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var xUser = sharedPreferences.get("id_user");
    print("ID USER NYA : $xUser");
    setState(() {
      idUser = xUser;
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
    ambilProfil();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      //cek ada sesion login saat ini
      if (idUser == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      }

      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (_) {
      //     return LoginPage();
      //   }),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 200.0,
          height: 100.0,
        ),
      ),
    );
  }
}

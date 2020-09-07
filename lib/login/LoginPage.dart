import 'package:flutter/material.dart';
import 'package:penjor_driver/Animations/animation.dart';
import 'package:penjor_driver/daftar/daftarPage.dart';
import 'package:penjor_driver/landingpage/v_landingpage.dart';
import '../helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseMessaging fm = FirebaseMessaging();
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final Helper helper = new Helper();

  String tokenFcm = "";

  _LoginPageState() {
    fm.getToken().then((value) => tokenFcm = value);
    fm.configure();
  }

  _prosesLogin() async {
    final response = await http.post(Secrets.BASE_URL + "login", body: {
      "username": _usernameControl.text,
      "password": _passwordControl.text,
      "level": "driver",
      "token_fcm": tokenFcm
    });
    final data = jsonDecode(response.body);

    print("hasil nya : $data");

    String value = data['status'];
    String pesan = data['pesan'];
    String noTelp = data['no_telp'];
    String level = data['level'];
    String idUser = data['id_user'];
    String password = data['password'];
    String nama = data['nama'];
    String email = data['email'];

    if (value == "1") {
      setState(() {
        savePref(noTelp, level, idUser, nama, password, email);
      });
      print(pesan);
      helper.alertLog(pesan);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    } else {
      print(pesan);
      helper.alertLog(pesan);
    }
  }

  savePref(String username, String level, String idUser, String nama,
      String password, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("level", level);
      preferences.setString("username", username);
      preferences.setString("id_user", idUser);
      preferences.setString("nama", nama);
      preferences.setString("password", password);
      preferences.setString("email", email);
    });
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("level");
      preferences.remove("username");
      preferences.remove("id_user");
      preferences.remove("nama");
      preferences.remove("password");
      preferences.remove("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bg.png'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeAnimation(
                                1.6,
                                Container(
                                  margin: EdgeInsets.only(top: 150),
                                  child: Center(
                                    child: Text(
                                      "Penjor ",
                                      style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 40,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 1.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            FadeAnimation(
                                1.6,
                                Container(
                                  margin: EdgeInsets.only(top: 150),
                                  child: Center(
                                    child: Text(
                                      "Driver",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 40,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 1.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: _usernameControl,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordControl,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          GestureDetector(
                            onTap: () {
                              _prosesLogin();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Colors.orange,
                                    Colors.amber,
                                  ])),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.5,
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => DaftarPage()));
                            },
                            child: Text(
                              "Daftar Sekarang",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 20.0),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

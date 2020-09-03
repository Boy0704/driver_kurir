import 'package:flutter/material.dart';
import 'package:penjor_driver/Animations/animation.dart';
import 'package:penjor_driver/landingpage/v_landingpage.dart';

class LoginPage extends StatelessWidget {
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LandingPage()));
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
                        height: 70,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import '../login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nomortelpController = TextEditingController();

  final Helper helper = new Helper();

  bool isEmailValid = false;

  ambilProfil() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = sharedPreferences.get("email");
      namaController.text = sharedPreferences.get("nama");
      nomortelpController.text = sharedPreferences.get("username");
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
    helper.alertLog("Anda Telah Keluar !");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    ambilProfil();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black12,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'My',
                          style: GoogleFonts.portLligatSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffe46b10),
                          ),
                          children: [
                            TextSpan(
                              text: 'Profile',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 10,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     top: 30.0,
                            //     left: 10.0,
                            //   ),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       print("upload");
                            //     },
                            //     child: CircleAvatar(
                            //       radius: 55,
                            //       backgroundColor: Color(0xffFDCF09),
                            //       child: CircleAvatar(
                            //         radius: 50,
                            //         backgroundImage: AssetImage(
                            //             'images/gambar_kurir.jpg'),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20.0),
                            //   child: RichText(
                            //     textAlign: TextAlign.center,
                            //     text: TextSpan(
                            //       text: 'Eko Kurniadi',
                            //       style: GoogleFonts.portLligatSans(
                            //         textStyle:
                            //             Theme.of(context).textTheme.display1,
                            //         fontSize: 20,
                            //         fontWeight: FontWeight.w700,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            Card(
                              elevation: 1,
                              margin: EdgeInsets.all(
                                8.0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      controller: namaController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: "Nama Lengkap",
                                          hintText: "Nama Lengkap"),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    TextField(
                                      controller: nomortelpController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: "Nomor Telp",
                                          hintText: "Nomor Telp"),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          isEmailValid =
                                              EmailValidator.validate(text);
                                        });
                                      },
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: "Email Address",
                                          hintText: "Email Address"),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: "Password",
                                          hintText: "Password"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: new Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  offset: Offset(2, 4),
                                                  blurRadius: 5,
                                                  spreadRadius: 2)
                                            ],
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color(0xff36C4EE),
                                                  Color(0xff2496B8)
                                                ])),
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 20,
                            ),

                            Card(
                              elevation: 1,
                              margin: EdgeInsets.all(
                                8.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  logOut();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.grey.shade200,
                                              offset: Offset(2, 4),
                                              blurRadius: 5,
                                              spreadRadius: 2)
                                        ],
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xffF25131),
                                              Color(0xffCF2F0F)
                                            ])),
                                    child: Text(
                                      'Keluar',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

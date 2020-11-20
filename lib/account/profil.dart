import 'package:flutter/material.dart';
import 'package:penjor_driver/login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper.dart';
import 'package:nice_button/nice_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nomortelpController = TextEditingController();
  String idUser = '';

  final Helper helper = new Helper();

  bool isEmailValid = false;

  ambilProfil() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      idUser = sharedPreferences.get("id_user");
      emailController.text = sharedPreferences.get("email");
      namaController.text = sharedPreferences.get("nama");
      nomortelpController.text = sharedPreferences.get("username");
    });
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idUser = preferences.getString("id_user");
    var response =
        await http.get(Secrets.BASE_URL + "set_status_driver?id_user=$idUser");
    if (response.statusCode == 200) {
      print('about http: ${response.body}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

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

  _prosesUpdate() async {
    final response =
        await http.post(Secrets.BASE_URL + "update_profil_driver", body: {
      "nama": namaController.text,
      "email": emailController.text,
      "no_telp": nomortelpController.text,
      "password": passwordController.text,
      "id_user": idUser
    });
    final data = jsonDecode(response.body);

    print("hasil nya : $data");

    String value = data['status'];
    String pesan = data['pesan'];

    if (value == "1") {
      print(pesan);
      helper.alertLog(pesan);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    ambilProfil();
  }

  @override
  Widget build(BuildContext context) {
    var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.yellow,
        title: new Text(
          "Profil",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          //new IconButton(icon: const Icon(Icons.save), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.person),
              title: new TextField(
                controller: namaController,
                decoration: new InputDecoration(
                  hintText: "Nama",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.phone),
              title: new TextField(
                controller: nomortelpController,
                decoration: new InputDecoration(
                  hintText: "Phone",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.email),
              title: new TextField(
                controller: emailController,
                decoration: new InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.vpn_key),
              title: new TextField(
                controller: passwordController,
                decoration: new InputDecoration(
                  hintText: "Password",
                ),
              ),
            ),
            const Divider(
              height: 20.0,
            ),
            NiceButton(
              width: 255,
              elevation: 8.0,
              radius: 52.0,
              text: "Ubah Profil",
              background: firstColor,
              onPressed: () {
                _prosesUpdate();
              },
            ),
            const Divider(
              height: 20.0,
            ),
            NiceButton(
              width: 255,
              elevation: 8.0,
              radius: 52.0,
              text: "Keluar",
              background: Colors.redAccent,
              onPressed: () {
                logOut();
              },
            ),
            // new ListTile(
            //   leading: const Icon(Icons.label),
            //   title: const Text('Nick'),
            //   subtitle: const Text('None'),
            // ),
            // new ListTile(
            //   leading: const Icon(Icons.today),
            //   title: const Text('Birthday'),
            //   subtitle: const Text('February 20, 1980'),
            // ),
            // new ListTile(
            //   leading: const Icon(Icons.group),
            //   title: const Text('Contact group'),
            //   subtitle: const Text('Not specified'),
            // )
          ],
        ),
      ),
    );
  }
}

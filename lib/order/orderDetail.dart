import 'package:flutter/material.dart';
import 'package:penjor_driver/landingpage/v_landingpage.dart';
import 'package:android_intent/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../secrets.dart';

class OrderDetail extends StatefulWidget {
  List list;
  int index;

  OrderDetail({this.list, this.index});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  void _launchTurnByTurnNavigationInGoogleMaps(String tujuan) {
    final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('http://maps.google.com/maps?daddr=$tujuan'),
        package: 'com.google.android.apps.maps');
    intent.launch();
  }

  void _diJemput() async {
    final response = await http.post(Secrets.BASE_URL + "dijemput",
        body: {"id_order": widget.list[widget.index]['id_order']});
    final data = jsonDecode(response.body);
    print("hasil nya : $data");

    String value = data['status'];
    String pesan = data['pesan'];
    if (value == '1') {
      print(pesan);
    }
  }

  void _diAntar() async {
    final response = await http.post(Secrets.BASE_URL + "diantar",
        body: {"id_order": widget.list[widget.index]['id_order']});
    final data = jsonDecode(response.body);
    print("hasil nya : $data");

    String value = data['status'];
    String pesan = data['pesan'];
    if (value == '1') {
      print(pesan);
    }
  }

  void _diTerima() async {
    final response = await http.post(Secrets.BASE_URL + "order_selesai",
        body: {"id_order": widget.list[widget.index]['id_order']});
    final data = jsonDecode(response.body);
    print("hasil nya : $data");

    String value = data['status'];
    String pesan = data['pesan'];
    if (value == '1') {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage()));
                        },
                        child: ClipOval(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                      ),
                      Text(
                        "#",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 25.0,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.list[widget.index]['no_trx']}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Colors.white,
                              ),
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                  ),
                ),
              ),
              Column(
                children: [
                  Divider(),
                  // awal card 1
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Card(
                      elevation: 2,
                      child: ClipPath(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black26,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 5.0),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/gambar_kurir.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${widget.list[widget.index]['nama_customer']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      "tel://${widget.list[widget.index]['telp_pengirim']}");
                                                },
                                                child: Chip(
                                                  label: Text(
                                                    "${widget.list[widget.index]['telp_pengirim']}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  backgroundColor:
                                                      Colors.pink[400],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width /
                                        //         7),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${widget.list[widget.index]['ongkos']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              Text(
                                                "${widget.list[widget.index]['jarak']} km",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Colors.pink),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "JEMPUT DI",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          child: Text(
                                              "${widget.list[widget.index]['jemput']}"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ANTAR KE",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          child: Text(
                                              "${widget.list[widget.index]['antar']}"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "CATATAN",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          child: Text(
                                              "${widget.list[widget.index]['catatan']}"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "DETAIL",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Penerima :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                        "${widget.list[widget.index]['nama_penerima']}"),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Nomor Telp :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            "tel://${widget.list[widget.index]['telp_penerima']}");
                                                      },
                                                      child: Chip(
                                                        label: Text(
                                                          "${widget.list[widget.index]['telp_penerima']}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          _diJemput();
                                          _launchTurnByTurnNavigationInGoogleMaps(
                                              widget.list[widget.index]
                                                  ['jemput']);
                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                              color: Colors.pink),
                                          child: Center(
                                            child: Text(
                                              "Jemput Sekarang",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          _diAntar();
                                          _launchTurnByTurnNavigationInGoogleMaps(
                                              widget.list[widget.index]
                                                  ['antar']);
                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                              color: Colors.orange),
                                          child: Center(
                                            child: Text(
                                              "Antar ke lokasi",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          _diTerima();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LandingPage()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10.0,
                                                ),
                                                color: Colors.green),
                                            child: Center(
                                              child: Text(
                                                "Barang telah diterima",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // akhir dari card 1
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

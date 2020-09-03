import 'package:flutter/material.dart';
import 'package:penjor_driver/order/orderDetail.dart';
import '../constans.dart';

class ListOrder extends StatefulWidget {
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        Navigator.pop(context);
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
                      "My ",
                      style: TextStyle(
                          color: GojekPalette.yellow,
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
                      "Order",
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
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.amber],
                ),
              ),
            ),
            Column(
              children: [
                // awal card 1
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Card(
                    elevation: 2,
                    child: ClipPath(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Column(
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
                                          borderRadius: BorderRadius.circular(
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
                                            "Esther Berry",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Chip(
                                            label: Text(
                                              "Cash",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                100),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Rp.12.000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            "2.2 km",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.0,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PICKUP",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        child: Text(
                                            "Jalan Kolonel Abunjani, No 03 Kelurahan Selamat Kecamatan Telanai Pura"),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DROP OFF",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        child: Text(
                                            "Jalan Kolonel Abunjani, No 03 Kelurahan Selamat Kecamatan Telanai Pura"),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetail()));
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    color: Colors.pink),
                                child: Center(
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // akhir dari card 1

                // awal card 2
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Card(
                    elevation: 2,
                    child: ClipPath(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Column(
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
                                          borderRadius: BorderRadius.circular(
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
                                            "Esther Berry",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Chip(
                                            label: Text(
                                              "Cash",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.pink[400],
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                100),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Rp.12.000",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            "2.2 km",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.0,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PICKUP",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        child: Text(
                                            "Jalan Kolonel Abunjani, No 03 Kelurahan Selamat Kecamatan Telanai Pura"),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DROP OFF",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        child: Text(
                                            "Jalan Kolonel Abunjani, No 03 Kelurahan Selamat Kecamatan Telanai Pura"),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetail()));
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    color: Colors.pink),
                                child: Center(
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // akhir dari card 2
              ],
            ),
          ],
        ),
      ),
    );
  }
}

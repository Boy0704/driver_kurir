import 'package:flutter/material.dart';
import 'package:penjor_driver/account/profil.dart';
import 'package:penjor_driver/inbox/v_inbox.dart';
import '../order/listOrder.dart';
import '../constans.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [
    new ListOrder(),
    new ListOrder(),
    new Inbox(),
    new Profil()
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _container[_bottomNavCurrentIndex],
        bottomNavigationBar: _buildBottomNavigation());
  }

  Widget _buildBottomNavigation() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: GojekPalette.menuRide,
          ),
          icon: new Icon(
            Icons.home,
            color: Colors.grey,
          ),
          title: new Text(
            'Beranda',
            style: TextStyle(color: GojekPalette.menuRide),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.assignment,
            color: GojekPalette.menuRide,
          ),
          icon: new Icon(
            Icons.assignment,
            color: Colors.grey,
          ),
          title: new Text(
            'Pesanan',
            style: TextStyle(color: GojekPalette.menuRide),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.mail,
            color: GojekPalette.menuRide,
          ),
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          title: new Text(
            'Inbox',
            style: TextStyle(color: GojekPalette.menuRide),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.person,
            color: GojekPalette.menuRide,
          ),
          icon: new Icon(
            Icons.person,
            color: Colors.grey,
          ),
          title: new Text(
            'Akun',
            style: TextStyle(color: GojekPalette.menuRide),
          ),
        ),
      ],
    );
  }
}

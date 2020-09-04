import 'package:flutter/material.dart';
import 'package:penjor_driver/account/profil.dart';
import 'package:penjor_driver/beranda/v_home.dart';
import '../order/listOrder.dart';
import '../constans.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../helper.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Helper helper = new Helper();
  FirebaseMessaging fm = FirebaseMessaging();

  _LandingPageState() {
    fm.configure(
      onLaunch: (Map<String, dynamic> msg) async {
        print("ketika sedang berjalan");
        print(msg);
        if (msg['data']['screen'] == 'list_trx') {
          helper.alertLog(msg['notification']['body']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListOrder()),
          );
        }
      },
      onResume: (Map<String, dynamic> msg) async {
        //(App in background)
        // From Notification bar when user click notification we get this event.
        // on this event navigate to a particular page.
        if (msg['data']['screen'] == 'list_trx') {
          helper.alertLog(msg['notification']['body']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListOrder()),
          );
        }
        print("ini On Resume = $msg");
        // Assuming you will create classes to handle JSON data. :)
        //   Notification ns =
        //         Notification(title: msg['title'], body: msg['body']);

        //     Data data = Data(
        //       clickAction: msg['click_action'],
        //       sound: msg['sound'],
        //       status: msg['status'],
        //       screen: msg['screen'],
        //       extradata: msg['extradata'],
        //     );
        //     switch (data.screen) {
        // case "OPEN_PAGE1":
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => Page1()
        //         ),
        //       );
        //   break;
        // default:
        //   break;
      },
      onMessage: (Map<String, dynamic> msg) async {
        // (App in foreground)
        // on this event add new message in notification collection and hightlight the count on bell icon.
        // Add notificaion add in local storage and show in a list.
        // updataNotification(msg);
        if (msg['data']['screen'] == 'list_trx') {
          helper.alertLog(msg['notification']['body']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListOrder()),
          );
        }
        print("ini On Message");
        print(msg['data']['screen']);
      },
    );
  }

  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [
    new HomePage(),
    new ListOrder(),
    // new Inbox(),
    new Account()
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
            'Order Masuk',
            style: TextStyle(color: GojekPalette.menuRide),
          ),
        ),
        // BottomNavigationBarItem(
        //   activeIcon: new Icon(
        //     Icons.mail,
        //     color: GojekPalette.menuRide,
        //   ),
        //   icon: new Icon(
        //     Icons.mail,
        //     color: Colors.grey,
        //   ),
        //   title: new Text(
        //     'Inbox',
        //     style: TextStyle(color: GojekPalette.menuRide),
        //   ),
        // ),
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

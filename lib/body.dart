import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'wallet.dart';
import 'home_screen.dart';
import 'orders.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(7, 7, 7, 1),
      body: PersistentTabView(
        context,
        screens: _screens(),
        decoration: NavBarDecoration(
            border:
                Border(top: BorderSide(color: Color.fromRGBO(15, 15, 15, 1)))),
        items: _items(),
        resizeToAvoidBottomInset: true,
        navBarHeight: 75,
        navBarStyle: NavBarStyle.style12,
        backgroundColor: Color.fromRGBO(7, 7, 7, 1),
      ),
    );
  }

  List<Widget> _screens() {
    return [HomeScreen(), Orders(), Wallet()];
  }

  List<PersistentBottomNavBarItem> _items() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: 'Головна',
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Color.fromRGBO(37, 37, 37, 1)),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.cart),
          title: 'Замовлення',
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Color.fromRGBO(37, 37, 37, 1)),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_balance_wallet),
          title: 'Гаманець',
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Color.fromRGBO(37, 37, 37, 1)),
    ];
  }
}

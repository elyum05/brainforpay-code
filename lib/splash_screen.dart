import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authpage.dart';
import 'body.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navHome();
  }

  int? isViewed;

  void navHome() async {
    await Future.delayed(Duration(milliseconds: 1500));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isViewed = prefs.getInt('login');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          // ignore: unrelated_type_equality_checks
          builder: (context) => AuthPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 10, 15, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BRAINFORPAY',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Blanka',
                    fontSize: 18,
                    letterSpacing: 12.5)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                width: 145,
                height: 3,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(31, 52, 240, 1),
                    borderRadius: BorderRadius.circular(150)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                width: 115,
                height: 3,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 215, 31, 1),
                    borderRadius: BorderRadius.circular(150)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

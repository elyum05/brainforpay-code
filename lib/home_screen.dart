import 'package:brainforpay_app/create_order.dart';
import 'package:brainforpay_app/own_profile.dart';
import 'package:brainforpay_app/wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 10, 15, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Padding(
            padding: EdgeInsets.all(28),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Доброго дня!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25)),
                    Text('Вас вітає BrainForPay.',
                        style: TextStyle(
                            height: 1.85,
                            color: Colors.white.withOpacity(0.58),
                            fontSize: 16,
                            fontWeight: FontWeight.w400))
                  ],
                ),
                Spacer(),
                InkWell(
                    borderRadius: BorderRadius.circular(150),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 52,
                      height: 52,
                      child: CircleAvatar(
                        radius: 21,
                        backgroundImage: NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL!,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(10, 10, 10, 0.85),
                          border:
                              Border.all(color: Color.fromRGBO(25, 25, 25, 1)),
                          borderRadius: BorderRadius.circular(150)),
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
            child: Text('Будь ласка, створіть\nзамовлення.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: EdgeInsets.all(28),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 75),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateOrder()));
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.all(25),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.cart_badge_plus, color: Colors.white),
                      SizedBox(width: 7),
                      Text('Створити замовлення',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 15, 15, 1).withOpacity(0.75),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.32)),
                  ),
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );
  }
}

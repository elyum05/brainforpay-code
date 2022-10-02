import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'body.dart';
import 'firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: SweepGradient(colors: [
        Color.fromRGBO(10, 10, 15, 1),
        Color.fromRGBO(7, 7, 15, 1)
      ], transform: GradientRotation(1.57))),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Ласкаво просимо до\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: 'e-Ukraine',
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'BrainForPay',
                            style: TextStyle(
                                height: 1.8, fontWeight: FontWeight.w700))
                      ]),
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Image.asset('assets/yman.png', height: 216),
              SizedBox(height: 45),
              Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(150)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 58, vertical: 35),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {
                    await FirebaseServices().signInWithGoogle();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Body()),
                      (Route<dynamic> route) => false,
                    );
                    var db = FirebaseFirestore.instance.collection(
                        '${FirebaseAuth.instance.currentUser!.email}');
                    db.doc(FirebaseAuth.instance.currentUser!.uid).set({
                      'balance': FieldValue.increment(0),
                      'orders': FieldValue.increment(0)
                    }, SetOptions(merge: true));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png', height: 25),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Увійти через Google',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'e-Ukraine',
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.87),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

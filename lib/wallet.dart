import 'package:brainforpay_app/own_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Wallet extends StatefulWidget {
  Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final Stream<QuerySnapshot> _user = FirebaseFirestore.instance
      .collection('${FirebaseAuth.instance.currentUser!.email}')
      .snapshots();

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(10, 10, 15, 1),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 85),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        child: Row(
                          children: [
                            Text('Мій баланс',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700)),
                            Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(150),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child: CircleAvatar(
                                radius: 21,
                                backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _user,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Center(
                                  child: Text("Заждіть, будь ласка...",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'e-Ukraine',
                                          fontWeight: FontWeight.w700))),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Center(
                                  child: Text("Заждіть, будь ласка...",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'e-Ukraine',
                                          fontWeight: FontWeight.w700))),
                            );
                          }

                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return Padding(
                                    padding: EdgeInsets.all(28),
                                    child: Container(
                                      padding: EdgeInsets.all(21),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundImage: NetworkImage(
                                                  FirebaseAuth.instance
                                                      .currentUser!.photoURL!,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                  '${FirebaseAuth.instance.currentUser!.email}',
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.52),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/uah.png',
                                                  height: 52),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Text(data['balance'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.w700))
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 15),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              onTap: () {
                                                showAnimatedDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    25),
                                                            side: BorderSide(
                                                                color:
                                                                    Color.fromRGBO(
                                                                        48,
                                                                        48,
                                                                        48,
                                                                        0.35))),
                                                        titleTextStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 21,
                                                            fontWeight: FontWeight
                                                                .w700),
                                                        backgroundColor:
                                                            Color.fromRGBO(
                                                                12, 12, 12, 1),
                                                        contentTextStyle: TextStyle(
                                                            color: Color.fromRGBO(
                                                                181, 181, 181, 1),
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                        title: Center(child: Text("Поповнення")),
                                                        content: Container(
                                                          height: 165,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              3),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.75),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                  child:
                                                                      TextField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly
                                                                    ],
                                                                    controller:
                                                                        myController,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            'Сума поповнення:',
                                                                        hintStyle: TextStyle(
                                                                            color: Colors.white.withOpacity(
                                                                                0.35)),
                                                                        enabledBorder:
                                                                            InputBorder
                                                                                .none,
                                                                        focusedBorder:
                                                                            InputBorder.none),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(7),
                                                                child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  onTap: () {
                                                                    int sum = int.parse(
                                                                        myController
                                                                            .text);
                                                                    var db = FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            '${FirebaseAuth.instance.currentUser!.email}');
                                                                    db
                                                                        .doc(FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid)
                                                                        .set({
                                                                      'balance':
                                                                          FieldValue.increment(
                                                                              sum)
                                                                    }, SetOptions(merge: true));
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              25),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius: BorderRadius.circular(
                                                                              12)),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: Text(
                                                                          'Поповнити',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w700))),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                  animationType:
                                                      DialogTransitionType
                                                          .slideFromTopFade,
                                                  curve: Curves.fastOutSlowIn,
                                                  duration:
                                                      Duration(seconds: 1),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 21),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add_card),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text('Поповнити',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      height: 245,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.52),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  );
                                })
                                .toList()
                                .cast(),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(28),
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                  'Якщо ви маєте якісь проблеми з поповненням або виведенням коштів, будь ласка, зверніться до служби підтримки!',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.75),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  launch('https://t.me/vadimchanskiy');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 21),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.support_agent),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text('Служба підтримки',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.yellowAccent,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(25),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.58),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.yellowAccent)),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/back.png'),
                          fit: BoxFit.cover)))
            ],
          ),
        ));
  }
}

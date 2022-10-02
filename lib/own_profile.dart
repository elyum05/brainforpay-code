import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_services.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Stream<QuerySnapshot> _user = FirebaseFirestore.instance
      .collection('${FirebaseAuth.instance.currentUser!.email}')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Мій профіль',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400)),
      ),
      backgroundColor: Color.fromRGBO(10, 10, 15, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser!.photoURL!,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Text('${FirebaseAuth.instance.currentUser!.email}',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
            ),
            Container(
              width: 215,
              height: 49,
              child: Text('${FirebaseAuth.instance.currentUser!.displayName}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(5, 5, 9, 1),
                  borderRadius: BorderRadius.circular(15)),
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

                if (snapshot.connectionState == ConnectionState.waiting) {
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Container(
                                width: 215,
                                height: 3,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(150)),
                              ),
                            ),
                            Text('Кількість зроблених замовлень:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(5, 5, 9, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.center,
                                width: 49,
                                height: 49,
                                child: Text(data['orders'].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Container(
                                width: 215,
                                height: 3,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(150)),
                              ),
                            ),
                          ],
                        );
                      })
                      .toList()
                      .cast(),
                );
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () async {
                await FirebaseServices().googleSignOut();
                exit(0);
              },
              child: Container(
                width: 185,
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(
                      width: 7,
                    ),
                    Text('Вийти',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700))
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(232, 43, 43, 1).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

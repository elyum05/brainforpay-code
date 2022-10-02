import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final Stream<QuerySnapshot> _user = FirebaseFirestore.instance
      .collection('${FirebaseAuth.instance.currentUser!.email}_orders')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 10, 15, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(right: 28, left: 28, top: 28),
            child: Text('Історія замовлень',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w500)),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _user,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 7),
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset('assets/case.png', height: 25),
                              SizedBox(
                                width: 10,
                              ),
                              Text(data['typeOfWork'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              Spacer(),
                              Image.asset('assets/grivnya.png', height: 16),
                              Text(data['price'].toString(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(40, 229, 105, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 21),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(5, 5, 11, 1),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    })
                    .toList()
                    .cast(),
              );
            },
          ),
        ],
      ),
    );
  }
}

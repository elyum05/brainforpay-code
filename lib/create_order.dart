import 'dart:math';
import 'package:brainforpay_app/order_success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:brainforpay_app/firebase_services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class CreateOrder extends StatefulWidget {
  CreateOrder({Key? key}) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final Stream<QuerySnapshot> _user = FirebaseFirestore.instance
      .collection('${FirebaseAuth.instance.currentUser!.email}')
      .snapshots();

  final desc = TextEditingController();
  final phone_number = TextEditingController();

  Random random = Random();

  final List<String> items = [
    'Курсова робота',
    'Домашня робота',
    'Контрольна робота',
    'Самостійна робота',
  ];
  String? selectedValue;

  int? price;

  void setPrice() {
    if (selectedValue == 'Курсова робота') {
      setState(() {
        price = 750;
      });
    } else if (selectedValue == 'Домашня робота') {
      setState(() {
        price = 150;
      });
    } else if (selectedValue == 'Контрольна робота') {
      setState(() {
        price = 450;
      });
    } else if (selectedValue == 'Самостійна робота') {
      setState(() {
        price = 250;
      });
    }
  }

  bool _validate = false;

  @override
  void dispose() {
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Створення замовлення',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
      ),
      backgroundColor: Color.fromRGBO(7, 7, 10, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    dropdownPadding: EdgeInsets.all(7),
                    dropdownDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 22, 21, 31),
                        borderRadius: BorderRadius.circular(15)),
                    hint: Text(
                      'Оберіть тип роботи',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.65),
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonHeight: 40,
                    buttonWidth: 140,
                    itemHeight: 40,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(1, 1, 10, 1),
                    border: Border.all(color: Colors.white.withOpacity(0.10)),
                    borderRadius: BorderRadius.circular(15))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: Container(
              height: 125,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(1, 1, 10, 1),
                  border: Border.all(color: Colors.white.withOpacity(0.10)),
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: desc,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Опис завдання:',
                    errorText:
                        _validate ? 'Поле повинно бути заповнене!' : null,
                    hintStyle:
                        TextStyle(color: Colors.white.withOpacity(0.65))),
              ),
            ),
          ),
          Spacer(),
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
                        padding: EdgeInsets.only(bottom: 35),
                        child: Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              setState(() {
                                desc.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                              });
                              int balance = data['balance'];
                              setPrice();
                              showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  48, 48, 48, 0.35))),
                                      titleTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700),
                                      backgroundColor:
                                          Color.fromRGBO(12, 12, 12, 1),
                                      contentTextStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(181, 181, 181, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      title: Center(
                                          child: Text("Створити замовлення")),
                                      content: Container(
                                        height: 265,
                                        child: Column(
                                          children: [
                                            Text(
                                                "Ми з вами зв'яжемося напротязі 2 годин для уточнення деталей замовлення.",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.45),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      1, 1, 10, 1),
                                                  border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.10)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                controller: phone_number,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    hintText:
                                                        'Ваш номер телефону:',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(
                                                                0.65))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    if (balance < price!) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Увага!'),
                                                              content: Text(
                                                                  'На вашому балансі недостатньо коштів, будь ласка, поповніть свій рахунок.'),
                                                            );
                                                          });
                                                    } else {
                                                      var db = FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              '${FirebaseAuth.instance.currentUser!.email}');
                                                      var db1 = FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              '${FirebaseAuth.instance.currentUser!.email}_orders');
                                                      db1
                                                          .doc(
                                                              '${selectedValue}#${random.nextInt(99999)}')
                                                          .set(
                                                        {
                                                          'typeOfWork':
                                                              selectedValue,
                                                          'description':
                                                              desc.text,
                                                          'price': price,
                                                          'phone_number':
                                                              phone_number.text,
                                                        },
                                                      );
                                                      db
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .set(
                                                              {
                                                            'balance':
                                                                FieldValue
                                                                    .increment(
                                                                        -price!)
                                                          },
                                                              SetOptions(
                                                                  merge: true));
                                                      db
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .set(
                                                              {
                                                            'orders': FieldValue
                                                                .increment(1)
                                                          },
                                                              SetOptions(
                                                                  merge: true));

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OrderSuccess()));
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 200,
                                                    padding: EdgeInsets.all(21),
                                                    child: Text('Оплатити',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                  ),
                                                ),
                                                Spacer(),
                                                Image.asset(
                                                    'assets/grivnya.png',
                                                    height: 18),
                                                Text(price.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 21,
                                                        fontWeight:
                                                            FontWeight.w700))
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                animationType:
                                    DialogTransitionType.slideFromTopFade,
                                curve: Curves.fastOutSlowIn,
                                duration: Duration(seconds: 1),
                              );
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.black),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text('Створити замовлення',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(vertical: 25),
                              width: 265,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
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

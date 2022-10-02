import 'package:flutter/material.dart';

class OrderSuccess extends StatefulWidget {
  OrderSuccess({Key? key}) : super(key: key);

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(7, 7, 12, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 75),
            child: Center(
              child: Text('Замовлення створено!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          Image.asset('assets/done.png'),
          SizedBox(
            height: 45,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: 115,
              height: 3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(150)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Text(
                "Для уточнення деталей ми зв'яжемося з вами напротязі 2-3 годин.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: 115,
              height: 3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(150)),
            ),
          ),
          SizedBox(height: 15),
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 21),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Назад',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700))
                  ],
                ),
                width: 215,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15))),
          )
        ],
      ),
    );
  }
}

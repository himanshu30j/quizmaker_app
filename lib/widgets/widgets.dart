import 'package:flutter/material.dart';

Widget appbar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Quiz",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      Text(
        "Maker",
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget blueBotton({BuildContext context, String label, bottonWidth}) {
  return Container(
    width:
        bottonWidth != null ? bottonWidth : MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 20.0),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(30.0)),
    child: Center(
      child: Text(label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
    ),
  );
}

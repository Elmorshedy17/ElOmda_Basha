import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 200,
      height: 200,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/icon.png',
              fit: BoxFit.fill,
              width: 200,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('title'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('description'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('price'),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[50],
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}

List<Widget> cards = [
  CustomCard(),
  CustomCard(),
  CustomCard(),
  CustomCard(),
  CustomCard(),
  CustomCard(),
  CustomCard(),
];

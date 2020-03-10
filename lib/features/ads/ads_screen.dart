import 'package:flutter/material.dart';

class AdsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.teal.shade900,
        ),
        Positioned(
          bottom: 5.0,
          right: 0.0,
          child: ButtonTheme(
            minWidth: 150,
            child: RaisedButton(
                // color: Color(0x00413f),
                color: Colors.teal.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    bottomLeft: Radius.circular(18.0),
                  ),
                  side: BorderSide(color: Colors.white70),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'en',
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
          ),
        )
      ],
    );
  }
}

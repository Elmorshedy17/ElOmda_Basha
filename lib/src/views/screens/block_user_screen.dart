import 'package:flutter/material.dart';
import 'package:medicine/theme_setting.dart';


class BlockedUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(" Sorry but you have been blocked please contact with administrator ",style: TextStyle(
          color: accentColor,fontSize: MainFont,fontWeight: semiFont
        ),),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/shared/helper/main_background.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text('Back'),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 60,
                  child: Center(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(35),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Transform.rotate(
                        angle: 145,
                        child: Icon(
                          Icons.notifications,
                          color: Colors.teal.shade900,
                        ),
                      ),
                      title: Text(
                        'data data data data data data',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      trailing: Text(
                        '01:00PM',
                        style: TextStyle(color: Colors.black45, fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: Transform.rotate(
                        angle: 145,
                        child: Icon(
                          Icons.notifications,
                          color: Colors.teal.shade900,
                        ),
                      ),
                      title: Text(
                        'data data data data data data',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      trailing: Text(
                        '01:00PM',
                        style: TextStyle(color: Colors.black45, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

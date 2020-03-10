import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/main_drawer.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Sittings',
            style: TextStyle(color: Colors.white),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).pushNamed('/notificationsScreen');
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
//                      height: 600,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              // Navigator.of(context)
                              //     .pushNamed('/addressBookScreen');
                            },
                            title: Text(
                              'Change your Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('AAAA_aaa@gmail.com'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 5,
                            color: Colors.black12,
                          ),
                          ListTile(
                            onTap: () {
                              // Navigator.of(context)
                              //     .pushNamed('/termsConditionsScreen');
                            },
                            title: Text(
                              'Change your password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('***********'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 5,
                            color: Colors.black12,
                          ),
                          ListTile(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/privacyScreen');
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                            title: Text(
                              'Country',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Kuwait',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                          Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 5,
                            color: Colors.black12,
                          ),
                          ListTile(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/privacyScreen');
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                            title: Text(
                              'Terms & Conditions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 5,
                            color: Colors.black12,
                          ),
                          ListTile(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/privacyScreen');
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                            title: Text(
                              'Privacy policy',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 5,
                            color: Colors.black12,
                          ),
                          ListTile(
                            onTap: () {
                              // Navigator.of(context).pushNamed('/privacyScreen');
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                            title: Text(
                              'Notification',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}

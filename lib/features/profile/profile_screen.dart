import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Profile',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  ButtonTheme(
                    height: 25,
                    child: RaisedButton(
                        color: Colors.teal.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.teal.shade900),
                        ),
                        child: Text(
                          'EDIT PROFILE',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'en',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/editProfileScreen');
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'SALAH SALAH',
                            style: TextStyle(
                              color: Colors.teal.shade900,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('SalahSalah@email.com'),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
//                      height: 600,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('Name'),
                            subtitle: Text('Salah'),
                          ),
                          Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 5,
                            color: Colors.black12,
                          ),
                          ListTile(
                            title: Text('Address'),
                            subtitle: Text('14 Street'),
                          ),
                          Divider(
                            endIndent: 15,
                            indent: 15,
                            height: 5,
                            color: Colors.black12,
                          ),
                          ListTile(
                            title: Text('Phone Number'),
                            subtitle: Text(
                              '01112222330',
                              style: TextStyle(
                                color: Colors.red,
                              ),
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
                              Navigator.of(context)
                                  .pushNamed('/addressBookScreen');
                            },
                            title: Text('Address book'),
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
                              Navigator.of(context)
                                  .pushNamed('/termsConditionsScreen');
                            },
                            leading: Icon(
                              Icons.error,
                              color: Colors.greenAccent,
                            ),
                            title: Text('Terms of use'),
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
                              Navigator.of(context).pushNamed('/privacyScreen');
                            },
                            leading: Icon(
                              Icons.lock,
                              color: Colors.yellow,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            title: Text('Privacy policy'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 100,
                          child: RaisedButton(
                              color: Colors.teal.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(9.0),
                                            bottomLeft: Radius.circular(9.0),
                                          )
                                        : BorderRadius.only(
                                            topRight: Radius.circular(9.0),
                                            bottomRight: Radius.circular(9.0),
                                          ),
                                side: BorderSide(
                                  color: Colors.teal.shade900,
                                ),
                              ),
                              child: Text(
                                'Sign out',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'en',
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {}),
                        ),
                      ],
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

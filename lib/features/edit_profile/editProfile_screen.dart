import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/main_background.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
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
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text('Back'),
              ],
            ),
          ),
          title: Text('Edit Profile'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: ButtonTheme(
                  child: RaisedButton(
                      color: Colors.teal.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.teal.shade900),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'en',
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/editProfileScreen');
                      }),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: Card(
                margin: EdgeInsets.only(top: 12),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      hintText: "First Name",
                      fillColor: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Card(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      hintText: "Middle Name",
                      fillColor: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Card(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      hintText: "Last Name",
                      fillColor: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Card(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      hintText: "Phone Number",
                      fillColor: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Card(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      hintText: "Email",
                      fillColor: Colors.white),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ListTile(
          title: ButtonTheme(
            height: 50,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              color: Colors.teal.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.white24),
              ),
              child: Text(
                'Change Your Password',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/changePasswordScreen');
              },
            ),
          ),
        ),
      ),
    );
  }
}

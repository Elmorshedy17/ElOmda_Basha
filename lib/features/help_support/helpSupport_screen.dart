import 'package:flutter/material.dart';
import 'package:momentoo/features/help_support/helpSupportValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class HelpSupportScreen extends StatelessWidget {
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
            Container(
              child: Center(
                child: Text(
                  'Help & Support',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  hintText: "Your Name",
                                  fillColor: Colors.white),
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                              height: 5,
                              color: Colors.black12,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  hintText: "Your Email",
                                  fillColor: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      elevation: 5,
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(),
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
                            hintText: "Phone number",
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(4),
                    // width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          // spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    child: ExpansionTile(
                      title: Text('Type of complaint'),
                      backgroundColor: Colors.white,
                      children: <Widget>[
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
//                      height: 600,
                      child: TextField(
                        maxLines: 10,
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
                            hintText: "Your message",
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StreamBuilder(
                            initialData: true,
                            stream: locator<HelpSupportValidationManager>()
                                .checkBoxValue$,
                            builder: (context, snapshot) {
                              return Checkbox(
                                activeColor: Colors.teal.shade800,
                                hoverColor: Colors.teal.shade800,
                                checkColor: Colors.white,
                                focusColor: Colors.teal.shade800,
                                value: snapshot.data,
                                onChanged: (value) {
                                  locator<HelpSupportValidationManager>()
                                      .setCheckBoxValue(value);
                                },
                              );
                            }),
                        Text(
                          'I agree to the',
                          style: TextStyle(
                            color: Colors.black26,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              ' Terms and conditions',
                              style: TextStyle(
                                color: Colors.teal.shade300,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 4),
                              width: 135,
                              height: 0.5,
                              color: Colors.teal.shade300,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2),
                    child: ButtonTheme(
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        color: Colors.teal.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white24),
                        ),
                        child: Text(
                          'SEND MESSAGE',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

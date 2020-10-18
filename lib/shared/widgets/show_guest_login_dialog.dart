import 'package:flutter/material.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';

showGuestLoginDialog(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(AppLocalizations.of(context).translate("signToContinue_str"),style: TextStyle(color: Colors.teal.shade900),),
          actions: <Widget>[
            new RaisedButton(
              elevation: 3,
              color: Colors.teal.shade900,
              child: new Text(
                AppLocalizations.of(context).translate("continue_str"),
                style: TextStyle(color: Colors.white),),
              onPressed: () {
                //Navigator.pushNamed(context, "/screen1");
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 15.0,),
            new RaisedButton(
              elevation: 3,
              color: Colors.white,
              child: new Text(AppLocalizations.of(context).translate("signIn_str"),style: TextStyle(color: Colors.teal.shade900),),
              onPressed: () {
                //Navigator.pushNamed(context, "/screen1");
                Navigator.of(context)
                    .pushNamed(
                    '/signInScreen');              },
            ),
          ],
        );
      });}



  //     void showDialog(){
  // return showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: Text(AppLocalizations.of(context).translate("signToContinue_str")),
  //       content: Row(
  //         mainAxisAlignment:
  //         MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           FlatButton(
  //             onPressed: () {
  //               Navigator.of(context)
  //                   .pushNamed(
  //                   '/signInScreen');
  //             },
  //             child: Text(AppLocalizations.of(context).translate("signIn_str")),
  //           ),
  //           FlatButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(AppLocalizations.of(context).translate("continue_str")),
  //           ),
  //         ],
  //       ),
  //     );
  //   },
  // );
  //     }
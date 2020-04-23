import 'package:flutter/material.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';

class Failed extends StatefulWidget {
  Failed(String message);

  @override
  _FailedState createState() => _FailedState();
}

class _FailedState extends State<Failed> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.teal.shade900,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 3,
                  decoration: new BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Image.asset("assets/images/LOGO1.png"),
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate("failed_str")} !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900),
                      ),
                      ButtonTheme(
                        minWidth: 180.0,
                        height: 45.0,
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('Try_again_str'),
                            style: TextStyle(
                                color: Colors.teal.shade900, fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.popUntil(context,
                                ModalRoute.withName('/checkOutScreen'));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

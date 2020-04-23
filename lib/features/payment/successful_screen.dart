import 'package:flutter/material.dart';
import 'package:momentoo/shared/domain/cartRequest.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class Successful extends StatefulWidget {
  final message;
  Successful(this.message);

  @override
  _SuccessfulState createState() => _SuccessfulState();
}

class _SuccessfulState extends State<Successful> {
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
                        AppLocalizations.of(context)
                            .translate("Successful_str"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900),
                      ),
//                      ButtonTheme(
//                        minWidth: 180.0,
//                        height: 45.0,
//                        child: RaisedButton(
//                          color: Colors.white,
//                          shape: RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(40.0),
//                          ),
//                          child: Text(
//                            AppLocalizations.of(context)
//                                .translate('Rate_us_str'),
//                            style: TextStyle(
//                                color: Colors.teal.shade900, fontSize: 20.0),
//                          ),
//                          onPressed: () {},
//                        ),
//                      ),
                      ButtonTheme(
                        minWidth: 180.0,
                        height: 45.0,
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context).translate('Done_str'),
                            style: TextStyle(
                                color: Colors.teal.shade900, fontSize: 20.0),
                          ),
                          onPressed: () {
                            locator<PrefsService>().cartObj = LocalCart();
//                            Navigator.popUntil(
//                                context, ModalRoute.withName('/homeScreen'));
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/homeScreen", (r) => false);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
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

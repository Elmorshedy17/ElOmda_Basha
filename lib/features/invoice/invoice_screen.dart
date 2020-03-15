import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('Invoice_str'),
            style: TextStyle(
                color: Colors.white,
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar'),
          ),
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
        body: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width - 50,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 115.0,
                    color: Colors.teal.shade900,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                              child: Container(
                                  margin: EdgeInsets.all(25.0),
                                  child:
                                      Image.asset("assets/images/logo.png"))),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('Order_str'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('Order_No_str'),
                                    style: TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar'),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "15687",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar'),
                                  ),
                                ],
                              ),
                              Text(
                                "Oct 11,2019 2:00 Pm",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Khaled Ammar",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.teal.shade900,
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : 'ar'),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "+965 444 555 234",
                            style: TextStyle(
                                color: Colors.teal.shade900,
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : 'ar'),
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Prawn & chikenRoll",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "9.50 KW",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Prawn & chikenRoll",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "9.50 KW",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Prawn & chikenRoll",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "9.50 KW",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            height: 1.0,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.withOpacity(.3),
                          ),
                          Container(
                            height: 150.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('total_Str'),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey.withOpacity(.7),
                                      fontFamily:
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar'),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "9.50 KW",
                                  style: TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal.shade900,
                                      fontFamily:
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

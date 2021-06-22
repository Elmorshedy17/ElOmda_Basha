import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/views/screens/points_transfere.dart';
import 'package:medicine/theme_setting.dart';

class SuperVisorSingleMarkter extends StatefulWidget {
  var data;
  SuperVisorSingleMarkter(this.data);
  @override
  _SuperVisorSingleMarkterState createState() => _SuperVisorSingleMarkterState();
}

class _SuperVisorSingleMarkterState extends State<SuperVisorSingleMarkter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.data.name),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
//            Container(
//              height: MediaQuery.of(context).size.height,
//              width: MediaQuery.of(context).size.width,
//              //     color: Colors.yellow,
//            ),
//          Container(
//            child: ClipRRect(
//              borderRadius:
//              BorderRadius.only(bottomRight: Radius.circular(50.0)),
//              child: Container(
//                height: 50.0,
//                color: Theme.of(context).primaryColor,
//              ),
//            ),
//          ),
            Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              top: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: <Widget>[
                      _firstCard(widget.data),
                      Container(
                        height: 15.0,
                      ),
                      _firstStatistics(),
                      Container(
                        height: 15.0,
                      ),
                      _secondStatistics(),

                      Container(
                        height: 15.0,
                      ),
                      _transfrerOrder(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstStatistics() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Wrap(
                  children: <Widget>[
                    Center(
                        child: Text(
                          AppLocalizations.of(context).translate("Tottal Amount") ,
                          style:
                          TextStyle(fontWeight: bolFont, fontSize: MediumFont),
                        )),
                    Container(
                      height: 15.0,
                    ),
                    Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
//                          "1000",
                              "${(widget.data.totalCommission * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: semiFont,
                                  fontSize: PrimaryFont,
                                  color: Colors.redAccent),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              locator<PrefsService>().currencyCode,
                              style: TextStyle(
                                  fontWeight: semiFont,
                                  fontSize: SecondaryFont,
                                  color: lightText),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
             Container(
                height: 45.0,
                child: VerticalDivider(
                  color: Colors.blue,
                ),
              ),
             Expanded(
                child: Wrap(
                  children: <Widget>[
                    Center(
                        child: Text(
                          AppLocalizations.of(context).translate("Tottal Points"),
                          style:
                          TextStyle(fontWeight: bolFont, fontSize: MediumFont),
                        )),
                    Container(
                      height: 15.0,
                    ),
                    Center(
                        child: Text(
                            widget.data.totalPoint.toString(),
                            //"2,4243",
                            style: TextStyle(
                                fontWeight: semiFont,
                                fontSize: PrimaryFont,
                                color: Colors.redAccent))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _secondStatistics() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            children: <Widget>[

              Container(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child:
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context).translate("Tottal Worthy Amounts") ,
                        style: TextStyle(
                            fontWeight: bolFont, fontSize: MediumFont),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                         "${(double.parse(widget.data.needCommission.toString()) * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}",
                          style: TextStyle(
                              fontWeight: semiFont,
                              fontSize: PrimaryFont,
                              color: Colors.redAccent),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          locator<PrefsService>().currencyCode,
                          // AppLocalizations.of(context).translate("real_suadi_shortcut"),
                          style: TextStyle(
                              fontSize: PrimaryFont,
                              fontWeight: semiFont,
                              color: lightText),
                        ),
                      ],
                    ),
                  ],
                ),

              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child:
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context).translate("Tottal Worthy Points"),
                        style: TextStyle(
                            fontWeight: bolFont, fontSize: MediumFont),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.data.needPoint.toString(),
                          style: TextStyle(
                              fontWeight: semiFont,
                              fontSize: PrimaryFont,
                              color: Colors.redAccent),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          AppLocalizations.of(context).translate("Point") ,
                          style: TextStyle(
                              fontSize: PrimaryFont,
                              fontWeight: semiFont,
                              color: lightText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child:
                Row(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate("Tottal Worthy Gifts"),
                      style: TextStyle(
                          fontWeight: bolFont, fontSize: MediumFont),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            widget.data.needGifts.toString(),
                            style: TextStyle(
                                fontWeight: semiFont,
                                fontSize: PrimaryFont,
                                color: Colors.redAccent),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            AppLocalizations.of(context).translate("Gift"),
                            style: TextStyle(
                                fontSize: PrimaryFont,
                                fontWeight: semiFont,
                                color: lightText),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _transfrerOrder(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          dense: true,
          onTap: (){
            ApiService.PackagesShow()
                .then((data) => data.key == "1"
                ?   Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => CarouselWithIndicator(data)))
                : showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(data.msg),
                );
              },
            )); },
          leading:  Image.asset(
            "assets/images/payment.png",
            height: 25.0,
            width: 25.0,
          ),
          title: Align(
            child: Text(
              AppLocalizations.of(context).translate("Exchange Points") ,
              style:
              TextStyle(fontWeight: bolFont, fontSize: MediumFont),
            ),
            alignment: Alignment(-1.2, 0),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  Widget _firstCard(snapshot) {
    return Wrap(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Wrap(
              children: <Widget>[
                Container(
                  height: 15.0,
                ),
                Center(
                  child: ClipRRect(
                      borderRadius: new BorderRadius.circular(50.0),
                      child: Image.network(
                        snapshot.avatar,
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.fill,
                      )
                  ),
                ),
                Container(
                  height: 25.0,
                ),
                _emailUser(snapshot),
                Divider(
                  //  color: Colors.blueGrey,
                  indent: 5.0,
                  endIndent: 5.0,
                ),
                _phoneUser(snapshot),
//                Divider(
//                  color: Colors.blueGrey,
//                  indent: 5.0,
//                  endIndent: 5.0,
//                ),
//                _changePassword(snapshot)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _emailUser(snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.mail_outline,
                  color: Colors.blue.withOpacity(.6),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  AppLocalizations.of(context).translate("email_str"),
                  style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: bolFont,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
               Text(
                  snapshot.email,
                  style: TextStyle(
                      fontSize: PrimaryFont,
                      fontWeight: semiFont,
                      color: lightText),
                )
                ,
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _phoneUser(snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.local_phone,
                  color: Colors.blue.withOpacity(.6),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  AppLocalizations.of(context).translate("phone_str"),
                  style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: bolFont,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
               Text(
                  snapshot.phone,
                  style: TextStyle(
                      fontSize: PrimaryFont,
                      fontWeight: semiFont,
                      color: lightText),
                )
                ,
              ],
            ),
          ),
        ],
      ),
    );
  }

}

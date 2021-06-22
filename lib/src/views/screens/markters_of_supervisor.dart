import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/views/screens/super_visor_single_markter.dart';
import 'package:medicine/theme_setting.dart';

class SuperVisorMarkters extends StatefulWidget {
  @override
  _SuperVisorMarktersState createState() => _SuperVisorMarktersState();
}

class _SuperVisorMarktersState extends State<SuperVisorMarkters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("The_Markters_str")),
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
        body: FutureBuilder(
            future: ApiService.ShowAllMarketers(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                padding: const EdgeInsets.all(15.0),

                child: ListView.builder(
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, int index) {
                          return Container(
                            child: Container(
//                            margin: EdgeInsets.only(bottom: 15.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                               SuperVisorSingleMarkter(snapshot.data.data[index])
                                      ));
                                },
                                child: Card(
                                  elevation: 3.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          child: Image.network(
//                                          "https://image.shutterstock.com/z/stock-vector-felices-fiestas-handwritten-phrase-translated-from-spanish-marry-christmas-vector-new-year-s-1209025279.jpg",
                                            snapshot.data.data[index].avatar,
                                            height: 70.0,
                                            width: 70.0,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Expanded(
                                          child: Wrap(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data.data[index].name,
//                                              "Markter name",
                                                style: TextStyle(
                                                    fontWeight: bolFont,
                                                    fontSize: MainFont),
                                              ),
                                              Container(
                                                height: 1.0,
                                              ),
                                              Text(
                                                snapshot.data.data[index].email,
//                                              "Markter email",
                                                style: TextStyle(
                                                    fontWeight: semiFont,
                                                    fontSize: PrimaryFont,
                                                    color: lightText),
                                              ),
                                              Container(
                                                height: 1.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          (snapshot.data.data[index].needCommission * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2),
//                                                        "1000",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  semiFont,
                                                              fontSize:
                                                                  PrimaryFont,
                                                              color: accentColor),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          locator<PrefsService>().currencyCode,
                                                          // AppLocalizations.of(context).translate("real_suadi_shortcut"),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  semiFont,
                                                              fontSize:
                                                                  PrimaryFont,
                                                              color: lightText),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
//                                                        "2.00",
                                                          snapshot
                                                              .data
                                                              .data[index]
                                                              .needPoint
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  semiFont,
                                                              fontSize:
                                                                  PrimaryFont,
                                                              color: accentColor),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(context).translate("Points_str"),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  semiFont,
                                                              fontSize:
                                                                  PrimaryFont,
                                                              color: lightText),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}

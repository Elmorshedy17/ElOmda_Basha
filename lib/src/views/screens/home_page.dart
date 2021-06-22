import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/filter_screen_bloc.dart';
import 'package:medicine/src/blocs/firebase_token_bloc.dart';
import 'package:medicine/src/blocs/home_page_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/local_firebase_bloc.dart';
import 'package:medicine/src/models/super_visor_marketers/home_model.dart';
import 'package:medicine/src/views/screens/filtered_screen.dart';
import 'package:medicine/src/views/screens/my_orders.dart';
import 'package:medicine/src/views/screens/notifications.dart';
import 'package:medicine/src/views/screens/single_product.dart';
import 'package:medicine/src/views/widgets/drawer.dart';
import 'package:medicine/src/views/widgets/shimmer_placeholders.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';


class HomePage extends StatefulWidget {
  var UserId;

  HomePage(this.UserId);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _countController = TextEditingController();
  BehaviorSubject isDialogAdd = new BehaviorSubject.seeded(false);

  String firstPriceRange;
  String endPriceRange;

  String firstAmount;
  String endAmount;
  TextEditingController title = TextEditingController();
  RangeValues priceValues = RangeValues(1, 100);
  RangeLabels priceLabels = RangeLabels("1", "100");
  RangeValues amountValues = RangeValues(1, 100);
  RangeLabels amountLabels = RangeLabels("1", "100");

  final FirebaseMessaging _messaging = FirebaseMessaging();

  String tokenStr;

  /////// local notifications ///////////////////
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  //////local notifications ////////////////////

  @override
  void initState() {
    super.initState();

    ///////////////////// local notification ///////////////////////////
    _messaging.getToken().then((token) {
      print("  xXx this is prime token => $token");
      tokenStr = token.toString();
      locator<FirebaseTokenBloc>().firebaseTokenSink.add(tokenStr);
      print("this is prime token $token xXx");
      // do whatever you want with the token here
      // setState(() {
      //
      // });
    });

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
    new AndroidInitializationSettings("app_icon");
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    //////////////////// local notification ////////////////////////////

    // _messaging.getToken().then((token) {
    //
    // });

    //////////////////////local notifications ///////////////////////////////

    // if (locator<PrefsService>().notificationFlag) {
      ////// firebase/////


      _messaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showNotification(message);
          print(message);
          print(message['data']['title']);
          var action = message['notification']['body'];
          var title = message['notification']['title'];
          print("messi print this is messi datat/action $action");
          locator<LocalFirebaseBloc>().localFirebaseSink.add(action);
          locator<LocalFirebaseBloc>().localFirebaseSinkTitle.add(title);
          // ApiService.AllNotificationShow().then((onValue) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Notifications(onValue)
          //     ),
          //   );
          // });


          _showNotificationWithDefaultSound();
        },
        onLaunch: (Map<String, dynamic> message) async {
          showNotification(message);
          print(message);
          // ApiService.AllNotificationShow().then((onValue) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Notifications(onValue)
          //     ),
          //   );
          // });
        },
        onResume: (Map<String, dynamic> message) async {
          showNotification(message);
          print(message);
          // ApiService.AllNotificationShow().then((onValue) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Notifications(onValue)
          //     ),
          //   );
          // });
        },
      );

      _messaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));

      _messaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });


      ////// firebase/////
//    }
//     }
  }



  void showNotification(Map<String, dynamic> payload) {
    final notification = payload["data"];
    final action = notification["action"];
    final message = notification["message"];
  }

  @override
  Widget build(BuildContext context) {


    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(AppLocalizations.of(context).translate('Are_you_sure?')),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text(AppLocalizations.of(context).translate('no_str')),
            ),
            new FlatButton(
      onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              child: new Text(AppLocalizations.of(context).translate('yes_str')),
            ),
          ],
        ),
      )) ?? false;
    }

    ApiService.DeviceId();
    return StreamBuilder(
      stream: isDialogAdd.stream,
      builder: (context, snapshot) {
        return Scaffold(
          key: _scaffoldKey,
//      appBar: AppBar(
//        title: Text("home"),
//        elevation: 0.0,
//      ),
          drawer: MyDrawer(),
          body: WillPopScope(
            onWillPop: _onWillPop,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  //     color: Colors.yellow,
                ),
                Container(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50.0)),
                    child: Container(
                      height: 200.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 25.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Image.asset(
                                  "assets/images/menu.png",
                                  height: 30.0,
                                  width: 30.0,
                                ),
                                onPressed: () =>
                                    _scaffoldKey.currentState.openDrawer(),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                AppLocalizations.of(context).translate('home_str'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MainFont,
                                    fontWeight: semiFont),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child:
                                FutureBuilder(
                                  future: ApiService.AllNotificationShow(),
                                  builder: (context, NotificationsSnapshot) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            locator<PrefsService>().NotiCount = NotificationsSnapshot.data.data.length;
                                          });
print("locator<PrefsService>().NotiCount${locator<PrefsService>().NotiCount}");
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      Notifications(NotificationsSnapshot.data)));
print("locator<PrefsService>().NotiCount${locator<PrefsService>().NotiCount}");

                                        },
                                        child: Stack(
                                          children: <Widget>[

                                            Icon(
                                              Icons.notifications_none,
                                              color: Colors.white,
                                              size: 35.0,
                                            ),
                                            NotificationsSnapshot.hasData?    Positioned(
                                              top: 6.0,
                                              child: Container(
                                                child: Center(child: Text("${NotificationsSnapshot.data.data.length - locator<PrefsService>().NotiCount}",style: TextStyle(color: Colors.white,height: 1.5,fontSize: 10),)),
                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius.all(Radius.circular(500.0),
                                                  ),
                                                  color: Colors.red,

                                                ),
                                                height: 18.0,
                                                width: 15.0,
                                              ),
                                            ):Container(),
                                          ],
                                        ));
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 85.0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      controller: title,
                      onChanged: (val) {
                        locator<HomePageBloc>().searchSink.add(title.text);
//                             print("${locator<HomePageBloc>().currenSearch}");
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignLabelWithHint: true,
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) => FilteredScreen(
                                        "",
                                        "",
                                        "",
                                        "",
                                      )),
                            );
                          },
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _settingModalBottomSheet(context);
                          },
                          icon: Image.asset("assets/images/filter.png"),
                        ),
                        hintText:
                            AppLocalizations.of(context).translate('search_str'),
                        hintStyle: TextStyle(color: midGrey, fontSize: 16),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 145.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 150,
                    // color: Colors.red,
                    child: FutureBuilder(
//                    future: ApiService.HomePageApi(widget.UserId.toString()),
                        future: ApiService.HomePageApi(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          //     var homePageContent = snapshot.data.data;
//                    locator<HomePageBloc>().;
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data.data.sectionData.length,
                                  physics: ScrollPhysics(),
                                  //  shrinkWrap: true,
                                  itemBuilder: (context, int index) {
                                    return
                                        //  snapshot.connectionState != ConnectionState.done

                                        _singleProduct(
                                            snapshot.data.data.sectionData[index]);
                                  })
                              : HomePageItemShimmer();
                        }),
                  ),
                ),
                isDialogAdd.value == true ?  Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(child: CircularProgressIndicator()),
                ):Container(),
              ],
            ),
          ),
        );
      }
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setMoadalState
                /*You can rename this!*/) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Material(
                  child: Container(
                    color: Color(0xFF737373),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(15.0),
                              topRight: const Radius.circular(15.0))),
                      child: new Wrap(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('search_about_str'),
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: MainFont,
                                    fontWeight: bolFont),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('price_average'),
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: PrimaryFont,
                                      fontWeight: semiFont),
                                ),
                                firstPriceRange != null || endPriceRange != null
                                    ? Text(
                                        "${firstPriceRange} - ${endPriceRange}",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor))
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            child: RangeSlider(
                              min: 1,
                              max: 100,
                              values: priceValues,
                              labels: priceLabels,
                              //  divisions: 1,
                              onChanged: (val) {
                                print(val);
                                setMoadalState(() {
                                  priceValues = val;
                                  priceLabels = RangeLabels(
                                      val.start.toString(), val.end.toString());
                                  firstPriceRange = val.start.toInt().toString();
                                  endPriceRange = val.end.toInt().toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('amount_average'),
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: PrimaryFont,
                                    fontWeight: semiFont),
                              ),
                              firstAmount != null || endAmount != null
                                  ? Text(
                                      "${firstAmount} - ${endAmount}",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          RangeSlider(
                            min: 1,
                            max: 100,
                            values: amountValues,
                            labels: amountLabels,
                            //  divisions: 1,
                            onChanged: (val) {
                              print(val);
                              setMoadalState(() {
                                amountValues = val;
                                amountLabels = RangeLabels(
                                    val.start.toString(), val.end.toString());
                                firstAmount = val.start.toInt().toString();
                                endAmount = val.end.toInt().toString();
                              });
                            },
                          ),
                          SizedBox(
                            height: 55.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 60.0,
                              child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('just_search'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MainFont,
                                    fontWeight: semiFont,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            FilteredScreen(
                                              firstPriceRange,
                                              endPriceRange,
                                              firstAmount,
                                              endAmount,
                                            )),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

// single product card with image

  Widget _singleProduct(sectionDataContent) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    SingleProduct(sectionDataContent)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: 200.0,
        width: 300.0,
        //    color: Colors.green,
        child: Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 3.0,
              child: Container(
                height: 190.0,
                width: MediaQuery.of(context).size.width - 100.0,
                padding: EdgeInsets.only(
                    top: 7.0, right: locator<PrefsService>().appLanguage == "en"? 70.0 : 15.0, bottom: 0.0, left:locator<PrefsService>().appLanguage == "en"? 15.0:70.0),
                child: Wrap(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          sectionDataContent.title,
                          // "Product Name",
                          style: TextStyle(
                            fontWeight: bolFont,
                            fontSize: MediumFont,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 10.0,
                    ),
                    Text(
                      //  "This text is an example of text that can be replaced in the same space",
                      sectionDataContent.desc,
                      style: TextStyle(
                          fontWeight: semiFont,
                          fontSize: PrimaryFont,
                          color: littleGrey),
                      maxLines: 2,
                    ),
                    Container(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('amount_:'),
                          style: TextStyle(
                            fontWeight: semiFont,
                            fontSize: PrimaryFont,
                            //   color: midGrey
                          ),
                        ),
                        Text(
                          " ${sectionDataContent.quantity.toString()}  ${AppLocalizations.of(context).translate('package')}",
                          //  "30 package",
                          style: TextStyle(
                              fontWeight: semiFont,
                              fontSize: PrimaryFont,
                              color: littleGrey),
                        ),
                      ],
                    ),
                    Container(
                      height: 15.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            height: 40.0,
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                              child: FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("Add_to_Cart_str"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: PrimaryFont,
                                    fontWeight: regFont,
                                  ),
                                ),
                              ),

                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return FutureBuilder(
                                          future: ApiService.AddToCart(sectionDataContent.id.toString()),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            return AlertDialog(
                                              title: snapshot.hasData? Text(snapshot.data.msg):Center(child: CircularProgressIndicator()),
                                            );
                                          }
                                      );
                                    }
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              sectionDataContent.totalForCountry.toString(),
                              //"100",
                              style: TextStyle(
                                  fontWeight: semiFont,
                                  fontSize: MediumFont,
                                  color: Theme.of(context).accentColor),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              sectionDataContent.currencyCode.toString(),
                              style: TextStyle(
                                  fontWeight: regFont,
                                  fontSize: SecondaryFont,
                                  color: littleGrey),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 40,
                right:locator<PrefsService>().appLanguage == "en"? 0.0 : MediaQuery.of(context).size.width - 170 ,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SingleProduct(sectionDataContent)));
                  },
                  child: Image.network(
                    sectionDataContent.image,
                    height: 110.0,
                    width: 110.0,
                  ),

//                Image.asset(
//                  "assets/images/product1.png",
//                  height: 110.0,
//                  width: 110.0,
//                ),
                )),
          ],
        ),
      ),
    );
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '${locator<LocalFirebaseBloc>().currentlocalFirebaseTitle}',
      '${locator<LocalFirebaseBloc>().currentlocalFirebase}',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
  Future onSelectNotification(String payload) async {
//    showDialog(
//      context: context,
//      builder: (_) {
//        return new AlertDialog(
//          title: Text("PayLoad"),
//          content: Text("Payload : $payload"),
//        );
//      },
//    );
  }


  dispose() {
    isDialogAdd.close();
    super.dispose();
  }
}
//
//class DataSearch extends SearchDelegate<String> {
//
// final recentSearches = [];
//
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    // TODO: implement buildActions
//    //action for app bar
//    return [
//      IconButton(
//        icon: Icon(Icons.clear),
//        onPressed: () {},
//      )
//    ];
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    // TODO: implement buildLeading
//    // leading icon on the left of the app bar
//    return IconButton(
//      icon: AnimatedIcon(
//        icon: AnimatedIcons.menu_arrow,
//        progress: transitionAnimation,
//      ),
//      onPressed: () {},
//    );
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    // TODO: implement buildResults
//    // show some result based on the selection
//    return null;
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    // TODO: implement buildSuggestions
//    // sow when some one searches for something
//    return null;
//  }
//}

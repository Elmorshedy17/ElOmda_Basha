import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/currenct_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/delivery_coasts_bloc.dart';
import 'package:medicine/src/blocs/firebase_token_bloc.dart';
import 'package:medicine/src/blocs/local_firebase_bloc.dart';
import 'package:medicine/src/models/delivery_models/all_notification_show_model.dart';
import 'package:medicine/src/views/screens/delivery_order_details.dart';
import 'package:medicine/src/views/screens/notifications.dart';
import 'package:medicine/src/views/widgets/drawer.dart';
import 'package:medicine/src/views/widgets/shimmer_placeholders.dart';
import 'package:medicine/theme_setting.dart';



class DeliveyHomePage extends StatefulWidget {
  var UserId;

  DeliveyHomePage(this.UserId);

  @override
  _DeliveyHomePageState createState() => _DeliveyHomePageState();
}

class _DeliveyHomePageState extends State<DeliveyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      // do whatever you want with the token here
      // setState(() {
      //
      // });
      tokenStr = token.toString();
      locator<FirebaseTokenBloc>().firebaseTokenSink.add(tokenStr);
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

    _messaging.getToken().then((token) {
      print("this is prime token $token");
    });

    //////////////////////local notifications ///////////////////////////////

    // if (locator<PrefsService>().notificationFlag) {
      ////// firebase/////

      _messaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showNotification(message);
          print(message);
          var action = message['notification']['body'];
          var title = message['notification']['title'];
          var orderID = message['data']['data_id'];
          print("messi print this is messi datat/action $action");
          locator<LocalFirebaseBloc>().localFirebaseSink.add(action);
          locator<LocalFirebaseBloc>().localFirebaseSinkTitle.add(title);
          locator<LocalFirebaseBloc>().localFirebaseOrderID.add(orderID);

          _showNotificationWithDefaultSound();
        },
        onLaunch: (Map<String, dynamic> message) async {
          showNotification(message);
          print(message);
        },
        onResume: (Map<String, dynamic> message) async {
          showNotification(message);
          print(message);
        },
      );

      _messaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));

      _messaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });


      ////// firebase/////
    // }
  }

  void showNotification(Map<String, dynamic> payload) {
    final notification = payload["data"];
    final action = notification["action"];
    final message = notification["message"];
  }

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

  Future<Null> _refresh() async{
    setState(() {

    });
print("hathat");
  }

  @override
  Widget build(BuildContext context) {
    ApiService.DeviceId();
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: WillPopScope(
        onWillPop:_onWillPop,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                            child: FutureBuilder<AllNotificationShowModel>(
                                future: ApiService.AllNotificationShow(),
                                builder: (context, NotificationsSnapshot) {
                                  return InkWell(
                                      onTap: () {
                                        print("locator<PrefsService>().NotiCount${locator<PrefsService>().NotiCount}");
setState(() {
  locator<PrefsService>().NotiCount = NotificationsSnapshot.data.data.pagination.total;
});
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (BuildContext
                                                context) =>
                                                    Notifications()));
                                        print("locator<PrefsService>().NotiCount${locator<PrefsService>().NotiCount}");
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          Icon(
                                            Icons.notifications_none,
                                            color: Colors.white,
                                            size: 35.0,
                                          ),
                                          NotificationsSnapshot.hasData
                                              ? Positioned(
                                            top: 6.0,
                                            child: Container(
                                              child: Center(
                                                  child: Text("${NotificationsSnapshot.data.data.pagination.total - locator<PrefsService>().NotiCount}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        height: 1.5,fontSize: 10),
                                                  )),
                                              decoration:
                                              new BoxDecoration(
                                                borderRadius:
                                                new BorderRadius.all(
                                                  Radius.circular(500.0),
                                                ),
                                                color: Colors.red,
                                              ),
                                              height: 18.0,
                                              width: 15.0,
                                            ),
                                          )
                                              : Container(),
                                        ],
                                      ));
                                }),
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
              child: Container(
                // color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 100,
                // color: Colors.red,
                child: FutureBuilder(
                    future: ApiService.ShowNewDelegatesOrders(
                    widget.UserId.toString()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {

                      if(snapshot.hasData){
                        if(snapshot.data.data.isNotEmpty){
                          locator<CurrencyBloc>().CurrencySubject.sink.add(snapshot.data.data[0].currencyCode);
                        }else{
                          locator<CurrencyBloc>().CurrencySubject.sink.add("");
                        }
                      }

                      return snapshot.hasData
                        //   ? RefreshIndicator(
                        // onRefresh: _refresh,
                        // child:  ListView(
                        //   primary: true,
                        //   reverse: true,
                        //   padding: EdgeInsets.zero,
                        //   children: [
                          ?  Container(
                              height: MediaQuery.of(context).size.height - 100,
                              width: double.infinity,
                              // color: Colors.blueAccent,
                              child: snapshot.data.data.length > 0 ? RefreshIndicator(
                                onRefresh: _refresh,
                                child: ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.data.length,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      // return _singleProduct(
                                      //     snapshot.data.data[index]);
                                      return _singleProduct(
                                          snapshot.data.data[index]);
                                    }),
                              ):RefreshIndicator(
                                onRefresh: _refresh,
                                child: ListView(
                                  reverse: true,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * .4,
                                    ),
                                    Center(
                                      child: Text(
                                        AppLocalizations.of(context).translate(
                                            "There are no new orders on your area"),
                                        style: TextStyle(
                                            color: lightText,
                                            fontSize: PrimaryFont),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        //   ],
                        // ))
                          : HomePageItemShimmer();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

// single product card with image

  Widget _singleProduct(data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => DeliveryOrderDetails(data)));
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
                height: 165.0,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    top: 7.0, right: 15.0, bottom: 0.0, left: 15.0),
                child: Wrap(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .translate("Order_Number_str"),

                          // "Product Name",
                          style: TextStyle(
                            fontWeight: bolFont,
                            fontSize: MediumFont,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          data.id.toString(),
                          style: TextStyle(
                              fontWeight: bolFont,
                              fontSize: PrimaryFont,
                              color: littleGrey),
                        ),
                      ],
                    ),
                    Container(
                      height: 10.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: <Widget>[
                    //     Text(
                    //       AppLocalizations.of(context).translate("Adress_str"),
                    //       maxLines: 2,
                    //
                    //       // "Product Name",
                    //       style: TextStyle(
                    //         fontWeight: semiFont,
                    //         fontSize: SecondaryFont,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 8.0,
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         data.address,
                    //         style: TextStyle(
                    //             fontWeight: semiFont,
                    //             fontSize: PrimaryFont,
                    //             color: littleGrey),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Container(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .translate("Order_Time_str:"),

                          // "Product Name",
                          style: TextStyle(
                            fontWeight: semiFont,
                            fontSize: PrimaryFont,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          data.date,
                          style: TextStyle(
                              fontWeight: semiFont,
                              fontSize: PrimaryFont,
                              color: littleGrey),
                        ),
                      ],
                    ),
                    Container(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate("Tottal_Price_str"),
                                // "Product Name",
                                style: TextStyle(
                                  fontWeight: semiFont,
                                  fontSize: PrimaryFont,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                data.totalForCountry.toString(),
                                style: TextStyle(
                                    fontWeight: semiFont,
                                    fontSize: PrimaryFont,
                                    color: accentColor),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                data.currencyCode.toString(),
//                          "ريال سغودي",
//                                 AppLocalizations.of(context)
//                                     .translate("real_suadi_shortcut"),

                                style: TextStyle(
                                    fontWeight: regFont,
                                    fontSize: SecondaryFont,
                                    color: littleGrey),
                              ),
                            ],
                          ),
                        ),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                          child: FittedBox(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("Deliver_str"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: PrimaryFont,
                                fontWeight: regFont,
                              ),
                            ),
                          ),

                          onPressed: () {
                            locator<DeliveryCostaBloc>().deliveryCostsSink
                                .add("");
                            locator<DeliveryCostaBloc>().deliveryCostsSink.add(
                                AppLocalizations.of(context)
                                    .translate("Deliver_Coasts_str"));
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DeliveryOrderDetails(data)));
                          },
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

    // locator<IsLoadingManager>().isLoading.add(true);
    //
    // ApiService.ShowDelegateOrder(
    //     locator<LocalFirebaseBloc>().localFirebaseOrderID.value).then((onValue) {
    //   locator<IsLoadingManager>().isLoading.add(false);
    //
    //   if (onValue.key == "1") {
    //     Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>
    //         DelivereyFollowOrder(onValue,onValue)));
    //   } else {
    //     showDialog(context: context, builder: (BuildContext context) {
    //       return AlertDialog(title: Text(onValue.msg),);});}
    // });

  }
}

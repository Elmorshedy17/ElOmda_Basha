import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/features/track_details/_model.dart';
import 'package:momentoo/features/track_details/_manager.dart';
import 'package:rxdart/rxdart.dart';


class TrackOrderScreenArguments {
  final int id;

  TrackOrderScreenArguments({@required this.id});
}


class TrackOrderScreen extends StatefulWidget {
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {

  TrackOrderScreenArguments args;

//  List firstTrackingList = [];
//  List secondTrackingList = [];
//  List thirdTrackingList = [];
//  List forthTrackingList = [];



  BehaviorSubject firstTrackingController = new BehaviorSubject();
  BehaviorSubject secondTrackingController = new BehaviorSubject();
  BehaviorSubject thirdTrackingController = new BehaviorSubject();
  BehaviorSubject forthTrackingController = new BehaviorSubject();




  @override

  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    //  _orderedSuccessfully() = > its always active
    Widget _orderedSuccessfully(name,date) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 115.0,
//                              color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 105.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 28.0),
                    height: 3.0,
                    width: 95.0,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset("assets/images/order2@2x.png"),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.teal.shade900, width: 4),
                    borderRadius: new BorderRadius.all(Radius.circular(40.0)),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
//                    AppLocalizations.of(context)
//                        .translate("Ordered_successfully_str"),
                    name,
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
//                  Container(
//                    height: 5.0,
//                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // end _orderedSuccessfully()

    // _preparing active

    Widget _preparing(name , date) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 115.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 105.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 28.0),
                    height: 3.0,
                    width: 95.0,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset("assets/images/prepare_done.png"),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.teal.shade900, width: 4),
                    borderRadius: new BorderRadius.all(Radius.circular(40.0)),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
//                    AppLocalizations.of(context).translate("Preparing_str")
                    name,
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
//                  Container(
//                    height: 5.0,
//                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // _preparing

    // _onTheWay active
    Widget _onTheWay(name,date) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 115.0,
//                              color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 105.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 28.0),
                    height: 3.0,
                    width: 95.0,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset("assets/images/on_the_way_done.png"),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.teal.shade900, width: 4),
                    borderRadius: new BorderRadius.all(Radius.circular(40.0)),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
//                    AppLocalizations.of(context).translate("On_the_way_str")
                   name ,
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
//                  Container(
//                    height: 5.0,
//                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // end _onTheWay

    // _delivered active
    Widget _delivered(name ,date) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 115.0,
//                              color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 105.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 28.0),
                    height: 3.0,
                    width: 95.0,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset("assets/images/delivered_done.png"),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.teal.shade900, width: 4),
                    borderRadius: new BorderRadius.all(Radius.circular(40.0)),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 110.0,
              child:                   Text(
//                    AppLocalizations.of(context).translate("Delivered_str")
                name,
                style: TextStyle(
                    color: Colors.teal.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
//              Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
////                    AppLocalizations.of(context).translate("Delivered_str")
//                    name,
//                    style: TextStyle(
//                        color: Colors.teal.shade900,
//                        fontSize: 18,
//                        fontWeight: FontWeight.w600),
//                  ),
//                  Container(
//                    height: 5.0,
//                  ),
//                  Text(
//                    date,
//                    style: TextStyle(
//                        color: Colors.grey,
//                        fontSize: 16,
//                        fontWeight: FontWeight.bold),
//                  ),
//                  SizedBox(
//                    height: 5.0,
//                  ),
//                  RaisedButton(
//                    color: Colors.teal.shade700,
//                    child: Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: Text(
//                        AppLocalizations.of(context)
//                            .translate("Rate_vendor_str"),
//                        style: TextStyle(color: Colors.white),
//                      ),
//                    ),
//                    onPressed: () {
////                      _showDialog(context);
//                      print(firstTrackingController.value);
//                    },
//                  ),
//                ],
//              ),
            ),
          ),
        ],
      );
    }
    // _delivered finish

    // not active delivered
    Widget _notDelivered(name,date) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 115.0,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: locator<PrefsService>().appLanguage == "en"
                          ? 20.0
                          : 0,
                      right:
                      locator<PrefsService>().appLanguage == "en" ? 0 : 20),
                  width: 70.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 28.0),
                    height: 3.0,
                    width: 95.0,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 45,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset("assets/images/delivered.png"),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 4),
                        borderRadius:
                        new BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
//                    AppLocalizations.of(context).translate("Delivered_str")
                    name,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
//                  Container(
//                    height: 5.0,
//                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // end not active delivered

    // not active delivered
    Widget _notOnTheWay(name,date) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 115.0,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: locator<PrefsService>().appLanguage == "en"
                          ? 20.0
                          : 0,
                      right:
                      locator<PrefsService>().appLanguage == "en" ? 0 : 20),
                  width: 70.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 28.0),
                    height: 3.0,
                    width: 95.0,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 45,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset("assets/images/on_the_way.png"),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 4),
                        borderRadius:
                        new BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
//                    AppLocalizations.of(context).translate("On_the_way_str")
                    name,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
//                  Container(
//                    height: 5.0,
//                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // end not active delivered

    // not active delivered
    Widget _notPreparing(name,date) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 115.0,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: locator<PrefsService>().appLanguage == "en"
                          ? 20.0
                          : 0,
                      right:
                      locator<PrefsService>().appLanguage == "en" ? 0 : 20),
                  width: 70.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 28.0),
                    height: 3.0,
                    width: 95.0,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 45,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset("assets/images/prepare.png"),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 4),
                        borderRadius:
                        new BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
//                    AppLocalizations.of(context).translate("Preparing_str")
                    name,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
//                  Container(
//                    height: 5.0,
//                  ),
                  Text(
                     date,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // end not active delivered

    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.2,
      child: CustomObserver(
          stream: locator<TrackOrderManager>().getData(args.id),
          onSuccess: (_, TrackOrderModel model) {
            for (int index = 0;index < model.data.order.steps.length;index++) {

              if(model.data.order.steps[index].id == 1 ){
                firstTrackingController.add(model.data.order.steps[index]);
              }
              if(model.data.order.steps[index].id == 2 ){
                secondTrackingController.add(model.data.order.steps[index]);
              }
              if(model.data.order.steps[index].id == 3 ){
                thirdTrackingController.add(model.data.order.steps[index]);
              }
              if(model.data.order.steps[index].id == 4 ){
                forthTrackingController.add(model.data.order.steps[index]);
              }


            }
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context).translate('Track_your_order_str'),
                  // AppLocalizations.of(context).translate('test'),
                  style: TextStyle(color: Colors.white),
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
                actions: <Widget>[
                  NotificationWidget(
                    onPressedNotifications: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.of(context).pushNamed('/notificationsScreen');

                      locator<PrefsService>().notificationFlag = false;
                    },
                  )
                ],
              ),
              body: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 3.0),
                        width: MediaQuery.of(context).size.width - 50,
                        margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                // picture and other details
                                Row(
                                  children: <Widget>[
                                    // the order image
                                    Container(
                                      height: 65.0,
                                      width: 65.0,
                                      child: Image.network(
                                        model.data.order.logo,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    // end the order image
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    // order number & price & desc
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // order number
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate("Order_Number_str"),
                                                style: TextStyle(
                                                    color: Colors.teal.shade900,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                "# ${model.data.order.id}",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          // end order number

                                          SizedBox(
                                            height: 8.0,
                                          ),
// desc of order
                                          Text(
                                            "${model.data.order.seller}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          // end desc of order

                                          SizedBox(
                                            height: 8.0,
                                          ),

                                          // price
                                          Text(
                                            "${model.data.order.total}",
                                            style: TextStyle(
                                                color: Colors.teal.shade900,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          // end price
                                        ],
                                      ),
                                    ),
                                    // order number & price & desc
                                  ],
                                ),
                                // end picture and other details
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 30,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: locator<PrefsService>().appLanguage == "en"
                              ? 60.0
                              : null,
                          right:
                          locator<PrefsService>().appLanguage == "en" ? null : 60,
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: 5.0,
                            color: Colors.grey,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left:
                          locator<PrefsService>().appLanguage == "en" ? 35.0 : 0,
                          right:
                          locator<PrefsService>().appLanguage == "en" ? 0 : 35.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              StreamBuilder(
                                stream: firstTrackingController.stream,
                                builder: (context, firstTrackingControllerSnapshot) {
                                  return firstTrackingControllerSnapshot.hasData ? _orderedSuccessfully(firstTrackingControllerSnapshot.data.name, firstTrackingControllerSnapshot.data.date):Container();
                                }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              StreamBuilder(
                                stream: secondTrackingController.stream,
                                builder: (context, secondTrackingControllerSnapshot) {
                                  return secondTrackingControllerSnapshot.hasData? Container(child: secondTrackingControllerSnapshot.data.active == "yes" ? _preparing(secondTrackingControllerSnapshot.data.name, secondTrackingControllerSnapshot.data.date) : _notPreparing(secondTrackingControllerSnapshot.data.name, secondTrackingControllerSnapshot.data.date == "" ? AppLocalizations.of(context).translate('Not_yet_str') : secondTrackingControllerSnapshot.data.date)):Container();
                                }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              StreamBuilder(
                                stream: thirdTrackingController.stream,
                                builder: (context, thirdTrackingControllerSnapshot) {
                                  return thirdTrackingControllerSnapshot.hasData ? Container(child: thirdTrackingControllerSnapshot.data.active == "yes" ? _onTheWay(thirdTrackingControllerSnapshot.data.name , thirdTrackingControllerSnapshot.data.date) : _notOnTheWay(thirdTrackingControllerSnapshot.data.name , thirdTrackingControllerSnapshot.data.date == "" ? AppLocalizations.of(context).translate('Not_yet_str'):thirdTrackingControllerSnapshot.data.date)):Container();
                                }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              StreamBuilder(
                                stream: forthTrackingController.stream,
                                builder: (context, forthTrackingControllerSnapshot) {
                                  return forthTrackingControllerSnapshot.hasData ? Container(child: forthTrackingControllerSnapshot.data.active == "yes" ?  _delivered(forthTrackingControllerSnapshot.data.name , forthTrackingControllerSnapshot.data.date) : _notDelivered(forthTrackingControllerSnapshot.data.name , forthTrackingControllerSnapshot.data.date == "" ? AppLocalizations.of(context).translate('Not_yet_str'):forthTrackingControllerSnapshot.data.date )) : Container();
                                }
                              ),
//                        SizedBox(
//                          height: 65.0,
//                        ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  List _countries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    " Antigua and Barbuda",
    "Argentina",
    " Armenia",
    "Australia",
    "Austria",
    "Austrian Empire",
  ];

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate("Choose_Country_str"),
                style: TextStyle(
                    color: Colors.teal.shade900,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 300.0, // Change as per your requirement
                width: 300.0, //
                child: ListView.separated(
                  //  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(.5),
                  ),
                  itemCount: _countries.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      print(
                          "this is print of the countery name ${_countries[index]}");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _countries[index],
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void dispose() {
    firstTrackingController.close();
    secondTrackingController.close();
    thirdTrackingController.close();
    forthTrackingController.close();

    super.dispose();
  }
}


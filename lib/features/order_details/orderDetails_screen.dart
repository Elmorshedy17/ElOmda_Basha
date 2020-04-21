import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  _orderedSuccessfully() = > its always active
    Widget _orderedSuccessfully() {
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
                    AppLocalizations.of(context)
                        .translate("Ordered_successfully_str"),
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Text(
                    "24/11/2019",
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

    Widget _preparing() {
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
                    AppLocalizations.of(context).translate("Preparing_str"),
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Text(
                    "24/11/2019",
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
    Widget _onTheWay() {
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
                    AppLocalizations.of(context).translate("On_the_way_str"),
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Text(
                    "24/11/2019",
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
    Widget _delivered() {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate("Delivered_str"),
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Text(
                    "24/11/2019",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  RaisedButton(
                    color: Colors.teal.shade700,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("Rate_vendor_str"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      _showDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // _delivered finish

    // not active delivered
    Widget _notDelivered() {
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
                    AppLocalizations.of(context).translate("Delivered_str"),
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Text(
                    "Not yet",
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
    Widget _notOnTheWay() {
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
                    AppLocalizations.of(context).translate("On_the_way_str"),
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Text(
                    "Not yet",
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
    Widget _notPreparing() {
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
                    AppLocalizations.of(context).translate("Preparing_str"),
                    style: TextStyle(
                        color: Colors.grey.withOpacity(.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Text(
                    "Not yet",
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('Order_details_str'),
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
                locator<TextEditingController>().clear();
                Navigator.of(context)
                    .pushNamed('/notificationsScreen');
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
                                  'https://picsum.photos/250?image=9',
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
                                          "# 2235",
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
                                      "2x tuna sahimi , 3x vegtables, 1x nudle",
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
                                      "18 KW",
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
                        _orderedSuccessfully(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _notPreparing(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _notOnTheWay(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _delivered(),
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
}

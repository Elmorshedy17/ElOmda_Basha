import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  BehaviorSubject addressesBehaviorSubject = BehaviorSubject();
  BehaviorSubject cityBehaviorSubject = BehaviorSubject();

  FocusNode firstNameFocusNode = new FocusNode();
  FocusNode lastNameFocusNode = new FocusNode();
  FocusNode phoneNumberFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();

  FocusNode blockFocusNode = new FocusNode();
  FocusNode streetFocusNode = new FocusNode();
  FocusNode streetTwoFocusNode = new FocusNode();
  FocusNode houseFocusNode = new FocusNode();
  FocusNode floorFocusNode = new FocusNode();
  FocusNode jaddaFocusNode = new FocusNode();
  FocusNode apartmentFocusNode = new FocusNode();
  FocusNode instructionsFocusNode = new FocusNode();

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

  bool deliveryChecked = true;
  bool pickUpCheck = false;

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('my_orders_Str'),
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
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.notifications),
//              onPressed: () {
//                // FocusScope.of(context).requestFocus(FocusNode());
//                // overlayEntry?.remove();
//                Navigator.of(context).pushNamed('/notificationsScreen');
//              },
//            ),
//          ],
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              child: ListView(
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // order number
                                        Text(
                                          "# 2235",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
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
                                height: 10.0,
                              ),
                              Container(
                                height: 1.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.withOpacity(.2),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // order number
                                        Text(
                                          "# 2235",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
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
                                height: 10.0,
                              ),
                              Container(
                                height: 1.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.withOpacity(.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  // Delivery & pickup
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    deliveryChecked = false;
                                    pickUpCheck = true;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('PickUp_str'),
                                      style: TextStyle(
                                          color: pickUpCheck == true
                                              ? Colors.black.withOpacity(.7)
                                              : Colors.black.withOpacity(.3),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    pickUpCheck == true
                                        ? Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.teal.shade800,
                                              borderRadius:
                                                  new BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.check,
                                                size: 28,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(.7),
                                              borderRadius:
                                                  new BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    deliveryChecked = true;
                                    pickUpCheck = false;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('Delivery_str'),
                                      style: TextStyle(
                                          color: deliveryChecked == true
                                              ? Colors.black.withOpacity(.7)
                                              : Colors.black.withOpacity(.3),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    deliveryChecked == true
                                        ? Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.teal.shade800,
                                              borderRadius:
                                                  new BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.check,
                                                size: 28,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(.7),
                                              borderRadius:
                                                  new BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        AppLocalizations.of(context).translate('addresses_str'),
                        style: TextStyle(color: Colors.grey, fontSize: 21),
                      ),
                      children: <Widget>[
                        StreamBuilder<Object>(
                            stream: addressesBehaviorSubject.stream,
                            builder: (context, addressesSnapshot) {
                              return Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          color: Colors.grey.withOpacity(.5),
                                        ),
                                    itemCount: _countries.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          addressesBehaviorSubject.sink
                                              .add(index);
                                          print(
                                              "this is print of the countery name ${_countries[index]}");
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                _countries[index],
                                                style: TextStyle(
                                                    color: index ==
                                                            addressesBehaviorSubject
                                                                .value
                                                        ? Colors.teal.shade900
                                                        : Colors.black54,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              index ==
                                                      addressesBehaviorSubject
                                                          .value
                                                  ? Container(
                                                      height: 28.0,
                                                      width: 28.0,
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors
                                                            .teal.shade800,
                                                        borderRadius:
                                                            new BorderRadius
                                                                .all(
                                                          Radius.circular(50.0),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.check,
                                                          size: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }),
                      ],
                    ),
                  ),
                  // end Delivery & pickup

                  SizedBox(
                    height: 20.0,
                  ),

                  // User details
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('User_details_str'),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.7),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: firstNameFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  FocusScope.of(context)
                                      .requestFocus(lastNameFocusNode);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("first_name_str"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: lastNameFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  FocusScope.of(context)
                                      .requestFocus(phoneNumberFocusNode);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("last_name_str"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: phoneNumberFocusNode,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (String value) {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocusNode);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("965_phone_number_str"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: emailFocusNode,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("email_str"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // end User details

                  SizedBox(
                    height: 20.0,
                  ),

                  // User address details
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('Address_Details_str'),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.7),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[100],
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate('Kuwait_str'),
                                      style: TextStyle(
                                          color: Colors.teal.shade900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          ExpansionTile(
                            backgroundColor: Colors.grey[100],
                            title: Text(
                              AppLocalizations.of(context)
                                  .translate('addresses_str'),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 21),
                            ),
                            children: <Widget>[
                              StreamBuilder<Object>(
                                  stream: cityBehaviorSubject.stream,
                                  builder: (context, addressesSnapshot) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                                color:
                                                    Colors.grey.withOpacity(.5),
                                              ),
                                          itemCount: _countries.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                cityBehaviorSubject.sink
                                                    .add(index);
                                                print(
                                                    "this is print of the countery name ${_countries[index]}");
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      _countries[index],
                                                      style: TextStyle(
                                                          color: index ==
                                                                  cityBehaviorSubject
                                                                      .value
                                                              ? Colors
                                                                  .teal.shade900
                                                              : Colors.black54,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    index ==
                                                            cityBehaviorSubject
                                                                .value
                                                        ? Container(
                                                            height: 28.0,
                                                            width: 28.0,
                                                            decoration:
                                                                new BoxDecoration(
                                                              color: Colors.teal
                                                                  .shade800,
                                                              borderRadius:
                                                                  new BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    50.0),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.check,
                                                                size: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
//                            color: Colors.grey[100],
                            child: Container(
//                              margin:
//                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        focusNode: blockFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          FocusScope.of(context)
                                              .requestFocus(streetFocusNode);
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: AppLocalizations.of(context)
                                              .translate("Block_Str"),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        focusNode: streetFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          FocusScope.of(context)
                                              .requestFocus(streetTwoFocusNode);
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: AppLocalizations.of(context)
                                              .translate("Street_str"),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: streetTwoFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  FocusScope.of(context)
                                      .requestFocus(houseFocusNode);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("Street_two_str"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: houseFocusNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  FocusScope.of(context)
                                      .requestFocus(floorFocusNode);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("House_building_str"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
//                            color: Colors.grey[100],
                            child: Container(
//                              margin:
//                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        focusNode: floorFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          FocusScope.of(context)
                                              .requestFocus(jaddaFocusNode);
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: AppLocalizations.of(context)
                                              .translate("Floor_Str"),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        focusNode: jaddaFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          FocusScope.of(context)
                                              .requestFocus(apartmentFocusNode);
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          hintText: AppLocalizations.of(context)
                                              .translate("Jadda_str"),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: apartmentFocusNode,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (String value) {
                                  FocusScope.of(context)
                                      .requestFocus(instructionsFocusNode);
                                },
                                decoration: InputDecoration(
                                  suffix: Text(
                                    "(${AppLocalizations.of(context).translate("optional_Str")})",
                                  ),
                                  suffixStyle: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("Apartment_Office_name"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                focusNode: instructionsFocusNode,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  suffix: Text(
                                    "(${AppLocalizations.of(context).translate("optional_Str")})",
                                  ),
                                  suffixStyle: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("Apartment_Office_name"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: TextFormField(
                                maxLines: 8,
                                focusNode: phoneNumberFocusNode,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (String value) {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocusNode);
                                },
                                decoration: InputDecoration(
                                  suffix: Text(
                                    "(${AppLocalizations.of(context).translate("optional_Str")})",
                                  ),
                                  suffixStyle: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context)
                                      .translate("Delivery_instructions"),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // end User address details

                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          suffixIcon: RaisedButton(
                            onPressed: () {},
                            color: Colors.teal.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.teal.shade900,
                                )),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("check_str"),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: AppLocalizations.of(context)
                              .translate("Discount_code_str"),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate("subtotal_str"),
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "24.5",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "KD",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate("Discount_str"),
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "24.5",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "KD",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate("subtotal_str"),
                                style: TextStyle(
                                    color: Colors.teal.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "24.5",
                                    style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "KD",
                                    style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ButtonTheme(
                    minWidth: 280.0,
                    height: 55.0,
                    child: RaisedButton(
                      color: Colors.teal.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate('Pay_now_Str'),
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}

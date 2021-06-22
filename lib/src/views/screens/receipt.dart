import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/views/screens/follow_order.dart';
import 'package:medicine/theme_setting.dart';

class Receipt extends StatefulWidget {
  var data;
  Receipt(this.data);

  @override
  _ReceiptState createState() => _ReceiptState();
}


class _ReceiptState extends State<Receipt> {
//  List<SingleModify> singleModifies = <SingleModify>[
//    SingleModify(
//        1, "Product name", "2 packetes", 100, "assets/images/product1.png", 1),
//    SingleModify(
//        2, "Product name", "2 packetes", 100, "assets/images/product1.png", 1),
//  ];

  bool canceled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("Receipt")),
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
      body: Stack(
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
                height: 100.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            top: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.data.orderItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: ListTile(
                                    title: Row(
                                      children: <Widget>[
                                        Flexible(
                                          flex: 3,
                                          child: Image.network(
                                            widget.data.orderItems[index]
                                                .sectionImage,
                                            height: 110.0,
                                            width: 110.0,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 7,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      widget.data.orderItems[index].sectionTitle,
                                                      style: TextStyle(
                                                        fontWeight: bolFont,
                                                        fontSize: MediumFont,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(AppLocalizations.of(context).translate("Ordered amount :"),
                                                        style: TextStyle(
                                                          fontWeight: bolFont,
                                                          fontSize: PrimaryFont,
                                                        )),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      widget
//                                                          .data
                                                          .data
                                                          .orderItems[index]
                                                          .quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight: semiFont,
                                                          fontSize: PrimaryFont,
                                                          color: littleGrey),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
//                                                 Row(
//                                                   children: <Widget>[
//                                                     Text(
//                                                       widget
// //                                                          .data
//                                                           .data
//                                                           .orderItems[index]
//                                                           .sectionPrice
//                                                           .toString(),
//                                                       style: TextStyle(
//                                                           fontWeight: semiFont,
//                                                           fontSize: MediumFont,
//                                                           color:
//                                                           Theme.of(context)
//                                                               .accentColor),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5.0,
//                                                     ),
//                                                     Text(
//                                                       AppLocalizations.of(context).translate("real_suadi_shortcut"),
//                                                       style: TextStyle(
//                                                           fontWeight: regFont,
//                                                           fontSize:
//                                                           SecondaryFont,
//                                                           color: littleGrey),
//                                                     ),
//                                                   ],
//                                                 ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).translate("Adress_str:"),
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MainFont,
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  widget.data.address,
                                  style: TextStyle(
                                      fontWeight: semiFont,
                                      fontSize: MainFont,
                                      color: littleGrey),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).translate("Deliver_Coasts_str"),
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MainFont,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "${(widget.data.delivery * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}" ,
                                        style: TextStyle(
                                            fontWeight: semiFont,
                                            fontSize: MainFont,
                                            color:
                                            Theme.of(context).accentColor),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                       locator<PrefsService>().currencyCode,
                                         // AppLocalizations.of(context).translate("real_suadi_shortcut") ,
                                        style: TextStyle(
                                            fontWeight: regFont,
                                            fontSize: SecondaryFont,
                                            color: littleGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).translate("Total Price"),
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MainFont,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "${(widget.data.total * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontWeight: semiFont,
                                            fontSize: MainFont,
                                            color:
                                            Theme.of(context).accentColor),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        locator<PrefsService>().currencyCode,
                                        // AppLocalizations.of(context).translate("real_suadi_shortcut"),
                                        style: TextStyle(
                                            fontWeight: regFont,
                                            fontSize: SecondaryFont,
                                            color: littleGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            child: const MySeparator(color: Colors.grey),
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).translate("Bounes"),
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MainFont,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                       "${(widget.data.marketerCommission * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}"
                                            ,
                                        style: TextStyle(
                                            fontWeight: semiFont,
                                            fontSize: MainFont,
                                            color:
                                            Theme.of(context).accentColor),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        locator<PrefsService>().currencyCode,
                                        // AppLocalizations.of(context).translate("real_suadi_shortcut"),
                                        style: TextStyle(
                                            fontWeight: regFont,
                                            fontSize: SecondaryFont,
                                            color: littleGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).translate("Pointes"),
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MainFont,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        widget.data.marketerPoint
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: semiFont,
                                            fontSize: MainFont,
                                            color:
                                            Theme.of(context).accentColor),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).translate("Pointes"),
                                        style: TextStyle(
                                            fontWeight: regFont,
                                            fontSize: SecondaryFont,
                                            color: littleGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    // widget.data.hasProvider == "true"?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          ListTile(
                            leading:  Container(
                              height: 50.0,
                              width: 50.0,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(3.0),
                                child: Image.network(
                                  widget.data.delegateAvatar,
                                  height: 50.0,
                                  width: 50.0,
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(

                              widget.data.delegateName,
                              style:TextStyle(
                                fontWeight: bolFont,
                                fontSize: MediumFont,
                              ),),
                            subtitle:  Row(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).translate("Order Serial :"),
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: PrimaryFont,
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  widget.data.id.toString(),
                                  //"3091",
                                  style: TextStyle(
                                      fontWeight: semiFont,
                                      fontSize: PrimaryFont,
                                      color: littleGrey),
                                )
                              ],
                            ),
//                         trailing:  ButtonTheme(
//                           height: 45.0,
//                           child: RaisedButton(
//                             color: Theme.of(context).accentColor,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: new BorderRadius.circular(10.0)),
// //                    color: Theme.of(context).primaryColor,
//                             child: Text(
//                               AppLocalizations.of(context).translate("Follow Order"),style: TextStyle(
//                               color: Colors.white,
//                               fontSize: MainFont,
//                               fontWeight: semiFont,
//                             ),
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   new MaterialPageRoute(
//                                       builder: (BuildContext context) => FollowOrder(widget.data)));
// //                              setState(() {
// //                                canceled =! canceled;
// //                              });
//                             },
//                           ),
//                         ),
                          ),
                          SizedBox(height: 10,),
                          ButtonTheme(
                            height: 45.0,
                            minWidth: double.infinity,
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0)),
//                    color: Theme.of(context).primaryColor,
                              child: Text(
                                AppLocalizations.of(context).translate("Follow Order"),style: TextStyle(
                                color: Colors.white,
                                fontSize: MainFont,
                                fontWeight: semiFont,
                              ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => FollowOrder(widget.data)));
//                              setState(() {
//                                canceled =! canceled;
//                              });
                              },
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height /10,),
                        ],
                      ),
                    ),
                        // :Container(),

                    Container(
                      child: widget.data.cancel == "true"
                          ? Text(
                        AppLocalizations.of(context).translate("Order has been canceled !"),
                        style: TextStyle(
                            fontWeight: semiFont,
                            fontSize: MediumFont,
                            color: Theme.of(context).accentColor),
                      )
                          : null,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
//                    Container(
//                      height: 25.0,
//                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




//class _ReceiptState extends State<Receipt> {
////  List<SingleModify> singleModifies = <SingleModify>[
////    SingleModify(
////        1, "Product name", "2 packetes", 100, "assets/images/product1.png", 1),
////    SingleModify(
////        2, "Product name", "2 packetes", 100, "assets/images/product1.png", 1),
////  ];
//
//  bool canceled = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 0,
//        title: Text(AppLocalizations.of(context).translate("Receipt")),
//        leading: IconButton(
//          icon: Icon(
//            Icons.arrow_back_ios,
//            size: 25.0,
//          ),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
//      ),
//      body: Stack(
//        children: <Widget>[
//          Container(
//            height: MediaQuery.of(context).size.height,
//            width: MediaQuery.of(context).size.width,
//            //     color: Colors.yellow,
//          ),
//          Container(
//            child: ClipRRect(
//              borderRadius:
//                  BorderRadius.only(bottomRight: Radius.circular(50.0)),
//              child: Container(
//                height: 100.0,
//                color: Theme.of(context).primaryColor,
//              ),
//            ),
//          ),
//          Positioned(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
//            top: 0.0,
//            child: Padding(
//              padding: const EdgeInsets.all(20.0),
//              child: SingleChildScrollView(
//                child: Wrap(
//                  children: <Widget>[
//                    Card(
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0),
//                      ),
//                      elevation: 2.0,
//                      child: Column(
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.symmetric(vertical: 15.0),
//                            child: ListView.builder(
//                              physics: ScrollPhysics(),
//                              shrinkWrap: true,
//                              itemCount: widget.data.data.orderItems.length,
//                              itemBuilder: (context, index) {
//                                return Container(
//                                  margin: EdgeInsets.only(bottom: 10.0),
//                                  child: ListTile(
//                                    title: Row(
//                                      children: <Widget>[
//                                        Flexible(
//                                          flex: 3,
//                                          child: Image.network(
//                                            widget.data.data.orderItems[index]
//                                                .sectionImage,
//                                            height: 110.0,
//                                            width: 110.0,
//                                          ),
//                                        ),
//                                        Flexible(
//                                          flex: 7,
//                                          child: Container(
//                                            padding: const EdgeInsets.all(8.0),
//                                            child: Column(
//                                              children: <Widget>[
//                                                Row(
//                                                  children: <Widget>[
//                                                    Text(
//                                                      widget
//                                                          .data
//                                                          .data
//                                                          .orderItems[index]
//                                                          .sectionTitle,
//                                                      style: TextStyle(
//                                                        fontWeight: bolFont,
//                                                        fontSize: MediumFont,
//                                                      ),
//                                                    )
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  height: 5.0,
//                                                ),
//                                                Row(
//                                                  children: <Widget>[
//                                                    Text(AppLocalizations.of(context).translate("Ordered amount :"),
//                                                        style: TextStyle(
//                                                          fontWeight: bolFont,
//                                                          fontSize: PrimaryFont,
//                                                        )),
//                                                    SizedBox(
//                                                      width: 5.0,
//                                                    ),
//                                                    Text(
//                                                      widget
//                                                          .data
//                                                          .data
//                                                          .orderItems[index]
//                                                          .quantity
//                                                          .toString(),
//                                                      style: TextStyle(
//                                                          fontWeight: semiFont,
//                                                          fontSize: PrimaryFont,
//                                                          color: littleGrey),
//                                                    )
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  height: 8.0,
//                                                ),
//                                                Row(
//                                                  children: <Widget>[
//                                                    Text(
//                                                      widget
//                                                          .data
//                                                          .data
//                                                          .orderItems[index]
//                                                          .sectionPrice
//                                                          .toString(),
//                                                      style: TextStyle(
//                                                          fontWeight: semiFont,
//                                                          fontSize: MediumFont,
//                                                          color:
//                                                              Theme.of(context)
//                                                                  .accentColor),
//                                                    ),
//                                                    SizedBox(
//                                                      width: 5.0,
//                                                    ),
//                                                    Text(
//                                                      AppLocalizations.of(context).translate("real_suadi_shortcut"),
//                                                      style: TextStyle(
//                                                          fontWeight: regFont,
//                                                          fontSize:
//                                                              SecondaryFont,
//                                                          color: littleGrey),
//                                                    ),
//                                                  ],
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                );
//                              },
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(15.0),
//                            child: Row(
//                              children: <Widget>[
//                                Text(AppLocalizations.of(context).translate("Adress_str:"),
//                                    style: TextStyle(
//                                      fontWeight: bolFont,
//                                      fontSize: MainFont,
//                                    )),
//                                SizedBox(
//                                  width: 5.0,
//                                ),
//                                Text(
//                                  widget.data.data.address,
//                                  style: TextStyle(
//                                      fontWeight: semiFont,
//                                      fontSize: MainFont,
//                                      color: littleGrey),
//                                ),
//                                SizedBox(
//                                  height: 10.0,
//                                ),
//                              ],
//                            ),
//                          ),
//                          Container(
//                            padding: EdgeInsets.all(15.0),
//                            width: MediaQuery.of(context).size.width,
//                            child: Row(
//                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Expanded(
//                                  child: Text(
//                                    AppLocalizations.of(context).translate("Deliver_Coasts_str"),
//                                    style: TextStyle(
//                                      fontWeight: bolFont,
//                                      fontSize: MainFont,
//                                    ),
//                                  ),
//                                ),
//                                Expanded(
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.end,
//                                    children: <Widget>[
//                                      Text(
//                                        widget.data.data.delivery.toString(),
//                                        style: TextStyle(
//                                            fontWeight: semiFont,
//                                            fontSize: MainFont,
//                                            color:
//                                                Theme.of(context).accentColor),
//                                      ),
//                                      SizedBox(
//                                        width: 5.0,
//                                      ),
//                                      Text(
//                                        AppLocalizations.of(context).translate("real_suadi_shortcut") ,
//                                        style: TextStyle(
//                                            fontWeight: regFont,
//                                            fontSize: SecondaryFont,
//                                            color: littleGrey),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Container(
//                            padding: EdgeInsets.all(15.0),
//                            width: MediaQuery.of(context).size.width,
//                            child: Row(
//                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Expanded(
//                                  child: Text(
//                                    AppLocalizations.of(context).translate("Total Price"),
//                                    style: TextStyle(
//                                      fontWeight: bolFont,
//                                      fontSize: MainFont,
//                                    ),
//                                  ),
//                                ),
//                                Expanded(
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.end,
//                                    children: <Widget>[
//                                      Text(
//                                        widget.data.data.total.toString(),
//                                        style: TextStyle(
//                                            fontWeight: semiFont,
//                                            fontSize: MainFont,
//                                            color:
//                                                Theme.of(context).accentColor),
//                                      ),
//                                      SizedBox(
//                                        width: 5.0,
//                                      ),
//                                      Text(
//                                        AppLocalizations.of(context).translate("real_suadi_shortcut"),
//                                        style: TextStyle(
//                                            fontWeight: regFont,
//                                            fontSize: SecondaryFont,
//                                            color: littleGrey),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          SizedBox(
//                            height: 15.0,
//                          ),
//                          Padding(
//                            child: const MySeparator(color: Colors.grey),
//                            padding: EdgeInsets.symmetric(horizontal: 20.0),
//                          ),
//                          SizedBox(
//                            height: 25.0,
//                          ),
//                          Container(
//                            padding: EdgeInsets.all(15.0),
//                            width: MediaQuery.of(context).size.width,
//                            child: Row(
//                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Expanded(
//                                  child: Text(
//                                    AppLocalizations.of(context).translate("Bounes"),
//                                    style: TextStyle(
//                                      fontWeight: bolFont,
//                                      fontSize: MainFont,
//                                    ),
//                                  ),
//                                ),
//                                Expanded(
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.end,
//                                    children: <Widget>[
//                                      Text(
//                                        widget.data.data.marketerCommission
//                                            .toString(),
//                                        style: TextStyle(
//                                            fontWeight: semiFont,
//                                            fontSize: MainFont,
//                                            color:
//                                                Theme.of(context).accentColor),
//                                      ),
//                                      SizedBox(
//                                        width: 5.0,
//                                      ),
//                                      Text(
//                                        AppLocalizations.of(context).translate("real_suadi_shortcut"),
//                                        style: TextStyle(
//                                            fontWeight: regFont,
//                                            fontSize: SecondaryFont,
//                                            color: littleGrey),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Container(
//                            padding: EdgeInsets.all(15.0),
//                            width: MediaQuery.of(context).size.width,
//                            child: Row(
//                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Expanded(
//                                  child: Text(
//                                    AppLocalizations.of(context).translate("Pointes"),
//                                    style: TextStyle(
//                                      fontWeight: bolFont,
//                                      fontSize: MainFont,
//                                    ),
//                                  ),
//                                ),
//                                Expanded(
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.end,
//                                    children: <Widget>[
//                                      Text(
//                                        widget.data.data.marketerPoint
//                                            .toString(),
//                                        style: TextStyle(
//                                            fontWeight: semiFont,
//                                            fontSize: MainFont,
//                                            color:
//                                                Theme.of(context).accentColor),
//                                      ),
//                                      SizedBox(
//                                        width: 5.0,
//                                      ),
//                                      Text(
//                                        AppLocalizations.of(context).translate("Pointes"),
//                                        style: TextStyle(
//                                            fontWeight: regFont,
//                                            fontSize: SecondaryFont,
//                                            color: littleGrey),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//
//
//                    widget.data.data.hasProvider == "true"? Container(
//                      width: MediaQuery.of(context).size.width,
//                      child: ListTile(
//                        leading:  ClipRRect(
//                          borderRadius: new BorderRadius.circular(3.0),
//                          child: Image.network(
//                            widget.data.data.delegateAvatar,
//                            height: 75.0,
//                            width: 75.0,
//                          ),
//                        ),
//                        title: Text(
//
//                          widget.data.data.delegateName,
//                          style:TextStyle(
//                            fontWeight: bolFont,
//                            fontSize: MediumFont,
//                          ),),
//                        subtitle:  Row(
//                          children: <Widget>[
//                            Text(AppLocalizations.of(context).translate("Order Serial :"),
//                                style: TextStyle(
//                                  fontWeight: bolFont,
//                                  fontSize: PrimaryFont,
//                                )),
//                            SizedBox(
//                              width: 5.0,
//                            ),
//                            Text(
//                              widget.data.data.id.toString(),
//                              //"3091",
//                              style: TextStyle(
//                                  fontWeight: semiFont,
//                                  fontSize: PrimaryFont,
//                                  color: littleGrey),
//                            )
//                          ],
//                        ),
//                        trailing:  ButtonTheme(
//                          height: 45.0,
//                          child: RaisedButton(
//                            color: Theme.of(context).accentColor,
//                            shape: RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(10.0)),
////                    color: Theme.of(context).primaryColor,
//                            child: Text(
//                              AppLocalizations.of(context).translate("Follow Order"),style: TextStyle(
//                              color: Colors.white,
//                              fontSize: MainFont,
//                              fontWeight: semiFont,
//                            ),
//                            ),
//                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (BuildContext context) => FollowOrder(widget.data.data)));
////                              setState(() {
////                                canceled =! canceled;
////                              });
//                            },
//                          ),
//                        ),
//                      ),
//                    ):Container(),
//
//                    Container(
//                      child: widget.data.data.cancel == "true"
//                          ? Text(
//                        AppLocalizations.of(context).translate("Order has been canceled !"),
//                              style: TextStyle(
//                                  fontWeight: semiFont,
//                                  fontSize: MediumFont,
//                                  color: Theme.of(context).accentColor),
//                            )
//                          : null,
//                      padding: EdgeInsets.symmetric(vertical: 15.0),
//                    ),
////                    Container(
////                      height: 25.0,
////                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}




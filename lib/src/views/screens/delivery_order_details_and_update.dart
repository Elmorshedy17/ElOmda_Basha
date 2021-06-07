import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/delivery_coasts_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/status_message_bloc.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/new_code/delivery_edit_cart/delivery_edit_cart.dart';
import 'package:medicine/src/views/screens/delivery_follow_order.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/src/views/screens/home_page.dart';
// import 'package:medicine/src/views/screens/receipt.dart';
import 'package:medicine/theme_setting.dart';

//import 'package:flutter_launch/flutter_launch.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class OrderDetailsDeliveryUpdate extends StatefulWidget {
  int id;

  OrderDetailsDeliveryUpdate(this.id);

//  var data;
//  OrderDetailsDeliveryUpdate(this.data);
  @override
  _OrderDetailsDeliveryUpdateState createState() =>
      _OrderDetailsDeliveryUpdateState();
}

class _OrderDetailsDeliveryUpdateState
    extends State<OrderDetailsDeliveryUpdate> {


  TextEditingController quantityModify = TextEditingController();

  TextEditingController statusMessage = TextEditingController();

//  List<BehaviorSubject> _quyantitySubject = new List();
  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+$phone/?text=$message";
        return "https://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        // return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
        // return "https://wa.me/$phone/?text=${Uri.parse(message)}";
        return "https://wa.me/+$phone?text=$message";

      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override

  Widget build(BuildContext context) {
    _launchURL(urlLink) async {
      var url = urlLink;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: FutureBuilder(
          future: ApiService.ShowDelegateOrder(widget.id),
          builder: (context, snapshot) {
//              for (int index = 0; index < snapshot.data.data.orderItems.length; index++) {
//                _quyantitySubject.add(new BehaviorSubject());
//              }


            List itemsDetails = [];
            itemsDetails.clear();
            if(snapshot.hasData ){
              for (int index = 0; index < snapshot.data.data.orderItems.length; index++) {
                itemsDetails.add("${snapshot.data.data.orderItems[index].sectionTitle} * ${snapshot.data.data.orderItems[index].quantity} = ${snapshot.data.data.orderItems[index].totalForCountry} ${snapshot.data.data.currencyCode}");}
            }
          return Scaffold(
            appBar: AppBar(
              title: Text( AppLocalizations.of(context).translate("Order_Details_str")),
              actions: [

                Row(
                  children: [
                    InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          height: 40,
                          width: 40,
                          child: Icon(Icons.share)),
                      onTap: () {
                        Share.share(
                            "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${snapshot.data.data.id}""\n"
                                "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${snapshot.data.data.name}""\n"
                                "${AppLocalizations.of(context).translate("Phone Number")}  ${snapshot.data.data.phone}""\n"
                                "${AppLocalizations.of(context).translate("Adress_str")}  ${snapshot.data.data.address}""\n"
                                "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                "${AppLocalizations.of(context).translate("total")} ${snapshot.data.data.totalForCountry} ${snapshot.data.data.currencyCode}");

                      },
                    ),
                    FlatButton(
                      child: Image.asset(
                        "assets/images/edit.png",
                        height: 40.0,
                        width: 40.0,
                        color: Colors.white,
                      ),
                      onPressed: () {

                        ApiService.ShowCart().then((value) {
                          if(value.key.toString() == "1"){
                            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>
                                DeliveryEditCart(value.variableRate,widget.id,snapshot.data.data)));
                          }else{
                            Fluttertoast.showToast(
                                msg: value.msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        });



                      },
                    ),
                  ],
                ),



              ],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25.0,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DeliveyHomePage(
                                  locator<UserIdBloc>().currentUserId.toString()
                                      .toString())));
                },
              ),

            ),
            body: snapshot.hasData ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0),
                            child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.orderItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: ListTile(
                                    title: Row(
                                      children: <Widget>[
                                        Flexible(
                                          flex: 3,
                                          child: Image.network(
                                            snapshot.data.data
                                                .orderItems[index]
                                                .sectionImage,
                                            height: 110.0,
                                            width: 110.0,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 7,
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                                8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[

                                                Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          snapshot.data.data
                                                              .orderItems[index]
                                                              .sectionTitle,
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
                                                        Text(
                                                            AppLocalizations.of(context).translate("Ordered amount :") ,
                                                            style: TextStyle(
                                                              fontWeight: bolFont,
                                                              fontSize: PrimaryFont,
                                                            )),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          snapshot.data.data.orderItems[index]
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
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          snapshot.data.data.orderItems[index].sectionPriceForCountry
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight: semiFont,
                                                              fontSize: MediumFont,
                                                              color: Theme
                                                                  .of(context)
                                                                  .accentColor),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          snapshot.data.data.currencyCode.toString(),
                                                          // AppLocalizations.of(context).translate("real_suadi_shortcut")  ,
                                                          style: TextStyle(
                                                              fontWeight: regFont,
                                                              fontSize: SecondaryFont,
                                                              color: littleGrey),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

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
                                  snapshot.data.data.address,
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).translate("Order Time"),
                                  style: TextStyle(
                                    fontWeight: bolFont,
                                    fontSize: MainFont,
                                  ),),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  snapshot.data.data.date.toString(),
                                  style: TextStyle(
                                      fontWeight: semiFont,
                                      fontSize: PrimaryFont,
                                      color: lightText),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 35.0,
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(15.0),
                          //   width: MediaQuery
                          //       .of(context)
                          //       .size
                          //       .width,
                          //   child: Row(
                          //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: <Widget>[
                          //       Expanded(
                          //         child: Text(AppLocalizations.of(context).translate("Deliver_Coasts_str"),
                          //           style: TextStyle(
                          //             fontWeight: bolFont,
                          //             fontSize: MainFont,
                          //           ),),
                          //       ),
                          //       Expanded(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: <Widget>[
                          //             Text(
                          //               locator<DeliveryCostaBloc>()
                          //                   .currentDeliveryCosts,
                          //               style: TextStyle(
                          //                   fontWeight: semiFont,
                          //                   fontSize: MainFont,
                          //                   color: accentColor),
                          //             ),
                          //             SizedBox(
                          //               width: 5.0,
                          //             ),
                          //             Text(
                          //               AppLocalizations.of(context).translate("real_suadi_shortcut"),
                          //               style: TextStyle(
                          //                   fontWeight: regFont,
                          //                   fontSize: SecondaryFont,
                          //                   color: littleGrey),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(AppLocalizations.of(context).translate("Tottal"),
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MainFont,
                                    ),),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.data.totalForCountry.toString(),
                                        style: TextStyle(
                                            fontWeight: semiFont,
                                            fontSize: MainFont,
                                            color: accentColor),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        snapshot.data.data.currencyCode.toString(),
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
                        ],
                      ),
                    ),
                    Container(
                      height: 15.0,
                    ),
                    Card(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context).translate("Customer_Name_:")
                                    , style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MediumFont,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(snapshot.data.data.name
                                    , style: TextStyle(
                                        fontWeight: bolFont,
                                        fontSize: MediumFont,
                                        color: lightText
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 10.0,
                            ),

                            Container(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context).translate("Phone Number")
                                    , style: TextStyle(
                                      fontWeight: semiFont,
                                      fontSize: PrimaryFont,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),

                                  InkWell(
                                    onTap: (){
                                      _launchURL("tel:+${snapshot.data.data.phone}");
                                    },
                                    child:
                                    Directionality( // add this
                                      textDirection: TextDirection.ltr,
                                      child: Text(snapshot.data.data.phone.replaceAll(new RegExp(r'[^\w\s]+'),'')
                                        , style: TextStyle(
                                            fontWeight: semiFont,
                                            fontSize: PrimaryFont,
                                            color: lightText
                                        ),
                                      ),),
                                  ),
                                  SizedBox(width: 50,),
                                  InkWell(
                                    onTap: (){
                                      // _launchURL("https://wa.me/${widget.data.data.phone}/?text=Hello");
                                      launchWhatsApp(phone: "${snapshot.data.data.phone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                                      "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${snapshot.data.data.id}""\n"
                                          "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${snapshot.data.data.name}""\n"
                                          "${AppLocalizations.of(context).translate("Phone Number")}  ${snapshot.data.data.phone}""\n"
                                          "${AppLocalizations.of(context).translate("Adress_str")}  ${snapshot.data.data.address}""\n"
                                          "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                          "${AppLocalizations.of(context).translate("total")} ${snapshot.data.data.totalForCountry} ${snapshot.data.data.currencyCode}");
                                    },
                                    child: Image.asset("assets/images/whatsapp.png",width: 20,),
                                  ),
                                ],
                              ),
                            ), Container(
                              height: 10.0,
                            ),

                            (snapshot.data.data.whatsapp != null ||snapshot.data.data.whatsapp != "") ?  Container(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context).translate("Phone Number")
                                    , style: TextStyle(
                                      fontWeight: semiFont,
                                      fontSize: PrimaryFont,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  // Directionality( // add this
                                  //   textDirection: TextDirection.ltr,
                                  //   child: Text("${widget.data.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'')}"
                                  //   , style: TextStyle(
                                  //       fontWeight: semiFont,
                                  //       fontSize: PrimaryFont,
                                  //       color: lightText
                                  //   ),
                                  // ),),


                                  InkWell(
                                    onTap: (){
                                      _launchURL("tel:+${snapshot.data.data.whatsapp}");
                                    },
                                    child:
                                    Directionality( // add this
                                      textDirection: TextDirection.ltr,
                                      child: Text(snapshot.data.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'')
                                        , style: TextStyle(
                                            fontWeight: semiFont,
                                            fontSize: PrimaryFont,
                                            color: lightText
                                        ),
                                      ),),
                                  ),
                                  SizedBox(width: 50,),
                                  InkWell(
                                    onTap: (){
                                      // _launchURL("https://wa.me/${widget.data.data.whatsapp}/?text=Hello");
                                      launchWhatsApp(phone: "${snapshot.data.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                                      "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${snapshot.data.data.id}""\n"
                                          "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${snapshot.data.data.name}""\n"
                                          "${AppLocalizations.of(context).translate("Phone Number")}  ${snapshot.data.data.phone}""\n"
                                          "${AppLocalizations.of(context).translate("Adress_str")}  ${snapshot.data.data.address}""\n"
                                          "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                          "${AppLocalizations.of(context).translate("total")} ${snapshot.data.data.totalForCountry} ${snapshot.data.data.currencyCode}");
                                    },
                                    child: Image.asset("assets/images/whatsapp.png",width: 20,),
                                  ),

                                ],
                              ),
                            ):Container(),
                          ],
                        ),
                      ),),
                    // Card(shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    //   elevation: 2.0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(15.0),
                    //     child: Wrap(
                    //       children: <Widget>[
                    //         Row(
                    //           children: <Widget>[
                    //             Text(AppLocalizations.of(context).translate("Customer_Name_:")
                    //               , style: TextStyle(
                    //                 fontWeight: bolFont,
                    //                 fontSize: MediumFont,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 5.0,
                    //             ),
                    //             Text(snapshot.data.data.name
                    //               , style: TextStyle(
                    //                   fontWeight: bolFont,
                    //                   fontSize: MediumFont,
                    //                   color: lightText
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Container(
                    //           height: 10.0,
                    //         ),
                    //
                    //         Row(
                    //           children: <Widget>[
                    //             Text(AppLocalizations.of(context).translate("Phone Number")
                    //               , style: TextStyle(
                    //                 fontWeight: semiFont,
                    //                 fontSize: PrimaryFont,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 5.0,
                    //             ),
                    //             Text(snapshot.data.data.phone
                    //               , style: TextStyle(
                    //                   fontWeight: semiFont,
                    //                   fontSize: PrimaryFont,
                    //                   color: lightText
                    //               ),
                    //             ),
                    //           ],
                    //         ), Container(
                    //           height: 10.0,
                    //         ),
                    //
                    //         Row(
                    //           children: <Widget>[
                    //             Text(AppLocalizations.of(context).translate("WhatsApp Number : ")
                    //               , style: TextStyle(
                    //                 fontWeight: semiFont,
                    //                 fontSize: PrimaryFont,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 5.0,
                    //             ),
                    //             Text(snapshot.data.data.whatsapp
                    //               , style: TextStyle(
                    //                   fontWeight: semiFont,
                    //                   fontSize: PrimaryFont,
                    //                   color: lightText
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),),

                    Container(
                      height: 15.0,
                    ),
                    Container(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: new BorderRadius.circular(50.0),
                          child: Image.network(
                            snapshot.data.data.marketerAvatar,
                            height: 70.0,
                            width: 70.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(snapshot.data.data.marketerName),
                        subtitle: InkWell(
                          onTap: (){
                            _launchURL("tel:+${snapshot.data.data.marketerPhone.toString()}");
                          },
                          child:  Text(snapshot.data.data.marketerPhone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()),
                        ),
                        trailing:
                        MaterialButton(onPressed: () {
                          launchWhatsApp(phone: "${snapshot.data.data.marketerPhone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                          "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${snapshot.data.data.id}""\n"
                              "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${snapshot.data.data.name}""\n"
                              "${AppLocalizations.of(context).translate("Phone Number")}  ${snapshot.data.data.phone}""\n"
                              "${AppLocalizations.of(context).translate("Adress_str")}  ${snapshot.data.data.address}""\n"
                              "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                              "${AppLocalizations.of(context).translate("total")} ${snapshot.data.data.totalForCountry} ${snapshot.data.data.currencyCode}");
                          // FlutterOpenWhatsapp.sendSingleMessage(
                          //     "${snapshot.data.data.marketerPhone}", "Hello");
                        },
                          child: Image.asset("assets/images/whatsapp.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.fill,),
                        ),

                        //
                      ),
                    ),

                    Container(
                      height: 35.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ButtonTheme(
                              height: 60.0,
                              child: RaisedButton(
                                  color: accentColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          15.0)),
//                    color: Theme.of(context).primaryColor,
                                  child:
                                  Text(
                                    AppLocalizations.of(context).translate("Delivery Steps"),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MainFont,
                                      fontWeight: semiFont,
                                    ),
                                  ),
                                  onPressed: () {
                                    ApiService.ShowDelegateOrder(
                                        snapshot.data.data.id).then((onValue) {
                                      if (onValue.key.toString() == "1") {
                                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>
                                            DelivereyFollowOrder(snapshot.data,onValue)));
                                      } else {
                                        showDialog(context: context, builder: (BuildContext context) {
                                          return AlertDialog(title: Text(onValue.msg),);});}
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),

                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ButtonTheme(
                              height: 60.0,
                              child: RaisedButton(
                                  color: accentColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          15.0)),
//                    color: Theme.of(context).primaryColor,
                                  child:
                                  Text(
                                    AppLocalizations.of(context).translate("Cancel Order"),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MainFont,
                                      fontWeight: semiFont,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext context) {
                                        return AlertDialog(
                                          title: Column(
                                            children: <Widget>[
                                              Text(
                                                  AppLocalizations.of(context).translate("Do you want cancel Order ?") ),
                                              Container(
                                                height: 25.0,
                                              ),
                                              TextField(
                                                controller:
                                                statusMessage,
                                                maxLines: 3,
                                                decoration:
                                                InputDecoration(
                                                    errorText:
                                                    snapshot
                                                        .error,
                                                    hintText:
                                                    AppLocalizations.of(context).translate("Reason of Cancelation")
                                                    ,
                                                    labelText:
                                                    AppLocalizations.of(context).translate("Reason of Cancelation"),
                                                    //errorText: snapshot.error,
                                                    border:
                                                    OutlineInputBorder()),
                                              ),
                                              Container(
                                                height: 25.0,
                                              ),
                                              ButtonTheme(
                                                height: 60.0,
                                                minWidth: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                child: RaisedButton(
                                                    color: accentColor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius
                                                            .circular(15.0)),
                                                    child: Text(

                                                      AppLocalizations.of(context).translate("con_send_str"),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MainFont,
                                                        fontWeight: semiFont,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      locator<StatusMessageBloc>().statusSink.add("cancel");
                                                      ApiService
                                                          .ChangeOrderStatus(
                                                          snapshot.data.data.id,
                                                          statusMessage.text)
                                                          .then((onValue) {
                                                        if (onValue.key ==
                                                            "1") {
                                                          Navigator
                                                              .pushReplacement(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (
                                                                      BuildContext
                                                                      context) =>
                                                                      DeliveyHomePage(
                                                                          locator<
                                                                              UserIdBloc>()
                                                                              .currentUserId
                                                                              .toString()
                                                                              .toString())));
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder: (
                                                                BuildContext
                                                                context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    onValue
                                                                        .massage),
                                                              );
                                                            },
                                                          );
                                                        }
                                                      });
                                                    }),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );


//                                      locator<StatusMessageBloc>().statusSink.add("cancel");
//                                      ApiService.ChangeOrderStatus(
//                                          snapshot.data.data.id,"")
//                                          .then((onValue) {
//                                        if (onValue.key == "1") {
//                                          Navigator.pushReplacement(
//                                              context,
//                                              new MaterialPageRoute(
//                                                  builder: (BuildContext context) =>
//                                                      DeliveyHomePage(locator<UserIdBloc>().currentUserId.toString().toString())                                                        ));
//                                        } else {
//                                          showDialog(
//                                            context: context,
//                                            builder: (BuildContext context) {
//                                              return AlertDialog(
//                                                title: Text(onValue.massage),
//                                              );
//                                            },
//                                          );
//                                        }
//                                      });
//
                                  }
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ) : Container(child: Center(
              child: CircularProgressIndicator(),
            ),),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    statusMessage.dispose();
    super.dispose();
  }
}


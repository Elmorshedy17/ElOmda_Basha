import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/theme_setting.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class FollowOrder extends StatefulWidget {
  var data;

  FollowOrder(this.data);

  @override
  _FollowOrderState createState() => _FollowOrderState();
}

class _FollowOrderState extends State<FollowOrder> {
  List hasProvider = [];
  List inWay = [];
  List done = [];

  String orderItems  ;

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

  void launchWhatsGroupApp(
      {@required String link,}) async {
    String url() {
      return "$link";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {




    print("xXxXx${widget.data.phone}");
    for (int index = 0; index < widget.data.orderStatus.length; index++) {
      if (widget.data.orderStatus[index].status == "has_provider") {
        hasProvider.add(widget.data.orderStatus[index].message);
      }
      if (widget.data.orderStatus[index].status == "in_way") {
        inWay.add(widget.data.orderStatus[index].message);
      }
    }
    print("hasProviderhasProviderhasProvider ${hasProvider}");
    print("hasProviderhasProviderhasProvider ${inWay}");
    _launchURL(urlLink) async {
      var url = urlLink;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }


    List itemsDetails = [];
    itemsDetails.clear();
    for (int index = 0; index < widget.data.orderItems.length; index++) {
      itemsDetails.add("${widget.data.orderItems[index].sectionTitle} * ${widget.data.orderItems[index].quantity} = ${(widget.data.orderItems[index].total * double.parse(locator<PrefsService>().rateToSar.toString()))}");
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("Follow Order")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Row(
            children: [
              Container(
                width: 15,
              ),
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
                      "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.id}""\n"
                          "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.name}""\n"
                          "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.phoneWithoutCode == "" ? widget.data.phone : widget.data.phoneWithoutCode}""\n"
                          "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.address}""\n"
                          "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                          "${AppLocalizations.of(context).translate("total")} ${(widget.data.total * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)} ${locator<PrefsService>().currencyCode}""\n"
                          "${AppLocalizations.of(context).translate("notes_Str")}  ${widget.data.notes}");

                },
              ),
              Container(
                width: 15,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Opacity(
                    opacity: widget.data.hasProvider == "true" ? 1.0 : 0.5,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: Image.asset(
                                "assets/images/checked.png",
                                height: 30.0,
                                width: 30.0,
                              )),
                          Flexible(
                            flex: 9,
                            child: Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                    leading: Image.asset(
                                      "assets/images/Import.png",
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context).translate(
                                              "Order Recived , In Progress"),
                                          style: TextStyle(
                                              fontSize: MediumFont,
                                              fontWeight: bolFont),
                                        ),
//                                    Text("11:0 am",style: TextStyle(
//                                        fontSize: PrimaryFont,
//                                        fontWeight: semiFont,
//                                      color: lightText
//                                    )),
                                      ],
                                    ),
                                    subtitle: Container(
                                      height: 100.0,
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return Divider();
                                          },
                                          shrinkWrap: true,
                                          itemCount: hasProvider.length,
                                          itemBuilder: (context, i) {
                                            return
                                              Container(
//                                                padding: EdgeInsets.only(bottom: 8.0),
                                                child: Text(
                                                    hasProvider[i],
                                                    style: TextStyle(
                                                        fontSize: PrimaryFont,
                                                        fontWeight: bolFont,
                                                        height: 1.3,
                                                        color: lightText
                                                    )),
                                              );
                                          }),
                                    ),

//                                Text(
//                                    "It is a long established fact that a reader will be distracted by the readable content of a page ",
//                                    style: TextStyle(
//                                    fontSize: PrimaryFont,
//                                    fontWeight: bolFont,
//                                  color: lightText
//                                )),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Opacity(
                    opacity: widget.data.inWay == "true" ? 1.0 : 0.5,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: Image.asset(
                                "assets/images/checked.png",
                                height: 30.0,
                                width: 30.0,
                              )),
                          Flexible(
                            flex: 9,
                            child: Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.asset(
                                    "assets/images/shipped.png",
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "On The Way",
                                        style: TextStyle(
                                            fontSize: MediumFont,
                                            fontWeight: bolFont),
                                      ),
//                                    Text("11:0 am",style: TextStyle(
//                                        fontSize: PrimaryFont,
//                                        fontWeight: semiFont,
//                                      color: lightText
//                                    )),
                                    ],
                                  ),
                                  subtitle: Container(
                                    height: 100.0,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        },
                                        shrinkWrap: true,
                                        itemCount: inWay.length,
                                        itemBuilder: (context, ida) {
                                          return
                                            Container(
//                                                padding: EdgeInsets.only(bottom: 8.0),
                                              child: Text(
                                                  inWay[ida],
                                                  style: TextStyle(
                                                      fontSize: PrimaryFont,
                                                      fontWeight: bolFont,
                                                      height: 1.3,
                                                      color: lightText
                                                  )),
                                            );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Opacity(
                    opacity: widget.data.finish == "true" ? 1.0 : 0.5,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: Image.asset(
                                "assets/images/checked.png",
                                height: 30.0,
                                width: 30.0,
                              )),
                          Flexible(
                            flex: 9,
                            child: Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.asset(
                                    "assets/images/done.png",
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context).translate("Order_Done_str") ,
                                        style: TextStyle(
                                            fontSize: MediumFont,
                                            fontWeight: bolFont),
                                      ),
//                                    Text("11:0 am", style: TextStyle(
//                                        fontSize: PrimaryFont,
//                                        fontWeight: semiFont,
//                                        color: lightText
//                                    )),
                                    ],
                                  ),
                                  subtitle: Text(
                                      AppLocalizations.of(context).translate("Order_has_been_delivered"),
                                      style: TextStyle(
                                          fontSize: PrimaryFont,
                                          fontWeight: bolFont,
                                          color: lightText)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                  Card(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(
                        children: <Widget>[
                          Container(
                            height: 30,
                            child:   ListView(
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
                                Text(widget.data.name
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
                            child:  ListView(
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
                                    _launchURL("tel:+${widget.data.phone}");
                                  },
                                  child:
                                  Directionality( // add this
                                    textDirection: TextDirection.ltr,
                                    child: Text(widget.data.phone.replaceAll(new RegExp(r'[^\w\s]+'),'')
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
                                    launchWhatsApp(phone: "${widget.data.phone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                                    "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.id}""\n"
                                        "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.name}""\n"
                                        "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.phoneWithoutCode == "" ? widget.data.phone : widget.data.phoneWithoutCode}""\n"
                                        "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.address}""\n"
                                        "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                        "${AppLocalizations.of(context).translate("total")}  ${(widget.data.total * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)} ${locator<PrefsService>().currencyCode}""\n"
                                        "${AppLocalizations.of(context).translate("notes_Str")}  ${widget.data.notes}");
                                  },
                                  child: Image.asset("assets/images/whatsapp.png",width: 20,),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10.0,
                          ),

                          (widget.data.whatsapp != null ||widget.data.whatsapp != "") ?
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
                                    _launchURL("tel:+${widget.data.whatsapp}");
                                  },
                                  child:
                                  Directionality( // add this
                                    textDirection: TextDirection.ltr,
                                    child: Text(widget.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'')
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
                                    launchWhatsApp(phone: "${widget.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                                    "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.id}""\n"
                                        "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.name}""\n"
                                        "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.phoneWithoutCode == "" ? widget.data.phone : widget.data.phoneWithoutCode}""\n"
                                        "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.address}""\n"
                                        "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                        "${AppLocalizations.of(context).translate("total")}  ${(widget.data.total * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)} ${locator<PrefsService>().currencyCode}""\n"
                                        "${AppLocalizations.of(context).translate("notes_Str")}  ${widget.data.notes}");
                                  },
                                  child: Image.asset("assets/images/whatsapp.png",width: 20,),
                                ),

                              ],
                            ),
                          ):Container(),
                        ],
                      ),
                    ),),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        // color: Colors.red,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius:
                            new BorderRadius.circular(50.0),
                            child: Image.network(
                              widget.data.delegateAvatar,
                              height: 70.0,
                              width: 70.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Text(widget.data.delegateName),
                          subtitle: InkWell(
                              onTap: (){
                                _launchURL("tel:+${widget.data.delegatePhone}");
                              },
                              child: Text(widget.data.delegatePhone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString())),
                          trailing: MaterialButton(
                            onPressed: ()  {
                              print("widget.data.delegateWhatsappLink${widget.data.delegateWhatsappLink}");
                              if(widget.data.delegateWhatsappLink == ""){
                                launchWhatsApp(phone: "${widget.data.delegatePhone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                                "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.id}""\n"
                                    "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.name}""\n"
                                    "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.phoneWithoutCode == "" ? widget.data.phone : widget.data.phoneWithoutCode}""\n"
                                    "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.address}""\n"
                                    "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                    "${AppLocalizations.of(context).translate("total")}  ${(widget.data.total * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)} ${locator<PrefsService>().currencyCode}""\n"
                                    "${AppLocalizations.of(context).translate("notes_Str")}  ${widget.data.notes}");

                              }else{
                                Clipboard.setData(ClipboardData(text:
                                "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.id}""\n"
                                    "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.name}""\n"
                                    "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.phoneWithoutCode == "" ? widget.data.phone : widget.data.phoneWithoutCode}""\n"
                                    "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.address}""\n"
                                    "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                    "${AppLocalizations.of(context).translate("total")}  ${(widget.data.total * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)} ${locator<PrefsService>().currencyCode}""\n"
                                    "${AppLocalizations.of(context).translate("notes_Str")}  ${widget.data.notes}"
                                ));

                                launchWhatsGroupApp(link: widget.data.delegateWhatsappLink);
                              }

                            },
                            child: Image.asset(
                              "assets/images/whatsapp.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),

                          //
                        ),
                      ),
                    ],
                  ),
                ),
                widget.data.cancel == "true"? Container(
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("Order has been canceled")
                        ,
                        style: TextStyle(
                            color: accentColor
                        ),
                      ),
                      widget.data.message != "" ? Text(
                        "${AppLocalizations.of(context).translate('cancel_message')} : ${widget.data.message}",
                        style: TextStyle(
                            color: accentColor
                        ),
                      ):Container(),
                    ],
                  ),
                ):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

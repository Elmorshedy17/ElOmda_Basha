import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/currenct_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/models/delivery_models/show_delegate_order.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/src/views/widgets/shimmer_placeholders.dart';
import 'package:medicine/theme_setting.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rxdart/rxdart.dart';


List all = [];

class DeliveryEditCart extends StatefulWidget {
  final varuableDiscountRate;
  final orderID;
  var data;
  DeliveryEditCart(this.varuableDiscountRate,this.orderID
      , this.data
      );

  @override
  _DeliveryEditCartState createState() => _DeliveryEditCartState();
}

class _DeliveryEditCartState extends State<DeliveryEditCart> {
  @override
  Widget build(BuildContext context) {
    List<List> singleAll = new List();

all.clear();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( AppLocalizations.of(context).translate("update_button_str")),
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
          future: ApiService.ShowServices(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ? Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60,right: 10,left: 10,top: 10),
                child: ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (BuildContext context, int index){
                      singleAll.add(new List<String>());

                      return SingleItem(snapshot.data.data[index],widget.varuableDiscountRate,singleAll[index]);
                    }
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: InkWell(
                    onTap: (){


                      List how = [];
                      singleAll.forEach((element) {
                        how.addAll(element);
                      });
                      if(how.isEmpty){
                        Fluttertoast.showToast(
                            msg: locator<PrefsService>().appLanguage == "en"?"update order first":"حدث الطلب اولا",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{

                      //   "country_id":"$countryId",
                      // "city_id":"$cityId",
                      // "name":"$name",
                      // "phone":"$phone",
                      // "whatsapp":"$whatsapp",
                      // "email":"$email",
                      // "address": "$address",
                      // "total":"$total",

                        locator<IsLoadingManager>().isLoading.add(true);
                        ApiService.DeliveryUpdateOrder(
                            widget.orderID,
                            how,
                            widget.data.countryId,
                            widget.data.cityId,
                            widget.data.name,
                            widget.data.phone,
                            widget.data.whatsapp,
                            // "",
                            widget.data.address,
                            widget.data.total
                        ).then((onValue){
                          locator<IsLoadingManager>().isLoading.add(false);

                          if(onValue.key == "1"){
                            Fluttertoast.showToast(
                                msg: onValue.msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DeliveyHomePage(
                                            locator<UserIdBloc>().currentUserId.toString()
                                                .toString())));




                          }else{
                            Fluttertoast.showToast(
                                msg: onValue.msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        });
                      }



                      // singleAll.addAll(singleAll);

                      print("alloop${how}");
                    },
                    child: Container(
                      child: Center(child: Text(locator<PrefsService>().appLanguage == "en"?"Update":"تحديث",style: TextStyle(color: Colors.white,fontSize: 18),)),
                      height: 55,
                      color: Colors.redAccent,
                    ),
                  ))
            ],
          ):HomePageItemShimmer();
        }
      ),
    );
  }
}


class SingleItem extends StatefulWidget {
  final singleAll;
  final data;
  final varuableDiscountRate;
  SingleItem(this.data,this.varuableDiscountRate,this.singleAll);

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  @override
  int quantity = 0;

  Widget build(BuildContext context) {
    int total = 0 ;
    final quantityController = PublishSubject();
    final changePrice = BehaviorSubject();


    // List singleAll = [];


    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      quantityController.close();
      changePrice.close();
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: StreamBuilder(
          initialData: 0,
          stream: changePrice.stream,
          builder: (context, changePriceSnapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              initialData: 0,
              stream: quantityController.stream,
              builder: (context, updatedCountSnapshot) {
                total = (widget.data.totalForCountry * quantity) + changePriceSnapshot.data;
                // all.add(SingleItemService(widget.data.id,updatedCountSnapshot.data,total));




                Map<String, dynamic> items = {'section_id':"${widget.data.id}",'count':"${quantity}",'total':"$total"};



                List example = [
                  widget.data.id,
                  quantity,
                  total
                ];

               // var items = {};
               //
               //  items["section_id"] = "${widget.data.id}";
               //  items["count"] = "${updatedCountSnapshot.data}";
               //  items["total"] = "$total";




if(quantity > 0){
  widget.singleAll.clear();
  widget.singleAll.add("${jsonEncode(items)}");
}else if(quantity == 0 ){
  widget.singleAll.clear();

}



                // singleAll.clear();
                // singleAll.add(items);
                // all.addAll(singleAll);
                // all.clear();
                // // singleAll.add(items);
                // all.add(items);
                // if(items[0] == all[0] ){
                //   print("yayayaya");
                // }else{
                //   print("yayayayanonono");
                //
                // }




         print("${jsonEncode(items)}items[0]");

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: (){
                                print("widget.singleAll${widget.singleAll}");
                              },
                              child: Image.network(
                                widget.data.image,
                                height: 110.0,
                                width: 110.0,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              children: [
                                Text(
                                  "${widget.data.totalForCountry} ",
                                  // "${widget.data.totalForCountry} ${AppLocalizations.of(context).translate("real_suadi_shortcut")}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: PrimaryFont,
                                      fontWeight: semiFont),
                                ),
                                Text(
                                  "${locator<CurrencyBloc>().CurrencySubject.value}",
                                  // "${widget.data.totalForCountry} ${AppLocalizations.of(context).translate("real_suadi_shortcut")}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: semiFont),
                                ),

                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.data.title,
                                  style: TextStyle(
                                    // color: Colors.white,
                                      fontSize: PrimaryFont,
                                      fontWeight: semiFont),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  widget.data.desc,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: SecondaryFont,
                                      fontWeight: semiFont),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],



                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: (){
                                  changePrice.add(0);

                                  setState(() {
                                    quantity ++;
                                  });
                                  // total = widget.data.price * quantity;
                                },
                                child: Text("+",style: TextStyle(fontSize: 28,color: Colors.blueAccent),),
                              ),
                              SizedBox(width: 15,),
                              Text("$quantity",style: TextStyle(fontSize: 21),),
                              SizedBox(width: 15,),

                              InkWell(
                                onTap: (){
                                  if(!quantity.isNegative){
                                    changePrice.add(0);
                                    setState(() {
                                      quantity --;
                                    });


                                  }else{
                                    setState(() {
                                      quantity = 0;
                                    });
                                    // setState(() {
                                    //
                                    // });
                                  }

                                },
                                child: Text("-",style: TextStyle(fontSize: 35,color: Colors.redAccent),),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            Text(
                              "$total",
                              // "$total ${AppLocalizations.of(context).translate("real_suadi_shortcut")}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: MainFont,
                                  fontWeight: semiFont),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "${locator<CurrencyBloc>().CurrencySubject.value}",
                                // "$total ${AppLocalizations.of(context).translate("real_suadi_shortcut")}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: semiFont),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),

                    ExpansionTile(
                      title: Text(AppLocalizations.of(context).translate("Price_Modify_str"),
                        style: TextStyle(
                          fontSize: PrimaryFont,
                          fontWeight: semiFont,
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    quantity > 0
                                        ? Container(
                                        height: 100,
                                        child: new NumberPicker.integer(
                                            initialValue: 0,
                                            minValue: -(((quantity * widget.data.totalForCountry) * widget.varuableDiscountRate) / 100).round(),
                                            maxValue: (((quantity * widget.data.totalForCountry) * widget.varuableDiscountRate) / 100).round(),
                                            onChanged: (newValue) {
                                              changePrice.add(newValue);
                                              // print("tottalDiscount $tottalDiscount");
                                            }))
                                        : Container(),
                                    Container(
                                      width: 90,
                                      height: 35,
                                      margin: const EdgeInsets.all(15.0),
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                      child: Center(child: new Text(" ${changePriceSnapshot.data}")),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
//                                          AppLocalizations.of(context).translate("*_You_can_modfy_the_price_10%_as_max_str")  ,
                                  locator<PrefsService>().appLanguage == "en"
                                      ? "You can modfy the price ${widget.varuableDiscountRate} % as max"
                                      : "يمكنك تعديل السعر بحد اقصي ${widget.varuableDiscountRate} %",
                                  style: TextStyle(
                                      fontWeight: regFont,
                                      fontSize: PrimaryFont,
                                      color: Theme.of(context).accentColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                );
              }
            ),
          );
        }
      ),
    );
  }
}


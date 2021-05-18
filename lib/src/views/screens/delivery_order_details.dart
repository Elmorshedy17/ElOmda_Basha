import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/delivery_coasts_bloc.dart';
import 'package:medicine/src/blocs/delivery_order_update_details_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/views/screens/delivery_order_details_and_update.dart';
import 'package:medicine/src/views/screens/follow_order.dart';
import 'package:medicine/theme_setting.dart';

class DeliveryOrderDetails extends StatefulWidget {
  var data;

  DeliveryOrderDetails(this.data);

  @override
  _DeliveryOrderDetailsState createState() => _DeliveryOrderDetailsState();
}

class _DeliveryOrderDetailsState extends State<DeliveryOrderDetails> {
  TextEditingController message = new TextEditingController();
  bool canceled = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate("Order_Details_str") ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
            ),
            onPressed: () {
              locator<DeliveryCostaBloc>().deliveryCostsSink.add(AppLocalizations.of(context).translate("Deliver_Coasts_str"));
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
              height: MediaQuery.of(context).size.height - 75,
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
                                                        widget
                                                            .data
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
                                                          AppLocalizations.of(context).translate("Ordered_amount_str:"),
                                                          style: TextStyle(
                                                            fontWeight: bolFont,
                                                            fontSize: PrimaryFont,
                                                          )),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        widget
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
                                                  // Row(
                                                  //   children: <Widget>[
                                                  //     Text(
                                                  //       widget
                                                  //           .data
                                                  //           .orderItems[index]
                                                  //           .sectionPrice
                                                  //           .toString(),
                                                  //       style: TextStyle(
                                                  //           fontWeight: semiFont,
                                                  //           fontSize: MediumFont,
                                                  //           color:
                                                  //           accentColor),
                                                  //     ),
                                                  //     SizedBox(
                                                  //       width: 5.0,
                                                  //     ),
                                                  //     Text(
                                                  //       AppLocalizations.of(context).translate("real_suadi"),
                                                  //
                                                  //
                                                  //       style: TextStyle(
                                                  //           fontWeight: regFont,
                                                  //           fontSize:
                                                  //               SecondaryFont,
                                                  //           color: littleGrey),
                                                  //     ),
                                                  //   ],
                                                  // ),
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
                            // Padding(
                            //   padding: const EdgeInsets.all(15.0),
                            //   child: Row(
                            //     children: <Widget>[
                            //       Text(
                            //           AppLocalizations.of(context).translate("Adress_str"),
                            //
                            //           style: TextStyle(
                            //             fontWeight: bolFont,
                            //             fontSize: MainFont,
                            //           )),
                            //       SizedBox(
                            //         width: 5.0,
                            //       ),
                            //       Text(
                            //         widget.data.address,
                            //         style: TextStyle(
                            //             fontWeight: semiFont,
                            //             fontSize: MainFont,
                            //             color: littleGrey),
                            //       ),
                            //       SizedBox(
                            //         height: 10.0,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      AppLocalizations.of(context).translate("Order_Time_str:"),

                                      style: TextStyle(
                                        fontWeight: bolFont,
                                        fontSize: MainFont,
                                      )),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    widget.data.date,
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
                                    child:
                                    Text(
                                      AppLocalizations.of(context).translate("Tottal"),


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
                                          widget.data.total.toString(),
                                          style: TextStyle(
                                              fontWeight: semiFont,
                                              fontSize: MainFont,
                                              color:
                                              accentColor),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          AppLocalizations.of(context).translate("real_suadi_shortcut"),


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

                            widget.data.notes != "" ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context).translate("notes_Str")} :",
                                    style: TextStyle(
                                      fontWeight: bolFont,
                                      fontSize: MainFont,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text("${widget.data.notes}"))
                                ],
                              ),
                            ):Container(),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),

//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
//                         child: Row(
//                           children: <Widget>[
//                             FutureBuilder(
//                                 future: ApiService.ShowDelegateOrder(widget.data.id),
//                                 builder: (context, snapshot) {
//                                   locator<DliveryUpdateDetailsBloc>()
//                                   .DliveryUpdateDetailsSink.add(snapshot.data);
//
//                                   var dliveryCoasts = [];
//
//                                   if (snapshot.hasData) {
//                                     for (int index = 0;
//                                         index < snapshot.data.deliverys.length;
//                                         index++) {
//                                       dliveryCoasts
//                                           .add(snapshot.data.deliverys[index]);
//                                     }
//                                   } else {
//                                     var dliveryCoasts = ["0"];
//                                   }
//                                   return Expanded(
//                                     child: InkWell(
//                                         onTap: () {
//                                           showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               // return object of type Dialog
//                                               return AlertDialog(
//                                                 content: Container(
//                                                   height: MediaQuery.of(context).size.height,
//                                                   width: MediaQuery.of(context).size.width,
//                                                   child: Scrollbar(
//                                                     child: GridView.builder(
//                                                         shrinkWrap: true,
//                                                         itemCount:
//                                                             dliveryCoasts.length,
//                                                         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                                                             crossAxisCount: 2,
//                                                             childAspectRatio: MediaQuery.of(context).size.width /
//                                                                 (MediaQuery.of(context).size.height / 4)),
//                                                         itemBuilder:
//                                                             (BuildContext context,
//                                                                 int index) {
//                                                           return InkWell(
//                                                             onTap: () {
//                                                               locator<DeliveryCostaBloc>().deliveryCostsSink.add(snapshot.data.deliverys[index]);
// //                                                            Navigator.of(context);
// //                                                            Navigator.of(context);
//                                                               Navigator.pop(context);
//
//                                                             },
//                                                             child: Center(
//                                                                 child: Text(dliveryCoasts[index],
//                                                               textAlign: TextAlign.center,
//                                                             )),
//                                                           );
//                                                         }),
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         },
//                                         child: Container(
//                                           height: 60.0,
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 10.0),
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5.0),
//                                             border: Border.all(
//                                                 color: Colors.grey,
//                                                 style: BorderStyle.solid,
//                                                 width: 0.80),
//                                           ),
//                                           child: Center(
//                                               child: StreamBuilder(
//                                                   initialData:AppLocalizations.of(context).translate("Deliver_Coasts_str"),
//                                                   stream: locator<DeliveryCostaBloc>().deliveryCostsApiStream$,
//                                                   builder: (context, snapshot) {
//                                                     return Text(snapshot.data);
//                                                   })),
//                                         )),
//                                   );
//                                 }),
//                             SizedBox(
//                               width: 5.0,
//                             ),
//                           ],
//                         ),
//                       ),
                    Container(
                      height: 25,
                    ),

                      TextField(
                        maxLines: 3,
                        controller: message,
                        keyboardType: TextInputType.number,
                        //  onChanged: signupBloc.changeName,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate("your_Message_str"),
                            labelText: AppLocalizations.of(context).translate("your_Message_str"),
                            //errorText: snapshot.error,
                            border: OutlineInputBorder()),
                      ),

                    Container(
                      height: 25,
                    ),


                      ButtonTheme(
                        height: 60.0,
                        minWidth: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                          child: Text(
                            AppLocalizations.of(context).translate("Deliver_str"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MainFont,
                              fontWeight: semiFont,
                            ),
                          ),

onPressed: (){

  locator<IsLoadingManager>().isLoading.add(true);

  ApiService.AgreeChangeOrderStatus(
    widget.data.id,
    message.text
  ).then((value) {
    locator<IsLoadingManager>().isLoading.add(false);

    Fluttertoast.showToast(
        msg: value.massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    if(value.key == "1"){

      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) => OrderDetailsDeliveryUpdate(widget.data.id)));
    }
  });

},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void dispose() {
    message.dispose();
    super.dispose();
  }
}

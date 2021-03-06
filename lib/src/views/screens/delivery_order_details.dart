import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/delivery_coasts_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/views/screens/delivery_order_details_and_update.dart';
import 'package:medicine/theme_setting.dart';




class DeliveryOrderDetails extends StatefulWidget {
final  data;

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
          title: Text(AppLocalizations.of(context).translate("Order_Details_str")),
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
                                          widget.data.totalForCountry.toString(),
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
                                          widget.data.currencyCode.toString(),
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
                              widget.data.status == "new" ?  AppLocalizations.of(context).translate("Deliver_str"): AppLocalizations.of(context).translate("Details"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MainFont,
                              fontWeight: semiFont,
                            ),
                          ),

onPressed: (){



                            if(widget.data.status == "new"){
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
                            }else{
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (BuildContext context) => OrderDetailsDeliveryUpdate(widget.data.id)));

                            }




},
                        ),
                      ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)* 1.5),
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

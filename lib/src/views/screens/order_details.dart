import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/src/models/super_visor_marketers/store_order_model.dart';
import 'package:medicine/src/views/screens/receipt.dart';
import 'package:medicine/theme_setting.dart';

class OrderDetails extends StatefulWidget {
 final StoreOrderModel data;
 OrderDetails(this.data);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
//  List<SingleModify> singleModifies = <SingleModify>[
//    SingleModify(
//        1, "Product name", "2 packetes", 100, "assets/images/product1.png", 1),
//    SingleModify(
//        2, "Product name", "2 packetes", 100, "assets/images/product1.png", 1),
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Order_Details_str")),
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
      body: Padding(
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
                        itemCount: widget.data.data.orderItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 3,
                                    child: Image.network(
                                      widget.data.data.orderItems[index].sectionImage,
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
                                                widget.data.data.orderItems[index].sectionTitle,
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
                                                widget.data.data.orderItems[index].quantity.toString(),
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
                                          //       widget.data.data.orderItems[index].sectionPrice.toString(),
                                          //       style: TextStyle(
                                          //           fontWeight: semiFont,
                                          //           fontSize: MediumFont,
                                          //           color: Theme.of(context)
                                          //               .accentColor),
                                          //     ),
                                          //     SizedBox(
                                          //       width: 5.0,
                                          //     ),
                                          //     Text(
                                          //       AppLocalizations.of(context).translate("real_suadi_shortcut"),
                                          //       style: TextStyle(
                                          //           fontWeight: regFont,
                                          //           fontSize: SecondaryFont,
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
                            widget.data.data.address,
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
                            child: Text(AppLocalizations.of(context).translate("Total Price"),
                              style: TextStyle(
                                  fontWeight: bolFont,
                                  fontSize: MainFont,
                                 ),),
                          ),
                          Expanded(
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                            widget.data.data.total.toString(),
                                  style: TextStyle(
                                    fontWeight: semiFont,
                                    fontSize: MainFont,
                                    color: Theme.of(context)
                                        .accentColor),
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
                    Container(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(AppLocalizations.of(context).translate("Bounes"),
                              style: TextStyle(
                                  fontWeight: bolFont,
                                  fontSize: MainFont,
                                 ),),
                          ),
                          Expanded(
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                            widget.data.data.marketerCommission.toString()       ,
                                  style: TextStyle(
                                    fontWeight: semiFont,
                                    fontSize: MainFont,
                                    color: Theme.of(context)
                                        .accentColor),
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
                    Container(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(AppLocalizations.of(context).translate("Pointes"),
                              style: TextStyle(
                                  fontWeight: bolFont,
                                  fontSize: MainFont,
                                 ),),
                          ),
                          Expanded(
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  widget.data.data.marketerPoint.toString()       ,
                                  style: TextStyle(
                                    fontWeight: semiFont,
                                    fontSize: MainFont,
                                    color: Theme.of(context)
                                        .accentColor),
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
                  ],
                ),
              ),
              Container(
                height: 35.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ButtonTheme(
                  height: 60.0,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                    child:
                    Text(
                      AppLocalizations.of(context).translate("Receipt"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MainFont,
                        fontWeight: semiFont,
                      ),
                    ),
                    onPressed: (){
//                      print( widget.data.data[0]);

                    print("hehehehe0${widget.data.data.orderItems.length}");

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Receipt(widget.data.data)));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class SingleModify {
//  final int id;
//  final String name;
//  final String desc;
//  final int price;
//  final String imgUrl;
//  int count;
//
//  SingleModify(
//      this.id, this.name, this.desc, this.price, this.imgUrl, this.count);
//}

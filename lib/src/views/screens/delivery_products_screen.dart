import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/delivery_orders_list.dart';
import 'package:medicine/src/blocs/filter_screen_bloc.dart';
import 'package:medicine/src/blocs/home_page_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/models/super_visor_marketers/home_model.dart';
import 'package:medicine/src/views/screens/filtered_screen.dart';
import 'package:medicine/src/views/screens/my_orders.dart';
import 'package:medicine/src/views/screens/notifications.dart';
import 'package:medicine/src/views/screens/single_product.dart';
import 'package:medicine/src/views/widgets/drawer.dart';
import 'package:medicine/src/views/widgets/shimmer_placeholders.dart';
import 'package:medicine/theme_setting.dart';
import 'package:shimmer/shimmer.dart';

class DeliveryProductsScreen extends StatefulWidget {
  var UserId;

  DeliveryProductsScreen(this.UserId);

  @override
  _DeliveryProductsScreenState createState() => _DeliveryProductsScreenState();
}

class _DeliveryProductsScreenState extends State<DeliveryProductsScreen> {
  bool _isSwitch = false;
  TextEditingController countController = TextEditingController();
  int indexo;
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //     color: Colors.yellow,
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 80.0,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            AppLocalizations.of(context).translate("My_Products") ,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MainFont,
                                fontWeight: bolFont),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              AppLocalizations.of(context).translate("Order_str") ,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: PrimaryFont,
                                  fontWeight: semiFont),
                            ),
                            onPressed: () {
                              setState(() {
                                _isSwitch = !_isSwitch;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 70.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              width: MediaQuery.of(context).size.width,
              height: _isSwitch ?  MediaQuery.of(context).size.height -  100 : MediaQuery.of(context).size.height -  50,
              // color: Colors.red,
              child: FutureBuilder(
                  future: ApiService.ShowServices(widget.UserId.toString()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.data.length,
                            physics: ScrollPhysics(),
                            //  shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return _switcherProduct(
                                  snapshot.data.data[index]);
                            })
                        : HomePageItemShimmer();
                  }),
            ),
          ),
          _isSwitch ?   Positioned(
            bottom: 0.0,
            height: 85.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10.0),color: Colors.white,
              child: Center(
                child: ButtonTheme(
                  height: 60.0,
                  minWidth:  MediaQuery.of(context).size.width -70 ,
                  child:  RaisedButton(
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                    child: Text(
                      AppLocalizations.of(context).translate('just_register'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MainFont,
                        fontWeight: semiFont,
                      ),
                    ),
                    onPressed:() {
                      locator<IsLoadingManager>().isLoading.add(true);

                      ApiService.SendServiceRequest(_allOrders)
                          .then((data) {
                        locator<IsLoadingManager>().isLoading.add(false);

                        if (data.key == "1") {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(data.msg),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(data.msg),
                              );
                            },
                          );
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ):Container(),
        ],
      ),
    );
  }

  Widget _switcherProduct(sectionDataContent) {
    return AnimatedSwitcher(
        duration: Duration(seconds: 1),
        transitionBuilder: (Widget child, animation) => ScaleTransition(
              child: child,
              scale: animation,
            ),
        child: _isSwitch
            ? SingleChooseProduct(sectionDataContent)
            : _singleProduct(sectionDataContent)
    );
  }

  Widget _singleProduct(sectionDataContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      //    color: Colors.green,
      child: Stack(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3.0,
            child: Container(
              height: 190.0,
              width: MediaQuery.of(context).size.width - 100.0,
              padding: EdgeInsets.only(
                  top: 7.0, right: 70.0, bottom: 0.0, left: 15.0),
              child: Wrap(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sectionDataContent.title,
                        // "Product Name",
                        style: TextStyle(
                          fontWeight: bolFont,
                          fontSize: MediumFont,
                        ),
                      ),
                      sectionDataContent.quantity == 0
                          ? Container(
                              height: 30.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                  child: Text(
                                    AppLocalizations.of(context).translate("Expired"),
                                style: TextStyle(color: Colors.red),
                              )),
                            )
                          : Container(),
                    ],
                  ),
                  Container(
                    height: 10.0,
                  ),
                  Text(
                    //  "This text is an example of text that can be replaced in the same space",
                    sectionDataContent.desc,
                    style: TextStyle(
                        fontWeight: semiFont,
                        fontSize: PrimaryFont,
                        color: littleGrey),
                    maxLines: 2,
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate("amount : ") ,
                        style: TextStyle(
                          fontWeight: semiFont,
                          fontSize: PrimaryFont,
                          //   color: midGrey
                        ),
                      ),
                      Text(
                        "${sectionDataContent.quantity.toString()}  ${AppLocalizations.of(context).translate("package")}",
                        //  "30 package",
                        style: TextStyle(
                            fontWeight: semiFont,
                            fontSize: PrimaryFont,
                            color: littleGrey),
                      ),
                    ],
                  ),
                  Container(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate("price : "),
                        style: TextStyle(
                          fontWeight: semiFont,
                          fontSize: PrimaryFont,
                          //   color: midGrey
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        sectionDataContent.price.toString(),
                        //"100",
                        style: TextStyle(
                            fontWeight: semiFont,
                            fontSize: MediumFont,
                            color: Theme.of(context).accentColor),
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
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                  Container(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 40,
              right: 0.0,
              child: InkWell(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: (BuildContext context) =>
//                              SingleProduct(sectionDataContent)));
//                },
                child: Image.network(
                  sectionDataContent.image,
                  height: 110.0,
                  width: 110.0,
                ),
              )),
        ],
      ),
    );
  }
}
List _allOrders = [];
class SingleChooseProduct extends StatefulWidget {
  var sectionDataContent;

  SingleChooseProduct(this.sectionDataContent);

  @override
  _SingleChooseProductState createState() => _SingleChooseProductState();
}

class _SingleChooseProductState extends State<SingleChooseProduct> {
  bool checked = false;


  TextEditingController updateCount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: widget.sectionDataContent.quantity != 0
              ? () {



                if (checked == false) {
                  if (widget.sectionDataContent.quantity > 0) {

                    if(updateCount.text.length > 0){
                      _allOrders.add("{\"service_id\":\"${widget.sectionDataContent.id}\",\"quantity\":\"${updateCount.text}\"}");

                    }
                  }
                } else if (checked == true) {
                  if (widget.sectionDataContent.quantity > 0) {
                    _allOrders.remove(
                        "{\"service_id\":\"${widget.sectionDataContent.id}\",\"quantity\":\"${updateCount.text}\"}");
                    updateCount.clear();
                  }
                }


//                  locator<DeliveryOrdersListBloc>().deliveryOrderListSink.add(_allOrders);
                  print(_allOrders);
                  print(widget.sectionDataContent.quantity);
                  setState(() {
                    checked = !checked;
                  });
                }
              : null,
          child: checked
              ? Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.grey[400], width: 2.0),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.0,
                  )),
                )
              : Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
//              color: Colors.blue,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.grey[400], width: 2.0),
                  ),
//            child: Center(child: Icon(Icons.check,color: Colors.white,size: 16.0,)),
                ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            //    color: Colors.green,
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3.0,
                  child: Container(
                    height: 190.0,
                    width: MediaQuery.of(context).size.width - 100.0,
                    padding: EdgeInsets.only(
                        top: 7.0, right: 70.0, bottom: 0.0, left: 15.0),
                    child: Wrap(
                      children: <Widget>[
                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.sectionDataContent.title,
                              // "Product Name",
                              style: TextStyle(
                                fontWeight: bolFont,
                                fontSize: MediumFont,
                              ),
                            ),
                            widget.sectionDataContent.quantity == 0
                                ? Container(
                                    height: 30.0,
                                    width: 60.0,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Expired",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                  )
                                : Container(),
                          ],
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Container(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).translate("amount : ") ,
                              style: TextStyle(
                                fontWeight: semiFont,
                                fontSize: PrimaryFont,
                                //   color: midGrey
                              ),
                            ),
                            Text(
                              "${widget.sectionDataContent.quantity.toString()}  ${AppLocalizations.of(context).translate("package")}",
                              //  "30 package",
                              style: TextStyle(
                                  fontWeight: semiFont,
                                  fontSize: PrimaryFont,
                                  color: littleGrey),
                            ),
                          ],
                        ),
                        Container(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).translate("price : "),
                              style: TextStyle(
                                fontWeight: semiFont,
                                fontSize: PrimaryFont,
                                //   color: midGrey
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              widget.sectionDataContent.price.toString(),
                              //"100",
                              style: TextStyle(
                                  fontWeight: semiFont,
                                  fontSize: MediumFont,
                                  color: Theme.of(context).accentColor),
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
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        Container(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 40,
                    right: 0.0,
                    child: InkWell(
                      onTap: () {
//                        Navigator.push(
//                            context,
//                            new MaterialPageRoute(
//                                builder: (BuildContext context) =>
//                                    SingleProduct(widget.sectionDataContent)));
                      },
                      child: Image.network(
                        widget.sectionDataContent.image,
                        height: 110.0,
                        width: 110.0,
                      ),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          width: 65.0,
          child: widget.sectionDataContent.quantity > 0
              ? TextField(
                  enabled: checked ? false : true,
                  controller: updateCount,
                  keyboardType: TextInputType.number,
                  //  onChanged: signupBloc.changeName,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate("count"),
//                labelText: "Amount",
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                )
              : TextField(
                  enabled: false,
                  controller: updateCount,
                  keyboardType: TextInputType.number,
                  //  onChanged: signupBloc.changeName,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate("count"),
//                labelText: "Amount",
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                ),
        ),
      ],
    );
  }
}

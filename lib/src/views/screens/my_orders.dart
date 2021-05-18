import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/new_order.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';
import 'package:numberpicker/numberpicker.dart';

class MyOrdersScreen extends StatelessWidget {
  BehaviorSubject isDialogAdd = new BehaviorSubject.seeded(false);
  BehaviorSubject isDialogAddSmall = new BehaviorSubject.seeded(false);

  List<BehaviorSubject> countWithIndex = new List();
  List<BehaviorSubject> singleCartTottal = new List();
  List<BehaviorSubject> changePrice = new List();
  BehaviorSubject tottalWithoutDiscountRX = new BehaviorSubject();
  BehaviorSubject variableRateBehaviorSubject = new BehaviorSubject();

//  List tottalWithoutDiscountList = [];
  List<List> tottalWithoutDiscountList = new List();
  List<List> tottalDiscount = new List();
  List cleanTottalWithoutDiscountList = [];

  int _currentValue = 0;

//  double _currentPrice = 1.0;

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(
                  AppLocalizations.of(context).translate('Are_you_sure?')),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => MyOrdersScreen()));
                  },
                  child: new Text(AppLocalizations.of(context)
                      .translate('Contuie_order_str')),
                ),
                new FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(
                                locator<UserIdBloc>()
                                    .currentUserId
                                    .toString()
                                    .toString())));
                  },
                  child: new Text(
                      AppLocalizations.of(context).translate('back_home_str')),
                ),
              ],
            ),
          )) ??
          false;
    }

    Widget _trashContainer() {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 90.0,
              width: 90.0,
              child: Image.asset("assets/images/delete_.png"),
              //Icon(Icons.delete,color: Colors.white,),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("My_Orders_str")),
//          leading: IconButton(
//            icon: Icon(
//              Icons.arrow_back_ios,
//              size: 25.0,
//            ),
//            onPressed: () {
//              Navigator.pop(context);
//            },
//          ),
        leading: Container(),
        ),
        body: StreamBuilder(
            stream: isDialogAdd.stream,
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    //     color: Colors.yellow,
                  ),
                  FutureBuilder(
                      future: ApiService.ShowCart(),
                      builder: (context, showCartSnapshot) {
                        if (showCartSnapshot.hasData) {
                          variableRateBehaviorSubject
                              .add(showCartSnapshot.data.variableRate);
                        }
                        return showCartSnapshot.hasData
                            ? Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height -
                                  190,
                              padding: EdgeInsets.all(20.0),
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: showCartSnapshot
                                      .data.data.cartData.length,
                                  itemBuilder: (context, index) {
                                    tottalWithoutDiscountList.add(new List());
                                    tottalDiscount.add(new List());

                                    countWithIndex
                                        .add(new BehaviorSubject());
                                    singleCartTottal
                                        .add(new BehaviorSubject());
                                    changePrice.add(
                                        new BehaviorSubject.seeded(0));

                                    countWithIndex[index].add(
                                        showCartSnapshot.data.data
                                            .cartData[index].quantity);

                                    return Dismissible(
                                      direction:
                                      DismissDirection.startToEnd,
//                                      key: Key(showCartSnapshot
//                                          .data.data.cartData[index].id.toString()),
                                      key: UniqueKey(),

                                      background: _trashContainer(),
                                      child: Container(
                                        key: Key(showCartSnapshot
                                            .data
                                            .data
                                            .cartData[index]
                                            .sectionImage +
                                            showCartSnapshot.data.data
                                                .cartData[index].id
                                                .toString()),
                                        margin:
                                        EdgeInsets.only(bottom: 10.0),
                                        child: StreamBuilder(
                                            initialData:
                                            countWithIndex[index]
                                                .value *
                                                showCartSnapshot
                                                    .data
                                                    .data
                                                    .cartData[index]
                                                    .sectionPrice,
                                            stream: countWithIndex[index]
                                                .stream,
                                            builder: (context,
                                                countWithIndexSnapshot) {
                                              tottalWithoutDiscountList[
                                              index]
                                                  .clear();
                                              tottalWithoutDiscountList[
                                              index]
                                                  .add(countWithIndex[
                                              index]
                                                  .value *
                                                  showCartSnapshot
                                                      .data
                                                      .data
                                                      .cartData[index]
                                                      .sectionPrice);

                                              return Card(
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        15.0),
                                                  ),
                                                  elevation: 3.0,
                                                  child: Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <
                                                              Widget>[
                                                            Flexible(
                                                              flex: 3,
                                                              child:
                                                              Container(
                                                                padding: const EdgeInsets
                                                                    .all(
                                                                    12.0),
                                                                child: Image
                                                                    .network(
                                                                  showCartSnapshot
                                                                      .data
                                                                      .data
                                                                      .cartData[index]
                                                                      .sectionImage,
                                                                  height:
                                                                  110.0,
                                                                  width:
                                                                  110.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 6,
                                                              child:
                                                              Container(
                                                                child:
                                                                Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <Widget>[
                                                                        Text(
                                                                          showCartSnapshot.data.data.cartData[index].sectionTitle,
                                                                          style: TextStyle(
                                                                            fontWeight: bolFont,
                                                                            fontSize: MediumFont,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      showCartSnapshot.data.data.cartData[index].sectionDesc,
                                                                      style: TextStyle(
                                                                          fontWeight: semiFont,
                                                                          fontSize: PrimaryFont,
                                                                          color: littleGrey),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              top: 0,
                                                              right:
                                                              20,
                                                              left:
                                                              20.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: <
                                                                Widget>[
                                                              Container(
                                                                child:
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      showCartSnapshot.data.data.cartData[index].sectionPrice.toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: semiFont,
                                                                          fontSize: MediumFont,
                                                                          color: Theme.of(context).accentColor),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                      5.0,
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
                                                              Container(
                                                                child:
                                                                Container(
                                                                  child:
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      IconButton(
                                                                        onPressed: () {
                                                                          changePrice[index].add(0);

                                                                          if (showCartSnapshot.data.data.cartData[index].quantity >= 1) {
                                                                            countWithIndex[index].add(showCartSnapshot.data.data.cartData[index].quantity--);
                                                                          }
                                                                        },
                                                                        icon: Container(
                                                                          width: 35,
                                                                          height: 35,
                                                                          decoration: new BoxDecoration(
                                                                            color: Colors.white,
                                                                            shape: BoxShape.circle,
                                                                            border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
                                                                          ),
                                                                          child: new Icon(
                                                                            Icons.remove,
                                                                            size: 16.0,
                                                                            color: Theme.of(context).primaryColor,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      Container(
                                                                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                                                                        child: Text(
                                                                          // data.data.cartData[index].quantity.toString(),
                                                                          countWithIndexSnapshot.data.toString(),
                                                                          style: TextStyle(fontSize: LargeFont, fontWeight: semiFont, color: Theme.of(context).primaryColor),
                                                                        ),
                                                                      ),

                                                                      IconButton(
                                                                        onPressed: () {
                                                                          changePrice[index].add(0);
                                                                          print(singleCartTottal[index].value);
                                                                          print("singleCartTottal[index]");
                                                                          print(countWithIndex[index].value);

                                                                          countWithIndex[index].add(showCartSnapshot.data.data.cartData[index].quantity++);
                                                                        },
                                                                        icon: Container(
                                                                          width: 35,
                                                                          height: 35,
                                                                          decoration: new BoxDecoration(
                                                                            color: Colors.white,
                                                                            shape: BoxShape.circle,
                                                                            border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
                                                                          ),
                                                                          child: new Icon(
                                                                            Icons.add,
                                                                            size: 16.0,
                                                                            color: Theme.of(context).primaryColor,
                                                                          ),
                                                                        ),
                                                                      ),
//          Container(
//            child: Text(singleCartTottal[index].value.toString()),
//          ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  StreamBuilder(
                                                                      initialData:
                                                                      showCartSnapshot.data.data.cartData[index].sectionPrice * showCartSnapshot.data.data.cartData[index].quantity,
                                                                      stream: singleCartTottal[index].stream,
                                                                      builder: (context, tottalWithoutDiscountSnapshot) {
                                                                        singleCartTottal[index].add(countWithIndexSnapshot.data * showCartSnapshot.data.data.cartData[index].sectionPrice);
//                                                                  tottalWithoutDiscountList
//                                                                      .add(tottalWithoutDiscountSnapshot.data);singleCartTottal[
//                                                                  index]
//                                                                  .
//

                                                                        var sumMince = tottalDiscount.reduce((a, b) => a + b);
//                                                                  tottalWithoutDiscountRX.add(sumMince.fold(0, (previous, current) => previous + current));

                                                                        var sum = tottalWithoutDiscountList.reduce((a, b) => a + b);
                                                                        tottalWithoutDiscountRX.add((sum.fold(0, (previous, current) => previous + current) + sumMince.fold(0, (previous, current) => previous + current)));
                                                                        cleanTottalWithoutDiscountList.add(tottalWithoutDiscountList);
//                                                                  print( "fold1 ${tottalWithoutDiscountSnapshot.data}");

//                                                                  tottalWithoutDiscountList.add(tottalWithoutDiscountSnapshot.data);

//                                                                  print("fold1 ${tottalWithoutDiscountList[index].fold(0, (previous, current) => previous + current)}");

                                                                        return Text(
                                                                          tottalWithoutDiscountSnapshot.data.toString(),
                                                                          style: TextStyle(fontWeight: bolFont, fontSize: MainFont, color: Theme.of(context).accentColor),
                                                                        );
                                                                      }),
                                                                  SizedBox(
                                                                    width:
                                                                    5.0,
                                                                  ),
                                                                  Text(
                                                                    AppLocalizations.of(context)
                                                                        .translate("real_suadi_shortcut"),
                                                                    style: TextStyle(
                                                                        fontWeight: bolFont,
                                                                        fontSize: MainFont,
                                                                        color: littleGrey),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        ExpansionTile(
                                                          title: Text(
                                                            AppLocalizations.of(
                                                                context)
                                                                .translate(
                                                                "Price_Modify_str"),
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              PrimaryFont,
                                                              fontWeight:
                                                              semiFont,
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor,
                                                              decoration:
                                                              TextDecoration
                                                                  .underline,
                                                            ),
                                                          ),
                                                          children: <
                                                              Widget>[
                                                            Wrap(
                                                              children: <
                                                                  Widget>[
                                                                Wrap(
                                                                  children: <
                                                                      Widget>[
                                                                    StreamBuilder(
                                                                        initialData: _currentValue,
                                                                        stream: changePrice[index].stream,
                                                                        builder: (context, changePriceSnapshot) {
                                                                          if (countWithIndex[index].value < 0) {
                                                                            changePrice[index].add(0);
                                                                          }
                                                                          tottalDiscount[index].clear();
                                                                          tottalDiscount[index].add(changePrice[index].value);
                                                                          return Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              countWithIndex[index].value > 0
                                                                                  ? Container(
                                                                                  height: 100,
                                                                                  child: new NumberPicker.integer(
                                                                                      initialValue: _currentValue,
                                                                                      minValue: -(((countWithIndex[index].value * showCartSnapshot.data.data.cartData[index].sectionPrice) * variableRateBehaviorSubject.value) / 100).round(),
                                                                                      maxValue: (((countWithIndex[index].value * showCartSnapshot.data.data.cartData[index].sectionPrice) * variableRateBehaviorSubject.value) / 100).round(),
                                                                                      onChanged: (newValue) {
                                                                                        changePrice[index].add(newValue);
                                                                                        print("tottalDiscount $tottalDiscount");
                                                                                      }))
                                                                                  : Container(),
                                                                              Container(
                                                                                width: 90,
                                                                                height: 35,
                                                                                margin: const EdgeInsets.all(15.0),
                                                                                padding: const EdgeInsets.all(3.0),
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                                                                child: Center(child: new Text(" ${changePrice[index].value}")),
                                                                              )
                                                                            ],
                                                                          );
                                                                        }),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
//                                          AppLocalizations.of(context).translate("*_You_can_modfy_the_price_10%_as_max_str")  ,
                                                                      locator<PrefsService>().appLanguage == "en"
                                                                          ? "You can modfy the price ${variableRateBehaviorSubject.value} % as max"
                                                                          : "يمكنك تعديل السعر بحد اقصي ${variableRateBehaviorSubject.value} %",
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
                                                    ),
                                                  ));
                                            }),
                                      ),
                                      onDismissed: (direction) {
                                        print(
                                            "${index} hohoindexindexindexindexindexindex");

                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => WillPopScope(
                                              onWillPop: _onWillPop,

                                              child: new Dialog(
                                                child: StreamBuilder(
                                                  stream: isDialogAddSmall.stream,
                                                  builder: (context, isDialogAddSmallSnapshot) {
                                                    return new Container(
                                                      alignment:
                                                      FractionalOffset
                                                          .center,
                                                      height: 150.0,
                                                      padding:
                                                      const EdgeInsets
                                                          .all(20.0),
                                                      child: Container(
                                                        child: isDialogAddSmallSnapshot.data == false ? new Column(
//                                                      mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                  context)
                                                                  .translate(
                                                                  "Do_you_str"),
                                                              style: TextStyle(
                                                                fontWeight: bolFont,
                                                                fontSize: MediumFont,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15.0,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width / 2,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  RaisedButton(
                                                                    child:
                                                                    Text(
                                                                      AppLocalizations.of(context)
                                                                          .translate("yes_str"),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                          isDialogAddSmall.add(true);

                                                                          ApiService.UpdateDelteCart(
                                                                          0,
                                                                          showCartSnapshot.data.data.cartData[index].id,
                                                                          0)
                                                                          .then((onValue) {
                                                                            isDialogAddSmall.add(false);

                                                                      Navigator.of(context)
                                                                            .push(new MaterialPageRoute(builder: (BuildContext context) => MyOrdersScreen()));
                                                                      });
                                                                    },
                                                                  ),
                                                                  RaisedButton(
                                                                    child:
                                                                    Text(
                                                                      AppLocalizations.of(context)
                                                                          .translate("no_str"),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                         // isDialogAddSmall.add(true);
                                                                          Navigator.pushReplacement(
                                                                          context,
                                                                          new MaterialPageRoute(builder: (BuildContext context) => MyOrdersScreen()));
//                                                                         // isDialogAddSmall.add(false);
                                                                        },
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ) : Center(
                                                          child: CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                ),
                                              ),
                                            ));

//                                            ApiService.UpdateDelteCart(
//                                                0, showCartSnapshot.data.data.cartData[index].id, 0);
//
//                                            tottalDiscount.removeAt(index);
//                                            tottalWithoutDiscountList.removeAt(index);
//                                            changePrice[index].add(0);
//                                            countWithIndex[index].add(0);
//                                            singleCartTottal[index].add(0);
//                                            changePrice.removeAt(index);
//                                            countWithIndex.removeAt(index);
//                                            singleCartTottal.removeAt(index);

                                        print(
                                            "${showCartSnapshot.data.data.cartData.length} indexindexindexindexindexindex");
                                      },
                                    );
//                                      });
                                  }),
                            ),
                            Positioned(
                              bottom: 0.0,
                              child: Container(
                                color: Colors.white,
                                height: 150.0,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                "Tottal_Price_str"),
                                            //   color: midGrey
                                            style: TextStyle(
                                              fontWeight: semiFont,
                                              fontSize: MediumFont,
                                              //   color: midGrey
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              StreamBuilder(
                                                  initialData: 0,
                                                  stream:
                                                  tottalWithoutDiscountRX
                                                      .stream,
                                                  builder: (context,
                                                      tottalWithoutDiscountRXsnapshot) {
                                                    return Text(
                                                      "${tottalWithoutDiscountRXsnapshot.data.toString()}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          semiFont,
                                                          fontSize:
                                                          MediumFont,
                                                          color: Theme.of(
                                                              context)
                                                              .accentColor),
                                                    );
                                                  }),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                AppLocalizations.of(
                                                    context)
                                                    .translate(
                                                    "real_suadi_shortcut"),
                                                style: TextStyle(
                                                    fontWeight: regFont,
                                                    fontSize:
                                                    SecondaryFont,
                                                    color: littleGrey),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    ButtonTheme(
                                      height: 60.0,
                                      minWidth: MediaQuery.of(context)
                                          .size
                                          .width,
                                      child: RaisedButton(
                                        color:
                                        Theme.of(context).accentColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(
                                                15.0)),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate("Order_str"),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MainFont,
                                            fontWeight: semiFont,
                                          ),
                                        ),
                                        onPressed: () {

                                          if(showCartSnapshot
                                              .data.data.cartData.length != 0){
                                            var sum =
                                            tottalWithoutDiscountList
                                                .reduce(
                                                    (a, b) => a + b);
                                            print("$sum dqwwwwwwww");
                                            isDialogAdd.add(true);

                                            List productsId = [];
                                            List productsCount = [];
                                            List productsTotal = [];
                                            List all = [];

                                            for (int index = 0;
                                            index <
                                                showCartSnapshot
                                                    .data
                                                    .data
                                                    .cartData
                                                    .length;
                                            index++) {
                                              productsId.add(
                                                  showCartSnapshot
                                                      .data
                                                      .data
                                                      .cartData[index]
                                                      .sectionId);
                                              productsCount.add(
                                                  countWithIndex[index]
                                                      .value);
                                              productsTotal.add(
                                                  tottalWithoutDiscountList[
                                                  index]
                                                      .reduce((a, b) =>
                                                  a + b) +
                                                      changePrice[index]
                                                          .value);
                                              all.add(
                                                  "{ \"section_id\" :\"${productsId[index]}\" , \"count\" :\"${productsCount[index]}\" , \"total\" :\"${productsTotal[index]}\"}");
                                            }

                                            ApiService.UpdateAllCartItems(
                                                all)
                                                .then((onValue) {
                                              if (onValue.key == "1") {
                                                isDialogAdd.add(false);

                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (BuildContext
                                                        context) =>
                                                            NewOrder()));
                                              } else {
                                                isDialogAdd.add(false);
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                  context) {
                                                    return AlertDialog(
                                                      title:
                                                      Text(onValue.msg),
                                                    );
                                                  },
                                                );
                                              }
                                            });

                                            print("kollo $all");
//    print("kollo ${tottalDiscount[0].reduce((a, b) => a + b)}");
                                          }


                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                            : Center(
                          child: Container(
                            padding: EdgeInsets.all(30.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                  isDialogAdd.value == true
                      ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(child: CircularProgressIndicator()),
                  )
                      : Container(),
                ],
              );
            }),
      ),
    );
  }

  dispose() {
    tottalWithoutDiscountRX.close();
    variableRateBehaviorSubject.close();
    isDialogAdd.close();
    isDialogAddSmall.close();
  }
}

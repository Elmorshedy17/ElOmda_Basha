import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/filter_screen_bloc.dart';
import 'package:medicine/src/blocs/home_page_bloc.dart';
import 'package:medicine/src/models/super_visor_marketers/home_model.dart';
import 'package:medicine/src/views/screens/my_orders.dart';
import 'package:medicine/src/views/screens/notifications.dart';
import 'package:medicine/src/views/screens/single_product.dart';
import 'package:medicine/src/views/widgets/drawer.dart';
import 'package:medicine/src/views/widgets/shimmer_placeholders.dart';
import 'package:medicine/theme_setting.dart';
import 'package:shimmer/shimmer.dart';

class FilteredScreen extends StatefulWidget {
  var firstPriceRange;
  var endPriceRange;
  var firstAmount;
  var endAmount;

  FilteredScreen(this.firstPriceRange, this.endPriceRange, this.firstAmount,
      this.endAmount);

  @override
  _FilteredScreenState createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String firstPriceRange;
  String endPriceRange;
  String firstAmount;
  String endAmount;
  String title;

  RangeValues priceValues = RangeValues(1, 100);
  RangeLabels priceLabels = RangeLabels("1", "100");
  RangeValues amountValues = RangeValues(1, 100);
  RangeLabels amountLabels = RangeLabels("1", "100");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      appBar: AppBar(
//        title: Text("home"),
//        elevation: 0.0,
//      ),
      drawer: MyDrawer(),
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
                height: 150.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Positioned(
            top: 25.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                            "assets/images/menu.png",
                            height: 30.0,
                            width: 30.0,
                          ),
                          onPressed: () =>
                              _scaffoldKey.currentState.openDrawer(),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                         // AppLocalizations.of(context).translate('home_str'),

                          AppLocalizations.of(context).translate("results_str"),
                        style: TextStyle(
                              color: Colors.white,
                              fontSize: MainFont,
                              fontWeight: semiFont),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: FutureBuilder(
                              future: ApiService.AllNotificationShow(),
                              builder: (context, NotificationsSnapshot) {
                                return InkWell(
                                    onTap: () {
                                      locator<PrefsService>().NotiCount = NotificationsSnapshot.data.data.length;

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Notifications(NotificationsSnapshot.data)));
                                    },
                                    child: Stack(
                                      children: <Widget>[

                                        Icon(
                                          Icons.notifications_none,
                                          color: Colors.white,
                                          size: 35.0,
                                        ),
                                        NotificationsSnapshot.hasData?    Positioned(
                                          top: 6.0,
                                          child: Container(
                                            child: Center(child: Text(NotificationsSnapshot.data.data.length.toString(),style: TextStyle(color: Colors.white,height: 1.5,fontSize: 10),)),
                                            decoration: new BoxDecoration(
                                              borderRadius: new BorderRadius.all(Radius.circular(500.0),
                                              ),
                                              color: Colors.red,

                                            ),
                                            height: 18.0,
                                            width: 15.0,
                                          ),
                                        ):Container(),
                                      ],
                                    ));
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
//          Positioned(
//            top: 85.0,
//            right: 0,
//            child: Container(
//              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
//              height: 80,
//              width: MediaQuery.of(context).size.width,
//              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
//              child: TextField(
//                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.symmetric(
//                    vertical: 10,
//                  ),
//                  alignLabelWithHint: true,
//                  prefixIcon: Icon(
//                    Icons.search,
//                    color: Colors.grey,
//                  ),
//                  suffixIcon: IconButton(
//                    onPressed: () {
//                      _settingModalBottomSheet(context);
//                    },
//                    icon: Image.asset("assets/images/filter.png"),
//                  ),
//                  hintText:
//                      AppLocalizations.of(context).translate('search_str'),
//                  hintStyle: TextStyle(color: midGrey, fontSize: 16),
//                  filled: true,
//                  fillColor: Colors.white,
//                  enabledBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(10.0),
//                    ),
//                    borderSide: BorderSide(color: Colors.transparent),
//                  ),
//                  focusedBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(10.0),
//                    ),
//                    borderSide: BorderSide(color: Colors.transparent),
//                  ),
//                ),
//              ),
//            ),
//          ),
          Positioned(
            top: 90.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              // color: Colors.red,
              child: FutureBuilder(
                  future: ApiService.FilterService(
                      widget.firstPriceRange,
                      widget.endPriceRange,
                      widget.firstAmount,
                      widget.endAmount,
                 ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData ? ListView.builder(
                        itemCount: snapshot.data.data.length,
                        physics: ScrollPhysics(),
                        //  shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return
                              //  snapshot.connectionState != ConnectionState.done
                              _singleProduct(snapshot.data.data[index]);
                        }) : Center(
                      child: Container(
                        padding: EdgeInsets.all(120.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setMoadalState
                /*You can rename this!*/) {
              return Container(
                color: Color(0xFF737373),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(15.0),
                          topRight: const Radius.circular(15.0))),
                  child: new Wrap(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('search_about_str'),
                            style: TextStyle(
                                color: blackColor,
                                fontSize: MainFont,
                                fontWeight: bolFont),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                  .translate('price_average'),
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: PrimaryFont,
                                  fontWeight: semiFont),
                            ),
                            firstPriceRange != null || endPriceRange != null
                                ? Text("${firstPriceRange} - ${endPriceRange}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor))
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        child: RangeSlider(
                          min: 1,
                          max: 100,
                          values: priceValues,
                          labels: priceLabels,
                          //  divisions: 1,
                          onChanged: (val) {
                            print(val);
                            setMoadalState(() {
                              priceValues = val;
                              priceLabels = RangeLabels(
                                  val.start.toString(), val.end.toString());
                              firstPriceRange = val.start.toInt().toString();
                              endPriceRange = val.end.toInt().toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('amount_average'),
                            style: TextStyle(
                                color: blackColor,
                                fontSize: PrimaryFont,
                                fontWeight: semiFont),
                          ),
                          firstAmount != null || endAmount != null
                              ? Text(
                                  "${firstAmount} - ${endAmount}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      RangeSlider(
                        min: 1,
                        max: 100,
                        values: amountValues,
                        labels: amountLabels,
                        //  divisions: 1,
                        onChanged: (val) {
                          print(val);
                          setMoadalState(() {
                            amountValues = val;
                            amountLabels = RangeLabels(
                                val.start.toString(), val.end.toString());
                            firstAmount = val.start.toInt().toString();
                            endAmount = val.end.toInt().toString();
                          });
                        },
                      ),
                      SizedBox(
                        height: 55.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('just_search'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MainFont,
                                fontWeight: semiFont,
                              ),
                            ),
                            onPressed: () {
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => FilteredScreen(locator<FilterScreenBloc>().currentFilter)),
//                              );

                              Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FilteredScreen(firstPriceRange,
                                            endPriceRange, firstAmount, endAmount,)),);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

// single product card with image

  Widget _singleProduct(sectionDataContent) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    SingleProduct(sectionDataContent)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: 200.0,
        width: 300.0,
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
                      children: <Widget>[
                        Text(
                          sectionDataContent.title,
                          // "Product Name",
                          style: TextStyle(
                            fontWeight: bolFont,
                            fontSize: MediumFont,
                          ),
                        ),
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
                          AppLocalizations.of(context).translate("amount_:")
                          ,
                          style: TextStyle(
                            fontWeight: semiFont,
                            fontSize: PrimaryFont,
                            //   color: midGrey
                          ),
                        ),
                        Text(
                          "${sectionDataContent.quantity.toString()}  ${ AppLocalizations.of(context).translate("package")}",
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
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            height: 40.0,
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                              child: FittedBox(
                                child: Text(
                                  AppLocalizations.of(context).translate("Add_to_Cart_str") ,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: PrimaryFont,
                                    fontWeight: regFont,
                                  ),
                                ),
                              ),

                              onPressed: () {
//                                Navigator.push(
//                                    context,
//                                    new MaterialPageRoute(
//                                        builder: (BuildContext context) =>
//                                            MyOrdersScreen()));

                                ApiService.AddToCart(sectionDataContent.id.toString());

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return FutureBuilder(
                                          future: ApiService.AddToCart(sectionDataContent.id.toString()),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            return AlertDialog(
                                              title: snapshot.hasData? Text(snapshot.data.msg):Center(child: CircularProgressIndicator()),
                                            );
                                          }
                                      );
                                    }
                                );

                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
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
                                AppLocalizations.of(context).translate("real_suadi_shortcut") ,
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
                right:  Localizations.localeOf(context).languageCode == 'en' ? 0.0 : null,
                left:  Localizations.localeOf(context).languageCode == 'ar' ?0.0 : null,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SingleProduct(sectionDataContent)));
                  },
                  child: Image.network(
                    sectionDataContent.image,
                    height: 88.0,
                    width: 88.0,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

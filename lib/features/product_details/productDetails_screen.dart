import 'package:flutter/material.dart';
import 'package:momentoo/features/product_details/productDetailsCounter_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:share/share.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int extrasIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.teal.shade900,
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('back_str'),
                      style: TextStyle(
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Share.share('انا استخدم هذا المنتج + google play url',
                          subject: 'Look what I made!');

                      print("ey");
                    },
                    child: Icon(
                      Icons.share,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Collapsing Toolbar",
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('Description_str'),
                  style: TextStyle(
                      color: Colors.teal.shade900, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                ),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('Extras_str'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (context, index) {
                  return Divider(
                    endIndent: 10,
                    indent: 10,
                    height: 1,
                    color: Colors.black12,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        extrasIndex = index;
                      });
                    },
                    title: Row(
                      children: <Widget>[
                        Text(
                          "Tuna",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          " + 35.00 KD",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    trailing: extrasIndex == index
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.teal.shade900,
                          )
                        : Container(
                            width: 1,
                            height: 1,
                          ),
                  );
                },
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 28.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('Quantity_str'),
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 25.0,
                      decoration: new BoxDecoration(
                        border:
                            Border.all(color: Colors.teal.shade900, width: 1),
                        color: Colors.teal.shade900,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 50.0,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                                bottomLeft: const Radius.circular(40.0),
                              ),
                            ),
                            child: Center(
                              child: FlatButton(
                                onPressed: () {
                                  if (locator<ProductDetailsCounterManager>()
                                          .currentValue >
                                      1) {
                                    locator<ProductDetailsCounterManager>()
                                        .decrement();
                                  }
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: new BoxDecoration(
                              color: Colors.teal.shade900,
                              borderRadius: new BorderRadius.only(
                                topRight: const Radius.circular(40.0),
                                bottomRight: const Radius.circular(40.0),
                              ),
                            ),
                            width: 50.0,
                            child: Center(
                              child: FlatButton(
                                onPressed: () {
                                  locator<ProductDetailsCounterManager>()
                                      .increment();
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<int>(
                        initialData: 1,
                        stream:
                            locator<ProductDetailsCounterManager>().counter$,
                        builder: (context, snapshot) {
                          return Text(
                            "${snapshot.data}  ${AppLocalizations.of(context).translate('item_str')}",
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12),
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      hintText: locator<PrefsService>().appLanguage == "ar"
                          ? "التعليمات"
                          : "instructions",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTheme(
                  minWidth: 280.0,
                  height: 55.0,
                  child: RaisedButton(
                    color: Colors.teal.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('Add_to_order_str'),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "25.8 ${AppLocalizations.of(context).translate('Kd_str')}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  dispose() {
    locator<ProductDetailsCounterManager>().dispose();
    super.dispose();
  }
}

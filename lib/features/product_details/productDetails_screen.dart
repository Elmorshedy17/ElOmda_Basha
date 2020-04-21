import 'package:flutter/material.dart';
import 'package:momentoo/features/favorites/favoriteActions_manager.dart';
import 'package:momentoo/features/product_details/productDetailsCounter_manager.dart';
import 'package:momentoo/features/product_details/productDetails_manager.dart';
import 'package:momentoo/features/product_details/productDetails_model.dart';
import 'package:momentoo/features/product_details/productImagesPreview_screen.dart';
import 'package:momentoo/shared/domain/cartRequest.dart';
import 'package:momentoo/shared/helper/cartItemsCount_manger.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class ProductDetailsArguments {
  final int sellerId;
  final int productId;

  ProductDetailsArguments({
    @required this.sellerId,
    @required this.productId,
  });
}

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<bool> selectedExtra = [];
  double productPrice = 0.0;
  double extraPrice = 0.0;
  int count = 1;
  List<int> selectedExtrasIds = [];
  String note = '';

  // Widget trailingWidget(int index, Function doThis) {
  //   if (selectedExtra.isNotEmpty && selectedExtra[index] != null) {
  //     doThis();
  //     return Icon(
  //       Icons.check_circle,
  //       color: Colors.teal.shade900,
  //     );
  //   } else {
  //     return Container(
  //       width: 1,
  //       height: 1,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ProductDetailsArguments args = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async {
        locator<ProductDetailsCounterManager>().inCounter.add(1);
        return true;
      },
      child: Scaffold(
        body: CustomObserver(
          stream: locator<ProductDetailsManager>().getData(args.productId),
          onSuccess: (_, ProductDetailsModel model) {
            // price = double.parse(model.data.product.price);
            //!
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.teal.shade900,
                    leading: InkWell(
                      onTap: () {
                        locator<ProductDetailsCounterManager>()
                            .inCounter
                            .add(1);
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
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : 'ar',
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 2,
                        ),
                        // decoration: BoxDecoration(
                        //   color: Colors.grey.shade200,
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(50),
                        //   ),
                        // ),
                        child: IconButton(
                          icon: Icon(
                            Icons.star,
                            size: 30.0,
                            color: model.data.product.favourite == 'yes'
                                ? Colors.pink
                                : Colors.white,
                          ),
                          onPressed: () {
                            model.data.product.favourite == 'yes'
                                ? locator<FavoritesActionsManager>()
                                    .addOrRemoveFavorite('product', 'remove',
                                        model.data.product.id.toString())
                                : locator<FavoritesActionsManager>()
                                    .addOrRemoveFavorite('product', 'add',
                                        model.data.product.id.toString());
                            locator<ProductDetailsManager>()
                                .getData(args.productId);
                          },
                        ),
                      ),
                    ],
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(model.data.product.name,
                          style: TextStyle(
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade900,
                            fontSize: 16.0,
                          )),
                      background: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProductImagesScreen(
                                images: model.data.product.images,
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          model.data.product.image,
                          fit: BoxFit.cover,
                        ),
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
                        AppLocalizations.of(context)
                            .translate('Description_str'),
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontWeight: FontWeight.bold,
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                      subtitle: Text(
                        model.data.product.desc,
                        style: TextStyle(
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                    ),
                    model.data.product.options.length > 0
                        ? ListTile(
                            title: Text(
                              AppLocalizations.of(context)
                                  .translate('Extras_str'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : 'ar',
                              ),
                            ),
                          )
                        : Container(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: model.data.product.options?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return Divider(
                          endIndent: 10,
                          indent: 10,
                          height: 1,
                          color: Colors.black12,
                        );
                      },
                      itemBuilder: (context, index) {
                        for (var i = 0;
                            i < model.data.product.options?.length ?? 0;
                            i++) {
                          selectedExtra.add(false);
                        }
                        return ListTile(
                          // key: GlobalKey(),
                          onTap: () {
                            setState(() {
                              if (selectedExtra.length > 0) {
                                if (selectedExtra[index] != null) {
                                  selectedExtra.insert(
                                      index, !selectedExtra[index]);
                                  if (selectedExtra[index]) {
                                    selectedExtrasIds.add(
                                        model.data.product.options[index].id);
                                  } else {
                                    if (selectedExtrasIds.isNotEmpty) {
                                      selectedExtrasIds.remove(
                                          model.data.product.options[index].id);
                                    }
                                  }
                                }
                              }
                            });
                          },
                          title: Row(
                            children: <Widget>[
                              Text(
                                model.data.product.options[index].name,
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                " + ${model.data.product.options[index].price} ${model.data.product.options[index].currency}",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                              ),
                            ],
                          ),
                          trailing: selectedExtra.length > 0
                              ? selectedExtra[index] ?? false
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.teal.shade900,
                                    )
                                  : Container(
                                      width: 1,
                                      height: 1,
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
                            AppLocalizations.of(context)
                                .translate('Quantity_str'),
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 25.0,
                            decoration: new BoxDecoration(
                              border: Border.all(
                                  color: Colors.teal.shade900, width: 1),
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
                                    borderRadius:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(40.0),
                                                bottomLeft:
                                                    const Radius.circular(40.0),
                                              )
                                            : BorderRadius.only(
                                                topRight:
                                                    const Radius.circular(40.0),
                                                bottomRight:
                                                    const Radius.circular(40.0),
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
                                    borderRadius:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? BorderRadius.only(
                                                topRight:
                                                    const Radius.circular(40.0),
                                                bottomRight:
                                                    const Radius.circular(40.0),
                                              )
                                            : BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(40.0),
                                                bottomLeft:
                                                    const Radius.circular(40.0),
                                              ),
                                  ),
                                  width: 50.0,
                                  child: Center(
                                    child: FlatButton(
                                      onPressed: () {
                                        locator<ProductDetailsCounterManager>()
                                          ..increment()
                                          ..counter$.listen((v) {
                                            setState(() {});
                                            count = v;
                                            productPrice = extraPrice +
                                                double.parse(model
                                                        .data.product.price) *
                                                    v;
                                          });
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
                              stream: locator<ProductDetailsCounterManager>()
                                  .counter$,
                              builder: (context, snapshot) {
                                return Text(
                                  "${snapshot.data}  ${AppLocalizations.of(context).translate('item_str')}",
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
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
                        onChanged: (value) {
                          note = value ?? '';
                        },
                        decoration: InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                            disabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : 'ar',
                            ),
                            hintText:
                                locator<PrefsService>().appLanguage == "ar"
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('Add_to_order_str'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                                Text(
                                  "${productPrice > 0.0 ? productPrice : double.parse(model.data.product.price)} ${model.data.product.currency}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            if (locator<PrefsService>().cartObj.sellerId ==
                                    -1 ||
                                locator<PrefsService>().cartObj.sellerId ==
                                    args.sellerId) {
                              var cart = locator<PrefsService>().cartObj
                                ..sellerId = args.sellerId
                                ..products.add(Products(
                                    productId: args.productId,
                                    count: count,
                                    options: selectedExtrasIds.toString(),
                                    notes: note));
                              locator<PrefsService>().cartObj = cart;
                              locator<CartItemsCountManager>().inCartCount.add(
                                  locator<PrefsService>()
                                          .cartObj
                                          .products
                                          ?.length ??
                                      0);
                            } else {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    content: Container(
                                      height: 130,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
//                                              "diffrent_sellers_str"),
                                      AppLocalizations.of(context)
                                          .translate('diffrent_sellers_str'),)   ,
                                      Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ButtonTheme(
                                                  minWidth: 70.0,
                                                  height: 30.0,
                                                  child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(25.0),
                                                    ),
                                                    child: Text(
                                                       AppLocalizations.of(context)
                                                           .translate('No_str'),
                                                      // AppLocalizations.of(context)
                                                      //     .translate('ok_str'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    // color: greyBlue,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ButtonTheme(
                                                  minWidth: 70.0,
                                                  height: 30.0,
                                                  child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(25.0),
                                                    ),
                                                    child: Text(
//                                                      'OK_str',
                                                       AppLocalizations.of(context)
                                                           .translate('OK_str'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                    onPressed: () {
                                                      var cart = locator<
                                                              PrefsService>()
                                                          .cartObj
                                                        ..sellerId =
                                                            args.sellerId
                                                        ..products.clear();
                                                      locator<PrefsService>()
                                                          .cartObj = cart;
                                                      Navigator.pop(context);
                                                    },
                                                    // color: greyBlue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // actions: <Widget>[

                                    // ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//  Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       ButtonTheme(
//                         minWidth: 100.0,
//                         height: 30.0,
//                         child: RaisedButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(25.0),
//                           ),
//                           child: Text(
//                             AppLocalizations.of(context).translate('ok_str'),
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: SecondaryFont),
//                           ),
//                           onPressed: () {
//                             locator<TextEditingController>().clear();
//                             Navigator.pop(context);
//                             Navigator.pushReplacementNamed(
//                                 context, '/logInScreen');
//                           },
//                           color: greyBlue,
//                         ),
//                       ),
//                       ButtonTheme(
//                         minWidth: 100.0,
//                         height: 30.0,
//                         child: RaisedButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(25.0),
//                           ),
//                           child: Text(
//                             AppLocalizations.of(context)
//                                 .translate('notNow_str'),
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: SecondaryFont),
//                           ),
//                           onPressed: () {
//                             FocusScope.of(context)
//                                 .requestFocus(new FocusNode());
//                             Navigator.pop(context);
//                             // Navigator.pushReplacementNamed(Dia
//                             //     context, '/logInScreen');
//                           },
//                           color: greyBlue,
//                         ),
//                       ),]})

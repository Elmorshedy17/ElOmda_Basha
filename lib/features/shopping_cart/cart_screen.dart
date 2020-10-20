import 'package:flutter/material.dart';
import 'package:momentoo/features/checkout/checkout_screen.dart';
import 'package:momentoo/features/shopping_cart/cartActions_manager.dart';
import 'package:momentoo/features/shopping_cart/cartActions_model.dart';
import 'package:momentoo/shared/domain/cartRequest.dart' as cart;
import 'package:momentoo/shared/helper/cartItemsCount_manger.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/shared/widgets/no_available.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartActionsModel cartModel;
  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.2,

          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).translate('cart_Str'),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily:
                      locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
                ),
              ),
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
                NotificationWidget(
                  onPressedNotifications: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.of(context).pushNamed('/notificationsScreen');

                    locator<PrefsService>().notificationFlag = false;
                  },
                )
              ],
            ),
            body: locator<PrefsService>().userObj != null
                ? locator<PrefsService>().cartObj.products.isNotEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.symmetric(
                            horizontal: 1.0, vertical: 1.0),
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Card(
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: CustomObserver(
                                      stream: locator<CartActionsManager>()
                                          .getData(),
                                      onSuccess: (_, CartActionsModel model) {
                                        cartModel = model;
                                        return ListView.separated(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount:
                                              model.data.products?.length ?? 0,
                                          separatorBuilder: (_, index) {
                                            return Divider(
                                              height: 2,
                                            );
                                          },
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 150,
                                              child: Stack(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        height: 130.0,
                                                        width: 100.0,
                                                        child: Image.network(
                                                          model
                                                              .data
                                                              .products[index]
                                                              .image,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 190,
                                                        child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                          title: Text(
                                                            model
                                                                .data
                                                                .products[index]
                                                                .name,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  locator<PrefsService>()
                                                                              .appLanguage ==
                                                                          'en'
                                                                      ? 'en'
                                                                      : 'ar',
                                                            ),
                                                          ),
                                                          subtitle: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                '${model.data.products[index].price} ${model.data.products[index].currency}',
                                                                style:
                                                                    TextStyle(
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
                                                      ),
                                                    ],
                                                  ),
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? Positioned(
                                                          right: 1,
                                                          top: 1,
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .red
                                                                    .shade900,
                                                              ),
                                                              onPressed: () {
                                                                var removedFromCart =
                                                                    locator<PrefsService>()
                                                                        .cartObj;
                                                                removedFromCart
                                                                    .products
                                                                    .removeAt(
                                                                        index);
                                                                if (removedFromCart
                                                                    .products
                                                                    .isEmpty) {
                                                                  removedFromCart
                                                                      .sellerId = -1;
                                                                }
                                                                locator<PrefsService>()
                                                                        .cartObj =
                                                                    removedFromCart;
                                                                locator<CartItemsCountManager>()
                                                                    .inCartCount
                                                                    .add(locator<PrefsService>()
                                                                            .cartObj
                                                                            .products
                                                                            ?.length ??
                                                                        0);
                                                                if (locator<
                                                                        PrefsService>()
                                                                    .cartObj
                                                                    .products
                                                                    .isNotEmpty) {
                                                                  locator<CartActionsManager>()
                                                                      .getData();
                                                                } else {
                                                                  setState(
                                                                      () {});
                                                                }
                                                              }),
                                                        )
                                                      : Positioned(
                                                          left: 1,
                                                          top: 1,
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .red
                                                                    .shade900,
                                                              ),
                                                              onPressed: () {
                                                                var removedFromCart =
                                                                    locator<PrefsService>()
                                                                        .cartObj;
                                                                removedFromCart
                                                                    .products
                                                                    .removeAt(
                                                                        index);
                                                                if (removedFromCart
                                                                    .products
                                                                    .isEmpty) {
                                                                  removedFromCart
                                                                      .sellerId = -1;
                                                                }
                                                                locator<PrefsService>()
                                                                        .cartObj =
                                                                    removedFromCart;
                                                                locator<CartItemsCountManager>()
                                                                    .inCartCount
                                                                    .add(locator<PrefsService>()
                                                                            .cartObj
                                                                            .products
                                                                            ?.length ??
                                                                        0);
                                                                if (locator<
                                                                        PrefsService>()
                                                                    .cartObj
                                                                    .products
                                                                    .isNotEmpty) {
                                                                  locator<CartActionsManager>()
                                                                      .getData();
                                                                } else {
                                                                  setState(
                                                                      () {});
                                                                }
                                                              }),
                                                        ),
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? Positioned(
                                                          right: 1,
                                                          bottom: 1,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (locator<PrefsService>()
                                                                            .cartObj
                                                                            .products[index]
                                                                            .count >
                                                                        1) {
                                                                      var cart =
                                                                          locator<PrefsService>()
                                                                              .cartObj;
                                                                      cart
                                                                          .products[
                                                                              index]
                                                                          .count -= 1;
                                                                      locator<PrefsService>()
                                                                              .cartObj =
                                                                          cart;
                                                                      locator<CartActionsManager>()
                                                                          .getData();
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 25.0,
                                                                    height:
                                                                        12.5,
                                                                    decoration:
                                                                        new BoxDecoration(
                                                                      color: Colors
                                                                          .teal
                                                                          .shade900,
                                                                      borderRadius:
                                                                          new BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            13.0),
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: Text(
                                                                    model
                                                                        .data
                                                                        .products[
                                                                            index]
                                                                        .count,
                                                                    style: TextStyle(
                                                                        fontFamily: locator<PrefsService>().appLanguage ==
                                                                                'en'
                                                                            ? 'en'
                                                                            : 'ar',
                                                                        fontSize:
                                                                            25),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    var cart = locator<
                                                                            PrefsService>()
                                                                        .cartObj;
                                                                    cart
                                                                        .products[
                                                                            index]
                                                                        .count += 1;
                                                                    locator<PrefsService>()
                                                                            .cartObj =
                                                                        cart;
                                                                    locator<CartActionsManager>()
                                                                        .getData();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 25.0,
                                                                    height:
                                                                        12.5,
                                                                    decoration:
                                                                        new BoxDecoration(
                                                                      color: Colors
                                                                          .teal
                                                                          .shade900,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            13.0),
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Positioned(
                                                          left: 1,
                                                          bottom: 1,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (locator<PrefsService>()
                                                                            .cartObj
                                                                            .products[index]
                                                                            .count >
                                                                        1) {
                                                                      var cart =
                                                                          locator<PrefsService>()
                                                                              .cartObj;
                                                                      cart
                                                                          .products[
                                                                              index]
                                                                          .count -= 1;
                                                                      locator<PrefsService>()
                                                                              .cartObj =
                                                                          cart;
                                                                      locator<CartActionsManager>()
                                                                          .getData();
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 25.0,
                                                                    height:
                                                                        12.5,
                                                                    decoration:
                                                                        new BoxDecoration(
                                                                      color: Colors
                                                                          .teal
                                                                          .shade900,
                                                                      borderRadius:
                                                                          new BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            13.0),
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: Text(
                                                                    model
                                                                        .data
                                                                        .products[
                                                                            index]
                                                                        .count,
                                                                    style: TextStyle(
                                                                        fontFamily: locator<PrefsService>().appLanguage ==
                                                                                'en'
                                                                            ? 'en'
                                                                            : 'ar',
                                                                        fontSize:
                                                                            25),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    var cart = locator<
                                                                            PrefsService>()
                                                                        .cartObj;
                                                                    cart
                                                                        .products[
                                                                            index]
                                                                        .count += 1;
                                                                    locator<PrefsService>()
                                                                            .cartObj =
                                                                        cart;
                                                                    locator<CartActionsManager>()
                                                                        .getData();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 25.0,
                                                                    height:
                                                                        12.5,
                                                                    decoration:
                                                                        new BoxDecoration(
                                                                      color: Colors
                                                                          .teal
                                                                          .shade900,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            13.0),
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomObserver(
                                    stream:
                                        locator<CartActionsManager>().getData(),
                                    onSuccess: (_, CartActionsModel model) =>
                                        Card(
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            // contentPadding: EdgeInsets.symmetric(vertical: 4),
                                            title: Text(
                                              // 's0',
                                              AppLocalizations.of(context)
                                                  .translate('subtotal_str'),
                                              style: TextStyle(
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                            ),
                                            trailing: Text(
                                              '${model.data.getTotalPrice()} ${model.data.seller.currency}',
                                              style: TextStyle(
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                                // 'z',
                                                AppLocalizations.of(context)
                                                    .translate('Delivery_str'),
                                                style: TextStyle(
                                                  fontFamily:
                                                      locator<PrefsService>()
                                                                  .appLanguage ==
                                                              'en'
                                                          ? 'en'
                                                          : 'ar',
                                                )),
                                            trailing: Text(
                                                '${model.data.seller.deliveryFee} ${model.data.seller.currency}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      locator<PrefsService>()
                                                                  .appLanguage ==
                                                              'en'
                                                          ? 'en'
                                                          : 'ar',
                                                )),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                                // '3',
                                                AppLocalizations.of(context)
                                                    .translate('total_Str'),
                                                style: TextStyle(
                                                  fontFamily:
                                                      locator<PrefsService>()
                                                                  .appLanguage ==
                                                              'en'
                                                          ? 'en'
                                                          : 'ar',
                                                )),
                                            trailing: Text(
                                              '${model.data.getFinalPrice()} ${model.data.seller.currency}',
                                              style: TextStyle(
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 320.0,
                              height: 45.0,
                              child: RaisedButton(
                                color: Colors.teal.shade900,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('Checkout_str'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    '/checkOutScreen',
                                    arguments: CheckOutScreenArguments(
                                        finalPrice:
                                            cartModel.data.getFinalPrice(),
                                        seller: cartModel.data.seller,
                                        products: cartModel.data.products,
                                        addresses: cartModel.data.addresses,
                                        cities: cartModel.data.cities,
                                        country: cartModel.data.country),
                                  );
                                  print(
                                      'addresses*******${cartModel.data.addresses}');
                                  print(cartModel.data.country.name);
                                  print(
                                      'cities*******${cartModel.data.cities}');
                                  print(
                                      'seller*******${cartModel.data.seller.id}');
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : noAvailable(
                        AppLocalizations.of(context)
                            .translate('NoItemsInCart_str'),
                        Icons.shopping_basket_outlined)
                : needSignIn(context),
            // : noAvailable(AppLocalizations.of(context).translate('NoItemsInCart_str'),Icons.notifications_active_outlined),
            // Center(
            //         child: Text(
            //           AppLocalizations.of(context)
            //               .translate('NoItemsInCart_str'),
            //           style: TextStyle(
            //               fontSize: 40,
            //               fontFamily: locator<PrefsService>().appLanguage == 'en'  ? 'en'  : 'ar'),
            //         ),
            //       ),
            bottomNavigationBar: CustomBottomNavigation(),
          ),
        ),
      
    );
  }

  dispose() {
    super.dispose();
  }
}

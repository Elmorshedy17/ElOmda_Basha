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
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartActionsModel cartModel;
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.2,
      child: SafeArea(
        left: true,
        right: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'Cart',
              // AppLocalizations.of(context).translate('my_orders_Str'),
              // AppLocalizations.of(context).translate('test'),
              style: TextStyle(color: Colors.white),
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
                  Text(AppLocalizations.of(context).translate('back_str')),
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
              ),
            ],
          ),
          body: locator<PrefsService>().cartObj.products.isNotEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(8.0)),
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
                                stream: locator<CartActionsManager>().getData(),
                                onSuccess: (_, CartActionsModel model) {
                                  cartModel = model;
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: model.data.products?.length ?? 0,
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
                                                  padding: EdgeInsets.all(8),
                                                  height: 130.0,
                                                  width: 100.0,
                                                  child: Image.network(
                                                    model.data.products[index]
                                                        .image,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Container(
                                                  width: 190,
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    title: Text(
                                                      model.data.products[index]
                                                          .name,
                                                    ),
                                                    subtitle: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text('$index'),
                                                        Text(
                                                          model
                                                              .data
                                                              .products[index]
                                                              .price,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              right: 1,
                                              top: 1,
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.red.shade900,
                                                  ),
                                                  onPressed: () {
                                                    var removedFromCart =
                                                        locator<PrefsService>()
                                                            .cartObj;
                                                    removedFromCart.products
                                                        .removeAt(index);
                                                    if (removedFromCart
                                                        .products.isEmpty) {
                                                      removedFromCart.sellerId =
                                                          -1;
                                                    }
                                                    locator<PrefsService>()
                                                            .cartObj =
                                                        removedFromCart;
                                                    locator<CartItemsCountManager>()
                                                        .inCartCount
                                                        .add(
                                                            locator<PrefsService>()
                                                                    .cartObj
                                                                    .products
                                                                    ?.length ??
                                                                0);
                                                    if (locator<PrefsService>()
                                                        .cartObj
                                                        .products
                                                        .isNotEmpty) {
                                                      locator<CartActionsManager>()
                                                          .getData();
                                                    } else {
                                                      setState(() {});
                                                    }
                                                  }),
                                            ),
                                            Positioned(
                                              right: 1,
                                              bottom: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () {
                                                        if (locator<PrefsService>()
                                                                .cartObj
                                                                .products[index]
                                                                .count >
                                                            1) {
                                                          var cart = locator<
                                                                  PrefsService>()
                                                              .cartObj;
                                                          cart.products[index]
                                                              .count -= 1;
                                                          locator<PrefsService>()
                                                              .cartObj = cart;
                                                          locator<CartActionsManager>()
                                                              .getData();
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 25.0,
                                                        height: 12.5,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors
                                                              .teal.shade900,
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                13.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        model
                                                            .data
                                                            .products[index]
                                                            .count,
                                                        style: TextStyle(
                                                            fontSize: 25),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        var cart = locator<
                                                                PrefsService>()
                                                            .cartObj;
                                                        cart.products[index]
                                                            .count += 1;
                                                        locator<PrefsService>()
                                                            .cartObj = cart;
                                                        locator<CartActionsManager>()
                                                            .getData();
                                                      },
                                                      child: Container(
                                                        width: 25.0,
                                                        height: 12.5,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors
                                                              .teal.shade900,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                13.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
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
                              stream: locator<CartActionsManager>().getData(),
                              onSuccess: (_, CartActionsModel model) => Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      // contentPadding: EdgeInsets.symmetric(vertical: 4),
                                      title: Text('Subtotal'),
                                      trailing: Text(
                                          '${model.data.getTotalPrice()} ${model.data.seller.currency}'),
                                    ),
                                    ListTile(
                                      title: Text('Additional Fees'),
                                      trailing: Text(
                                          '${model.data.seller.deliveryFee} ${model.data.seller.currency}'),
                                    ),
                                    ListTile(
                                      title: Text('Delivery'),
                                      trailing: Text(
                                          '${model.data.seller.deliveryFee} ${model.data.seller.currency}'),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text('Total'),
                                      trailing: Text(
                                          '${model.data.getFinalPrice()} ${model.data.seller.currency}'),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/checkOutScreen',
                              arguments: CheckOutScreenArguments(
                                finalPrice: cartModel.data.getFinalPrice(),
                                seller: cartModel.data.seller,
                                products: cartModel.data.products,
                                addresses: cartModel.data.addresses,
                                cities: cartModel.data.cities,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'No items in Cart',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
          bottomNavigationBar: CustomBottomNavigation(),
        ),
      ),
    );
  }

  dispose() {
    super.dispose();
  }
}

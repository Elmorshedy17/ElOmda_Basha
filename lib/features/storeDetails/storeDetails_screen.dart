import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/features/product_details/productDetails_screen.dart';
import 'package:momentoo/features/storeDetails/storeDetails_manager.dart';
import 'package:momentoo/features/storeDetails/storeDetails_model.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class StoreDetailsArguments {
  final int categoryId;
  final int sellerId;

  StoreDetailsArguments({@required this.sellerId, @required this.categoryId});
}

class StoreDetailsScreen extends StatefulWidget {
  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  bool isSelected = false;
  int subIndex = -1;
  int mainIndex = -1;

  @override
  Widget build(BuildContext context) {
    StoreDetailsArguments args = ModalRoute.of(context).settings.arguments;

    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
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
            ),
          ],
        ),
        body: CustomObserver(
          stream: locator<StoreDetailsManager>().getData(args.sellerId),
          onSuccess: (_, StoreDetailsModel model) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal.shade900,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    model.data.seller.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                model.data.seller.name,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                model.data.seller.address,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List<Widget>.generate(
                  5,
                  (innerIndex) => Icon(
                    Icons.star,
                    color: innerIndex < model.data.seller.rate
                        ? Colors.pink
                        : Colors.grey,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50),
                      SingleChildScrollView(
                        primary: false,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('Delivery_str'),
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    model.data.seller.deliveryFee,
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('DeliveryTime_str'),
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    model.data.seller.deliveryTime,
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('status_str'),
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    model.data.seller.status,
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('workTime_str'),
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    model.data.seller.time,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 2, left: 4),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1000))),
                            child: IconButton(
                              icon: Transform.rotate(
                                  angle: 4.7,
                                  child: Icon(FontAwesomeIcons.signOutAlt)),
                              // icon: Icon(FontAwesomeIcons.shareSquare),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Icon(
                              model.data.seller.featured == 'yes'
                                  ? Icons.star
                                  : Icons.star_border,
                              color: model.data.seller.featured == 'yes'
                                  ? Colors.yellow[700]
                                  : Colors.grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                model.data.seller.favourite == 'yes'
                                    ? Icons.star
                                    : Icons.star_border,
                                color: model.data.seller.favourite == 'yes'
                                    ? Colors.pink
                                    : Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, right: 16, left: 16),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('featuredItems_str'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          reverse: locator<PrefsService>().appLanguage == 'ar'
                              ? true
                              : false,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              model.data.seller.productsFeatured?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/productDetailsScreen',
                                    arguments: ProductDetailsArguments(
                                        sellerId: model.data.seller.id,
                                        productId: model.data.seller
                                            .productsFeatured[index].id),
                                  );
                                },
                                child: FittedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 160,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.99,
                                        child: Card(
                                          child: Image.network(
                                            model.data.seller
                                                .productsFeatured[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          model.data.seller
                                              .productsFeatured[index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: locator<PrefsService>()
                                                        .appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          '${model.data.seller.productsFeatured[index].price} ${model.data.seller.productsFeatured[index].currency}',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: locator<PrefsService>()
                                                        .appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // child: cardsList[index],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                  .translate('menu_str'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : 'ar',
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              '${AppLocalizations.of(context).translate('viewAll_str')}>>',
                              style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: model.data.seller.menu?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return ExpansionTile(
                              initiallyExpanded: false,
                              onExpansionChanged: (bool isClicked) {
                                isSelected = isClicked;
                                mainIndex = index;
                              },
                              title: Row(
                                children: <Widget>[
                                  Text(
                                    model.data.seller.menu[index].name,
                                    // AppLocalizations.of(context)
                                    //     .translate('popularItems_str'),
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text(
                                    '${model.data.seller.menu[index].products?.length ?? 0}',
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 12),
                                  ),
                                ],
                              ),
                              children: List<Widget>.generate(
                                model.data.seller.menu[index].products
                                        ?.length ??
                                    0,
                                (int internalIndex) {
                                  return MyListTile(
                                    isSelected: isSelected,
                                    index: internalIndex,
                                    title: Text(
                                      '${model.data.seller.menu[index].products[internalIndex].name}',
                                      style: TextStyle(
                                          color: internalIndex == subIndex &&
                                                  mainIndex == index
                                              ? Colors.teal.shade900
                                              : Colors.black45),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        mainIndex = index;
                                        subIndex = internalIndex;
                                        // isSelected = true;
                                      });
                                      Navigator.of(context).pushNamed(
                                        '/productDetailsScreen',
                                        arguments: ProductDetailsArguments(
                                            sellerId: model.data.seller.id,
                                            productId: model
                                                .data
                                                .seller
                                                .menu[index]
                                                .products[internalIndex]
                                                .id),
                                      );
                                    },
                                    trailing: internalIndex == subIndex &&
                                            mainIndex == index
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Widget title;
  final Function onTap;
  final Widget trailing;
  MyListTile(
      {this.index, this.title, this.onTap, this.trailing, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      dense: true,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

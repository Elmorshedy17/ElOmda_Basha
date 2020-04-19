import 'package:flutter/material.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_widgets/ads_list.dart';
import 'package:momentoo/features/product_details/productDetails_screen.dart';
import 'package:momentoo/features/storeDetails/storeDetails_screen.dart';
import 'package:momentoo/features/trending_products/trendingProducts_screen.dart';
import 'package:momentoo/features/trending_stores/trendingStores_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class HomeContent extends StatelessWidget {
  final int categoryId;
  final String trendingSellersName;
  final String trendingProductName;
  final String sellersName;

  final List<Ads> adsList;
  final List<TrandingSellers> trendingSellersList;
  final List<TrandingProducts> trendingProductsList;
  final List<Sellers> sellersList;

  const HomeContent({
    @required this.categoryId,
    @required this.adsList,
    @required this.trendingSellersName,
    @required this.trendingProductName,
    @required this.sellersName,
    @required this.trendingSellersList,
    @required this.trendingProductsList,
    @required this.sellersList,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        adsList.length == 0
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context).translate('ads_str'),
                  style: TextStyle(
                      // fontSize:
                      //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                      fontWeight: FontWeight.bold),
                ),
              ),
        ////////////////////////////
        //! adsList
        ///////////////////////////
        CarouselWidgetHome(
          categoryId: categoryId,
          adsList: adsList,
        ),
        //////////////////////////
        //! View All trendingSellersList
        /////////////////////////
        Padding(
          padding: const EdgeInsets.all(
            8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                trendingSellersName,
                style: TextStyle(
                    // fontSize:
                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/trendingStoresScreen',
                    arguments: TrendingStoresArguments(categoryId: categoryId),
                  );
                },
                child: Text(
                  '${AppLocalizations.of(context).translate('viewAll_str')}>>',
                  style: TextStyle(
                    // fontSize:
                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    fontWeight: FontWeight.bold, color: Colors.teal.shade900,
                  ),
                ),
              )
            ],
          ),
        ),
        //////////////////////////
        //! trendingSellersList
        /////////////////////////
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
            scrollDirection: Axis.horizontal,
            itemCount: trendingSellersList?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/StoreDetailsScreen',
                          arguments: StoreDetailsArguments(
                            categoryId: categoryId,
                            sellerId: trendingSellersList[index].id,
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                trendingSellersList[index].image,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 120,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  trendingSellersList[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize:
                                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List<Widget>.generate(
                                    5,
                                    (innerIndex) => Icon(
                                      Icons.star,
                                      color: innerIndex <
                                              trendingSellersList[index].rate
                                          ? Colors.pink
                                          : Colors.grey,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[50],
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                          icon: Icon(
                            Icons.star,
                            color: sellersList[index].favourite == 'yes'
                                ? Colors.pink
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        //////////////////////////
        //! View All trendingProductsList
        ///////////////////////////
        Padding(
          padding: const EdgeInsets.all(
            8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                trendingProductName,
                style: TextStyle(
                    // fontSize:
                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/trendingProductsScreen',
                    arguments:
                        TrendingProductsArguments(categoryId: categoryId),
                  );
                },
                child: Text(
                  '${AppLocalizations.of(context).translate('viewAll_str')}>>',
                  style: TextStyle(
                    // fontSize:
                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    fontWeight: FontWeight.bold, color: Colors.teal.shade900,
                  ),
                ),
              )
            ],
          ),
        ),
        //////////////////////////
        //! trendingProductsList
        ///////////////////////////
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
            scrollDirection: Axis.horizontal,
            itemCount: trendingProductsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/productDetailsScreen',
                          arguments: ProductDetailsArguments(
                              productId: trendingProductsList[index].id),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                trendingProductsList[index].image,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 120,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  trendingProductsList[index].name,
                                  style: TextStyle(
                                      // fontSize:
                                      //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                                      fontFamily:
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  trendingProductsList[index].section,
                                  style: TextStyle(
                                    // fontSize:
                                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${trendingProductsList[index].price} ${trendingProductsList[index].currency}',
                                  style: TextStyle(
                                      // fontSize:
                                      //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                                      fontFamily:
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[50],
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                          icon: Icon(
                            Icons.star,
                            color: sellersList[index].favourite == 'yes'
                                ? Colors.pink
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        //////////////////
        //! View All sellersList
        ///////////////////
        Padding(
          padding: const EdgeInsets.all(
            8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                sellersName,
                style: TextStyle(
                    // fontSize:
                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/trendingStoresScreen',
                      arguments:
                          TrendingStoresArguments(categoryId: categoryId));
                },
                child: Text(
                  '${AppLocalizations.of(context).translate('viewAll_str')}>>',
                  style: TextStyle(
                    // fontSize:
                    //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                    fontWeight: FontWeight.bold, color: Colors.teal.shade900,
                  ),
                ),
              )
            ],
          ),
        ),
        //////////////////
        //! sellersList
        ///////////////////
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
            scrollDirection: Axis.horizontal,
            itemCount: sellersList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/StoreDetailsScreen',
                          arguments: StoreDetailsArguments(
                            categoryId: categoryId,
                            sellerId: sellersList[index].id,
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                sellersList[index].image,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 125,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(sellersList[index].name,
                                    style: TextStyle(
                                        // fontSize:
                                        //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(sellersList[index].cuisine,
                                    style: TextStyle(
                                        // fontSize:
                                        //     locator<PrefsService>().appLanguage == 'en' ? 12 : 11,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        color: Colors.black38)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List<Widget>.generate(
                                    5,
                                    (innerIndex) => Icon(
                                      Icons.star,
                                      color:
                                          innerIndex < sellersList[index].rate
                                              ? Colors.pink
                                              : Colors.grey,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[50],
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                          icon: Icon(
                            Icons.star,
                            color: sellersList[index].favourite == 'yes'
                                ? Colors.pink
                                : Colors.white,
                            size: 30,
                          ),
                          onPressed: () {}),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

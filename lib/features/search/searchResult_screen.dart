import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/features/favorites/favoriteActions_manager.dart';
import 'package:momentoo/features/product_details/productDetails_screen.dart';
import 'package:momentoo/features/search/filter_screen.dart';
import 'package:momentoo/features/search/search_manager.dart';
import 'package:momentoo/features/search/search_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class SearchResultsScreenArguments {
  final int categoryId;
  final String title;

  SearchResultsScreenArguments({
    @required this.categoryId,
    @required this.title,
  });
}

class SearchResultScreen extends StatefulWidget {
  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  int resultOfCategoryIdFromFilter = -1;

  void updateInformation(information) {
    setState(() => resultOfCategoryIdFromFilter = information);
  }

  @override
  Widget build(BuildContext context) {
    SearchResultsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    locator<SearchManager>().inCategoryId.add(resultOfCategoryIdFromFilter != -1
        ? resultOfCategoryIdFromFilter
        : args.categoryId);
    locator<SearchManager>().inQuery.add(args.title);

    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              locator<TextEditingController>().clear();
              Navigator.of(context).pop();
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back_ios),
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
          title: Text(args.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.filter,
                  size: 15,
                ),
                onPressed: () async {
                  final information = await Navigator.of(context).pushNamed(
                    '/filterScreen',
                    arguments:
                        FilterScreenArguments(categoryId: args.categoryId),
                  );
                  updateInformation(information);
                }),
          ],
        ),
        body: CustomObserver(
          stream: locator<SearchManager>().getData(),
          onSuccess: (_, SearchModel model) => GridView.builder(
            itemCount: model.data.products?.length ?? 0,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/productDetailsScreen',
                    arguments: ProductDetailsArguments(
                        productId: model.data.products[index].id,
                        sellerId: model.data.products[index].seller_id),
                  );
                },
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        width: 200,
                        height: 200,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                model.data.products[index].image,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 120,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  model.data.products[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                                child: Text(
                                  model.data.products[index].section,
                                  style: TextStyle(
                                    color: Colors.black38,
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
                                child: Text(
                                  '${model.data.products[index].price} ${model.data.products[index].currency}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
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
                      Positioned(
                          top: 15,
                          right: 5,
                          child: IconButton(
                              icon: Icon(
                                Icons.star,
                                color: model.data.products[index].favourite ==
                                        'yes'
                                    ? Color(0xffF52B57)
                                    : Colors.white,
                              ),
                              onPressed: () {
                                locator<FavoritesActionsManager>()
                                    .addOrRemoveFavorite(
                                        'product',
                                        model.data.products[index].favourite ==
                                                'yes'
                                            ? 'remove'
                                            : 'add',
                                        model.data.products[index].id
                                            .toString());
                                locator<SearchManager>().getData();
                              }))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

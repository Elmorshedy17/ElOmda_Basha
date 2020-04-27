import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/features/search/search_manager.dart';
import 'package:momentoo/features/search/search_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class FilterScreenArguments {
  final int categoryId;

  FilterScreenArguments({
    @required this.categoryId,
  });
}

class FilterScreen extends StatefulWidget {
  // final int categoryId;

  // const FilterScreen({Key key, @required this.categoryId}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int citiesIndex = -1;
  int categoriesIndex = -1;
  int productIndex = -1;
  int selectedCategoryId = -1;

  @override
  Widget build(BuildContext context) {
    FilterScreenArguments args = ModalRoute.of(context).settings.arguments;

    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: InkWell(
              onTap: () {
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
            title: Text(
              AppLocalizations.of(context).translate('filter_str'),
              style: TextStyle(
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.filter,
                  size: 15,
                ),
                onPressed: () {
                  // Navigator.of(context).pushNamed('/filterScreen');
                },
              ),
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: CustomObserver(
                stream: locator<SearchManager>().getData(),
                onSuccess: (_, SearchModel model) => Column(
                  children: <Widget>[
                    //! Category ExpansionTile
                    Container(
                      margin: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            // spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          AppLocalizations.of(context)
                              .translate('categories_str'),
                          style: TextStyle(
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                        backgroundColor: Colors.white,
                        children: List<Widget>.generate(
                            model.data.categories?.length ?? 0, (index) {
                          return ListTile(
                            title: Text(
                              model.data.categories[index].name,
                              style: TextStyle(
                                  color: categoriesIndex == index
                                      ? Colors.teal.shade900
                                      : Colors.black45),
                            ),
                            trailing: categoriesIndex == index
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.teal.shade900,
                                  )
                                : Container(
                                    height: 1,
                                    width: 1,
                                  ),
                            onTap: () {
                              setState(() {
                                categoriesIndex = index;
                                selectedCategoryId =
                                    model.data.categories[index].id ?? -1;
                              });
                              locator<SearchManager>().inCategoryId.add(
                                  model.data.categories[index].id ??
                                      args.categoryId);
                            },
                          );
                        }),
                      ),
                    ),
                    //! Product type ExpansionTile
                    Container(
                      margin: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            // spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          AppLocalizations.of(context).translate('type_str'),
                          style: TextStyle(
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                        backgroundColor: Colors.white,
                        children: List<Widget>.generate(
                            model.data.cuisines?.length ?? 0, (index) {
                          return ListTile(
                            title: Text(
                              model.data.cuisines[index].name,
                              style: TextStyle(
                                  color: productIndex == index
                                      ? Colors.teal.shade900
                                      : Colors.black45),
                            ),
                            trailing: productIndex == index
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.teal.shade900,
                                  )
                                : Container(
                                    height: 1,
                                    width: 1,
                                  ),
                            onTap: () {
                              setState(() {
                                productIndex = index;
                              });
                              locator<SearchManager>().inCuisineId.add(
                                  model.data.cuisines[index].id.toString() ??
                                      '');
                            },
                          );
                        }),
                      ),
                    ),
                    //! Area ExpansionTile
                    Container(
                      margin: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            // spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      child: ExpansionTile(
                        // key: GlobalKey(),
                        title: Text(
                          AppLocalizations.of(context).translate('area_str'),
                          style: TextStyle(
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                        backgroundColor: Colors.white,
                        children: List<Widget>.generate(
                            model.data.cities?.length ?? 0, (index) {
                          return ListTile(
                            title: Text(
                              model.data.cities[index].name,
                              style: TextStyle(
                                  color: citiesIndex == index
                                      ? Colors.teal.shade900
                                      : Colors.black45),
                            ),
                            trailing: citiesIndex == index
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.teal.shade900,
                                  )
                                : Container(
                                    height: 1,
                                    width: 1,
                                  ),
                            onTap: () {
                              setState(() {
                                citiesIndex = index;
                              });
                              locator<SearchManager>().inCityId.add(
                                  model.data.cuisines[index].id.toString() ??
                                      '');
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: ListTile(
            title: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                color: Colors.teal.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.white24),
                ),
                child: Text(
                  AppLocalizations.of(context).translate('Done_str'),
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, selectedCategoryId);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

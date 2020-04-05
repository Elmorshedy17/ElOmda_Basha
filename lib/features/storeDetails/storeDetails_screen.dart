import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/shared/widgets/custom_card.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({Key key}) : super(key: key);

  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  bool isSelected = false;
  int subIndex = -1;
  int mainIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.15,
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
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              ListTile(
                title: Text(
                  'Store Name',
                  style: TextStyle(fontSize: 20, color: Colors.teal.shade900),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Store Area',
                      style: TextStyle(fontSize: 16, color: Colors.black38),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.solidStar,
                          size: 15,
                          color: Colors.black38,
                        ),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          size: 15,
                          color: Colors.black38,
                        ),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          size: 15,
                          color: Colors.black38,
                        ),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          size: 15,
                          color: Colors.black38,
                        ),
                        Icon(
                          FontAwesomeIcons.star,
                          size: 15,
                          color: Colors.black38,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Text('(333 Reviews)')
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate('Delivery_str'),
                        style: TextStyle(
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context).translate('free_str'),
                        style: TextStyle(
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate('openTime_str'),
                        style: TextStyle(
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                      subtitle: Text('8:00 AM'),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 2, left: 4),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(1000))),
                    child: IconButton(
                      // icon: Transform.rotate(
                      //     angle: 4.7, child: Icon(FontAwesomeIcons.signOutAlt)),
                      icon: Icon(FontAwesomeIcons.shareSquare),
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
                        Icons.star_border,
                      ),
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
                      icon: Icon(Icons.location_on),
                      onPressed: () {},
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: RaisedButton(
                      color: Colors.white,
                      child: Text(
                        AppLocalizations.of(context).translate('contact_str'),
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.teal.shade900)),
                    ),
                  )
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Text(
                  AppLocalizations.of(context).translate('featuredItems_str'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
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
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      child: cards[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('menu_str'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('viewAll>>_str'),
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
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
                  itemCount: 2,
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
                            AppLocalizations.of(context)
                                .translate('popularItems_str'),
                            style: TextStyle(
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
                            '55',
                            style:
                                TextStyle(color: Colors.black26, fontSize: 12),
                          ),
                        ],
                      ),
                      children: List<Widget>.generate(
                        5,
                        (int internalIndex) {
                          return MyListTile(
                            isSelected: isSelected,
                            index: internalIndex,
                            title: Text(
                              'data',
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
                            },
                            trailing:
                                internalIndex == subIndex && mainIndex == index
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
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
            child: Column(
              children: <Widget>[
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
                      AppLocalizations.of(context).translate('restaurant_str'),
                      style: TextStyle(
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                    backgroundColor: Colors.white,
                    children: <Widget>[
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                ),
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
                      AppLocalizations.of(context).translate('food_str'),
                      style: TextStyle(
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                    backgroundColor: Colors.white,
                    children: <Widget>[
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                ),
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
                      AppLocalizations.of(context).translate('area_str'),
                      style: TextStyle(
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                    backgroundColor: Colors.white,
                    children: <Widget>[
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                ),
              ],
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
                  fontFamily:
                      locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

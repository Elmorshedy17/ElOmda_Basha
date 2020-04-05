import 'package:flutter/material.dart';
import 'package:momentoo/features/new_address/cityDropdown.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class NewAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
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
        body: Column(
          children: <Widget>[
            Center(
              child: Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 60,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('newAddress_str'),
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height,
                child: Card(
                  elevation: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.grey[200],
//                        elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            child: Align(
                              alignment:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('Kuwait_str'),
                                style: TextStyle(
                                  color: Colors.teal.shade900,
//                              fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                              ),
                            ),
                          ),
                        ),
                        CityDropdown(),
                        Container(
                          padding: EdgeInsets.all(4),
                          // width: MediaQuery.of(context).size.width * 0.8,
                          // height: 60,
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Block_Str'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Street_str'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                                hintText: AppLocalizations.of(context)
                                    .translate('Street_two_str'),
                                fillColor: Colors.grey[200]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                                hintText: AppLocalizations.of(context)
                                    .translate('House_building_str'),
                                fillColor: Colors.grey[200]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          // width: MediaQuery.of(context).size.width * 0.8,
                          // height: 60,
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Floor_Str'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Jadda_str'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: TextField(
                            decoration: InputDecoration(
                                suffixText: AppLocalizations.of(context)
                                    .translate('optional_Str'),
                                suffixStyle: TextStyle(
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                                hintText: AppLocalizations.of(context)
                                    .translate('Apartment_Office_name'),
                                fillColor: Colors.grey[200]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: TextField(
                            decoration: InputDecoration(
                                suffixText: AppLocalizations.of(context)
                                    .translate('optional_Str'),
                                suffixStyle: TextStyle(
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                                hintText: AppLocalizations.of(context)
                                    .translate('Delivery_instructions'),
                                fillColor: Colors.grey[200]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ListTile(
          title: ButtonTheme(
            height: 45,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              color: Colors.teal.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.white24),
              ),
              child: Text(
                AppLocalizations.of(context).translate('saveThisAddress_str'),
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

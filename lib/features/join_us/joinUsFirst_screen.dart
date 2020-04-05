import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class JoinUsFirstScreen extends StatefulWidget {
  @override
  _JoinUsFirstScreenState createState() => _JoinUsFirstScreenState();
}

class _JoinUsFirstScreenState extends State<JoinUsFirstScreen> {
  File _image;

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
          title: Text(
            AppLocalizations.of(context).translate('joinUs_str'),
            style: TextStyle(
              fontFamily:
                  locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
            ),
          ),
          centerTitle: true,
        ),
        body: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Column(
            children: <Widget>[
              Center(
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('details_str'),
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                        Text(
                          '1/2',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height,
                  child: Card(
                    elevation: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.09),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              child: ListTile(
                                onTap: getImageFromGallery,
                                leading: Icon(Icons.camera_alt),
                                title: Text(
                                  AppLocalizations.of(context)
                                      .translate('yourLOGO_str'),
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                                trailing: FittedBox(
                                  child: _image == null
                                      ? Icon(Icons.add)
                                      : Image.file(_image),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              right: 4,
                              left: 4,
                            ),
                            child: Container(
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
                                        .translate('companyName_str'),
                                    fillColor: Colors.grey[200]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              right: 4,
                              left: 4,
                            ),
                            child: Container(
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
                                        .translate('address_str'),
                                    fillColor: Colors.grey[200]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              right: 4,
                              left: 4,
                            ),
                            child: Container(
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
                                        .translate('contactNumber_str'),
                                    fillColor: Colors.grey[200]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              right: 4,
                              left: 4,
                            ),
                            child: Container(
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
                                        .translate('email_str'),
                                    fillColor: Colors.grey[200]),
                              ),
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
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          child: ListTile(
            title: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                color: Colors.teal.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.white24),
                ),
                child: Text(
                  AppLocalizations.of(context).translate('next_str'),
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/joinUsSecondScreen');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

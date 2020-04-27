import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:momentoo/features/join_us/_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class JoinUsFirstScreen extends StatefulWidget {
  @override
  _JoinUsFirstScreenState createState() => _JoinUsFirstScreenState();
}

class _JoinUsFirstScreenState extends State<JoinUsFirstScreen> {
  File _image;
  var imago;

  final nameFocus = FocusNode();
  final addressFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final deliveryFocus = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController deliveryController = TextEditingController();
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      imago = image.path;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      imago = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
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
            child: StreamBuilder(
                stream: isLoading.stream,
                builder: (context, isLoadingSnapshot) {
                  return Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15.0),
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
                                          color:
                                              Colors.black12.withOpacity(0.09),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10.0),
                                          ),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      FlatButton(
                                                        onPressed:
                                                            getImageFromCam,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'camera_str'),
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        onPressed:
                                                            getImageFromGallery,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'gallery_str'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
//                                  AppLocalizations.of(context)
//                                      .translate('yourLOGO_str'),
                                                );
                                              },
                                            );
                                          },
                                          leading: Icon(Icons.camera_alt),
                                          title: Text(
                                            AppLocalizations.of(context)
                                                .translate('yourLOGO_str'),
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
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
                                          textInputAction: TextInputAction.next,
                                          focusNode: nameFocus,
                                          controller: nameController,
                                          onSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(addressFocus);
                                          },
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                              hintText: AppLocalizations.of(
                                                      context)
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
                                          textInputAction: TextInputAction.next,
                                          focusNode: addressFocus,
                                          controller: addressController,
                                          onSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(phoneFocus);
                                          },
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                              hintText:
                                                  AppLocalizations.of(context)
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
                                          textInputAction: TextInputAction.next,
                                          focusNode: phoneFocus,
                                          controller: phoneController,
                                          onSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(emailFocus);
                                          },
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                              hintText:
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'contactNumber_str'),
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
                                          textInputAction: TextInputAction.next,
                                          focusNode: emailFocus,
                                          controller: emailController,
                                          onSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(deliveryFocus);
                                          },
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                              hintText:
                                                  AppLocalizations.of(context)
                                                      .translate('email_str'),
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
                                          textInputAction: TextInputAction.done,
                                          focusNode: deliveryFocus,
                                          controller: deliveryController,
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                              ),
                                              hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                              ),
                                              hintText: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'number_delivery_str'),
                                              fillColor: Colors.grey[200]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            child: ListTile(
                              title: ButtonTheme(
                                height: 55.0,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                                child: RaisedButton(
                                  color: Colors.teal.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.white24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('send_str'),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white70,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
//                  Navigator.of(context).pushNamed('/joinUsSecondScreen');
                                    if (imago == null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'image_joinus_erre')),
                                          );
                                        },
                                      );
                                    } else {
                                      isLoading.add(true);

                                      JoinUsRepo.postJoinUsData(
                                              nameController.text,
                                              addressController.text,
                                              emailController.text,
                                              phoneController.text,
                                              imago,
                                              int.parse(
                                                  deliveryController.text))
                                          .then((onValue) {
                                        isLoading.add(false);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(onValue.message),
                                            );
                                          },
                                        );
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      isLoading.value == true
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                  child: Container(
//                      color: mainColor,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )),
                            )
                          : Container(),
                    ],
                  );
                }),
          ),
//        bottomNavigationBar: Container(
//          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
//          child: ListTile(
//            title: ButtonTheme(
//              minWidth: MediaQuery.of(context).size.width * 0.8,
//              child: RaisedButton(
//                color: Colors.teal.shade900,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  side: BorderSide(color: Colors.white24),
//                ),
//                child: Text(
//                  AppLocalizations.of(context).translate('next_str'),
//                  style: TextStyle(
//                    color: Colors.white70,
//                    fontFamily: locator<PrefsService>().appLanguage == 'en'
//                        ? 'en'
//                        : 'ar',
//                  ),
//                ),
//                onPressed: () {
//                  Navigator.of(context).pushNamed('/joinUsSecondScreen');
//                },
//              ),
//            ),
//          ),
//        ),
        ),
      ),
    );
  }

  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    deliveryController.dispose();
    isLoading.close();
    super.dispose();
  }
}

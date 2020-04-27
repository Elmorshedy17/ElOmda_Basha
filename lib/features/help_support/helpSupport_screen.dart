import 'package:flutter/material.dart';
import 'package:momentoo/features/help_support/get_help_support/_manger.dart';
import 'package:momentoo/features/help_support/get_help_support/_model.dart';
import 'package:momentoo/features/help_support/post_help_support/_repo.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class HelpSupportScreen extends StatefulWidget {
  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);
  BehaviorSubject typeComplain = new BehaviorSubject();
//  BehaviorSubject complainId = new BehaviorSubject();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  var complainId;

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('help&support_str'),
              style: TextStyle(
                color: Colors.white,
//              fontSize: 25,
//              fontWeight: FontWeight.bold,
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
              ),
            ),
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
          body: StreamBuilder(
              stream: isLoading.stream,
              builder: (context, isLoadingSnapshot) {
                return Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: CustomObserver(
                          stream: locator<ContactUsManager>().getData(),
                          onSuccess: (_, ContactUsGetModel model) {
                            return Column(
                              children: <Widget>[
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
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
                                                      hintText: AppLocalizations
                                                              .of(context)
                                                          .translate(
                                                              'yourName_str'),
                                                      fillColor: Colors.white),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 1,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.grey
                                                        .withOpacity(.5),
                                                  ),
                                                ),
                                                TextField(
                                                  controller: emailController,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
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
                                                      hintText: AppLocalizations
                                                              .of(context)
                                                          .translate(
                                                              'yourEmail_str'),
                                                      fillColor: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Card(
                                          elevation: 5,
                                          child: TextField(
                                            controller: phoneController,
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            decoration: InputDecoration(
                                                filled: true,
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
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
                                                            'phoneNumber_str'),
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(4),
                                        // width: MediaQuery.of(context).size.width * 0.9,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              // spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: Offset(0,
                                                  5), // changes position of shadow
                                            ),
                                          ],
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius: new BorderRadius.all(
                                            const Radius.circular(5.0),
                                          ),
                                        ),
                                        child: StreamBuilder(
                                            stream: typeComplain.stream,
                                            builder: (context,
                                                typeComplainSnapshot) {
                                              return ExpansionTile(
                                                title: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'typeOfComplaint_str'),
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(.6),
                                                        fontFamily:
                                                            locator<PrefsService>()
                                                                        .appLanguage ==
                                                                    'en'
                                                                ? 'en'
                                                                : 'ar',
                                                      ),
                                                    ),
                                                    typeComplainSnapshot.hasData
                                                        ? Text(
                                                            typeComplainSnapshot
                                                                .data,
                                                            style: TextStyle(
                                                              color: Colors.teal
                                                                  .shade900,
                                                              fontFamily:
                                                                  locator<PrefsService>()
                                                                              .appLanguage ==
                                                                          'en'
                                                                      ? 'en'
                                                                      : 'ar',
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
//                                      subtitle: ,
                                                backgroundColor: Colors.white,
                                                children: <Widget>[
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: model.data
                                                        .complaintTypes.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          typeComplain.add(model
                                                              .data
                                                              .complaintTypes[
                                                                  index]
                                                              .name);
//                                                    complainId.add( model.data.complaintTypes[index].id);
                                                          complainId = model
                                                              .data
                                                              .complaintTypes[
                                                                  index]
                                                              .id;
                                                          print(
                                                              "complainId $complainId");
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          margin:
                                                              EdgeInsets.all(8),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                //                    <--- top side
                                                                color:
                                                                    Colors.grey,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                          ),
//                              padding: const EdgeInsets.all(8.0),
                                                          child: Center(
                                                            child: Text(
                                                              model
                                                                  .data
                                                                  .complaintTypes[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 15),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
//                      height: 600,
                                          child: TextField(
                                            controller: messageController,
                                            maxLines: 10,
                                            decoration: InputDecoration(
                                                filled: true,
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
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
                                                            'yourMessage_str'),
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      ),
//                    Padding(
//                      padding: const EdgeInsets.symmetric(
//                          vertical: 30.0, horizontal: 16),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          StreamBuilder(
//                              initialData: true,
//                              stream: locator<HelpSupportValidationManager>()
//                                  .checkBoxValue$,
//                              builder: (context, snapshot) {
//                                return Checkbox(
//                                  activeColor: Colors.teal.shade800,
//                                  hoverColor: Colors.teal.shade800,
//                                  checkColor: Colors.white,
//                                  focusColor: Colors.teal.shade800,
//                                  value: snapshot.data,
//                                  onChanged: (value) {
//                                    locator<HelpSupportValidationManager>()
//                                        .setCheckBoxValue(value);
//                                  },
//                                );
//                              }),
//                          Text(
//                            AppLocalizations.of(context)
//                                .translate('iAgreeToThe_str'),
//                            style: TextStyle(
//                              color: Colors.black26,
//                              fontFamily:
//                                  locator<PrefsService>().appLanguage == 'en'
//                                      ? 'en'
//                                      : 'ar',
//                            ),
//                          ),
//                          SizedBox(
//                            width: 2,
//                          ),
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Text(
//                                AppLocalizations.of(context)
//                                    .translate('termsAndConditions_str'),
//                                style: TextStyle(
//                                  color: Colors.teal.shade300,
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage == 'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                              ),
//                              Container(
//                                padding: EdgeInsets.only(left: 4),
//                                width: 135,
//                                height: 0.5,
//                                color: Colors.teal.shade300,
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 2),
                                        child: ButtonTheme(
                                          height: 55,
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: RaisedButton(
                                            color: Colors.teal.shade900,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                  color: Colors.white24),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('sendMessage_str'),
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily:
                                                      locator<PrefsService>()
                                                                  .appLanguage ==
                                                              'en'
                                                          ? 'en'
                                                          : 'ar',
                                                  fontSize: 18.0),
                                            ),
                                            onPressed: () {
                                              isLoading.add(true);

                                              ContactUsPostRepo
                                                      .postContactUsData(
                                                          nameController.text,
                                                          emailController.text,
                                                          phoneController.text,
                                                          complainId,
                                                          messageController
                                                              .text)
                                                  .then((onValue) {
                                                isLoading.add(false);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text(onValue.message),
                                                    );
                                                  },
                                                );
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
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
      ),
    );
  }

  @override
  void dispose() {
    typeComplain.close();
    isLoading.close();
//    complainId.close();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }
}

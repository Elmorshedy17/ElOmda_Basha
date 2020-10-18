import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:momentoo/features/change_password/changePassword_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

import 'change_password_validation_manger.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordFocus = FocusNode();
  final newPasswordFocus = FocusNode();
  final newConfirmPasswordFocus = FocusNode();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);
  final validationManager = locator<ChangePasswordValidationManager>();

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.transparent,
          body: StreamBuilder(
              stream: isLoading.stream,
              builder: (context, isLoadingSnapshot) {
                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AppBar(
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                          leading: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 15,
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('back_str'),
                                  style: TextStyle(
                                      fontFamily:
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar'),
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                            AppLocalizations.of(context)
                                .translate('changePassword_str'),
                            style: TextStyle(
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : 'ar'),
                          ),
                          centerTitle: true,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ListTile(
                          title: Card(
                            margin: EdgeInsets.only(top: 12),
                            elevation: 5,
                            child: StreamBuilder(
                                stream: validationManager.oldPassword$,
                                builder: (context, snapshot) {
                                return TextField(
                                  onChanged: (v){
                                    validationManager.inOldPassword.add(v);
                                  },
                                  textInputAction: TextInputAction.next,
                                  focusNode: oldPasswordFocus,
                                  controller: oldPasswordController,
                                  onSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(newPasswordFocus);
                                  },
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
                                                  : 'ar'),
                                      hintText: AppLocalizations.of(context)
                                          .translate('old_password_str'),
                                      fillColor: Colors.white,
                                    errorText: snapshot.error,
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                        ListTile(
                          title: Card(
                            margin: EdgeInsets.symmetric(vertical: 0.0),
                            elevation: 5,
                            child: StreamBuilder(
                                stream: validationManager.password$,
                                builder: (context, snapshot) {
                                return TextField(
                                  onChanged: (v){
                                    validationManager.inPassword.add(v);
                                  },
                                  textInputAction: TextInputAction.next,
                                  focusNode: newPasswordFocus,
                                  controller: newPasswordController,
                                  onSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(newConfirmPasswordFocus);
                                  },
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
                                                  : 'ar'),
                                      hintText: AppLocalizations.of(context)
                                          .translate('newPassword_str'),
                                      fillColor: Colors.white,
                                    errorText: snapshot.error,
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                        ListTile(
                          title: Card(
                            margin: EdgeInsets.symmetric(vertical: 0.0),
                            elevation: 5,
                            child: StreamBuilder(
                                stream: validationManager.newPassword$,
                                builder: (context, snapshot) {
                                return TextField(
                                  onChanged: (v){
                                    validationManager.inNewPassword.add(v);
                                  },
                                  textInputAction: TextInputAction.done,
                                  focusNode: newConfirmPasswordFocus,
                                  controller: confirmPasswordController,
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
                                                  : 'ar'),
                                      hintText: AppLocalizations.of(context)
                                          .translate('retypeNewPassword_str'),
                                      fillColor: Colors.white,
                                    errorText: snapshot.error,
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.all(15.0),
                          child: StreamBuilder(
                              stream: validationManager.isFormValid$,
                            builder: (context, snapshot) {
                              return ButtonTheme(
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width * 0.8,
                                child: RaisedButton(
                                  color: Colors.teal.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.white24),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('save_str'),
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily:
                                            locator<PrefsService>().appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar'),
                                  ),
                                  onPressed:snapshot.hasData ? () {
                                    if(newPasswordController.text != confirmPasswordController.text){
                                      Fluttertoast.showToast(
                                        msg: locator<PrefsService>().appLanguage == "en" ? "password doesn't match": 'كلمة السر غير متطابقة',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.black.withOpacity(0.6),
                                        textColor: Colors.white,
                                        fontSize: 14.0,
                                      );
                                    }else{
                                      isLoading.add(true);
                                      ChangePasswordRepo.postChangePasswordData(
                                          oldPasswordController.text,
                                          newPasswordController.text,
                                          confirmPasswordController.text)
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
                                  }:null,
                                ),
                              );
                            }
                          ),
                        ),
                      ),
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
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    isLoading.close();
    super.dispose();
  }
}

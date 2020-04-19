import 'package:flutter/material.dart';
import 'package:momentoo/features/change_email/changeEmail_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class ChangeEmailScreen extends StatefulWidget {
  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final oldEmailFocus = FocusNode();
  final newEmailFocus = FocusNode();
  final newConfirmEmailFocus = FocusNode();

  TextEditingController oldEmailController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();

  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    return MainBackground(
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
                              .translate('changeYourEmail_str'),
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
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            focusNode: oldEmailFocus,
                            controller: oldEmailController,
                            onSubmitted: (v) {
                              FocusScope.of(context)
                                  .requestFocus(newEmailFocus);
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
                                    .translate('currentEmail_str'),
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Card(
                          margin: EdgeInsets.symmetric(vertical: 0.0),
                          elevation: 5,
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            focusNode: newEmailFocus,
                            controller: newEmailController,
                            onSubmitted: (v) {
                              FocusScope.of(context)
                                  .requestFocus(newConfirmEmailFocus);
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
                                    .translate("new_email_str"),
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Card(
                          margin: EdgeInsets.symmetric(vertical: 0.0),
                          elevation: 5,
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            focusNode: newConfirmEmailFocus,
                            controller: confirmEmailController,
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
                                    .translate('confirm_new_email_str'),
                                fillColor: Colors.white),
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
                        child: ButtonTheme(
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
                            onPressed: () {
                              isLoading.add(true);

                              ChangeEmailRepo.postChangeEmailData(
                                      oldEmailController.text,
                                      newEmailController.text,
                                      confirmEmailController.text)
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
                            },
                          ),
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
    );
  }

  @override
  void dispose() {
    oldEmailController.dispose();
    newEmailController.dispose();
    confirmEmailController.dispose();
    isLoading.close();
    super.dispose();
  }
}

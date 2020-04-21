import 'package:flutter/material.dart';
import 'package:momentoo/features/forget_password/forgetPassword_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: StreamBuilder(
          stream: isLoading.stream,
          builder: (context, isLoadingSnapshot) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: (MediaQuery.of(context).size.height * 0.1) - 40,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                        child: Image.asset(
                      'assets/images/welcome_logo.png',
                      height: (MediaQuery.of(context).size.height * 0.3) - 130,
                      color: Colors.white,
                      // fit: BoxFit.scaleDown,
                    )),
                  ),
                ),
                Scaffold(
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
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : 'ar',
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                          .translate('forgetPassword_str'),
                      style: TextStyle(
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        height: 500,
                        // height: (MediaQuery.of(context).size.height),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                AppLocalizations.of(context)
                                    .translate('forgetPasswordInstruction_str'),
                                style: TextStyle(
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ListTile(
                              title: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      // spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),focusedBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                      disabledBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
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
                                          .translate('enterYourEmail_str'),
                                      fillColor: Colors.white70),
                                ),
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
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            AppLocalizations.of(context).translate('send_str'),
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : 'ar',
                            ),
                          ),
                        ),
                        onPressed: () {
                          isLoading.add(true);

                          ForgetPasswordRepo.postForgetPasswordData(
                                  emailController.text)
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
                Positioned(
                  bottom: 13,
                  right: 0,
                  left: 0,
                  child: Container(),
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
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    isLoading.close();
    super.dispose();
  }
}

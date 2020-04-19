import 'package:flutter/material.dart';
import 'package:momentoo/features/sign_in/signIn_repo.dart';
import 'package:momentoo/features/sign_in/signInValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final validationManager = locator<SignInValidationManager>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: isLoading.stream,
        builder: (context, isLoadingSnapshot) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/images/sign_in.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('signIn_str'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : "ar",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('signToContinue_str'),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontFamily:
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'en'
                                      : "ar",
                            ),
                          ),
                        ),
                        StreamBuilder(
                          stream: validationManager.email$,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: emailController,
                              onChanged: (value) {
                                validationManager.inEmail.add(value);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                labelText: AppLocalizations.of(context)
                                    .translate('email_str'),
                                labelStyle: TextStyle(
                                  color: Colors.white24,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : "ar",
                                ),
                                errorText: snapshot.error,
                              ),
                            );
                          },
                        ),
                        StreamBuilder(
                            stream: validationManager.password$,
                            builder: (context, snapshot) {
                              return TextField(
                                controller: passwordController,
                                onChanged: validationManager.inPassword.add,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  labelText: AppLocalizations.of(context)
                                      .translate('password_str'),
                                  labelStyle: TextStyle(
                                    color: Colors.white24,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : "ar",
                                  ),
                                  errorText: snapshot.error,
                                ),
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            StreamBuilder(
                                initialData: true,
                                stream: validationManager.checkBoxValue$,
                                builder: (context, snapshot) {
                                  return Checkbox(
                                    activeColor: Colors.white,
                                    hoverColor: Colors.white,
                                    checkColor: Colors.teal.shade800,
                                    focusColor: Colors.white,
                                    value: snapshot.data,
                                    onChanged: (value) {
                                      validationManager.setCheckBoxValue(value);
                                    },
                                  );
                                }),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('rememberMe_str'),
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : "ar",
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                                child: StreamBuilder(
                                    stream: validationManager.isFormValid$,
                                    builder: (context, snapshot) {
                                      return RaisedButton(
                                        color: Colors.teal.shade900,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side:
                                              BorderSide(color: Colors.white24),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate('signIn_str'),
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : "ar",
                                            ),
                                          ),
                                        ),
                                        onPressed: snapshot.hasData
                                            ? () async {
                                                isLoading.add(true);

                                                LoginRepo.postLoginData(
                                                        emailController.text,
                                                        passwordController.text)
                                                    .then((onValue) {
                                                  isLoading.add(false);
                                                  if (onValue.status == 1) {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            '/homeScreen');
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              onValue.message),
                                                        );
                                                      },
                                                    );
                                                  }
                                                });
                                              }
                                            : null,
                                      );
                                    }),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/forgetPasswordScreen');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('forgetYourPassword?_str'),
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/homeScreen');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('continueAsGuest_str'),
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontFamily:
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : "ar",
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('doNotHaveAnAccount?_str'),
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : "ar",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/signUpScreen');
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('signUp_str'),
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : "ar",
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 1,
                                            color: Colors.white70,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
            ),
          );
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isLoading.close();
    super.dispose();
  }
}

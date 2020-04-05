import 'package:flutter/material.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class SignUpScreen extends StatelessWidget {
  final validationManager = locator<SignUpValidationManager>();
  final btnFocus = FocusNode();
  final middleNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final addressFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // padding: MediaQuery.of(context).viewInsets,
          child: Image.asset(
            'assets/images/sign_in.png',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomPadding: true,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      AppLocalizations.of(context).translate('signUp_str'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: validationManager.firstName$,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(middleNameFocus);
                        },
                        onChanged: (value) {
                          validationManager.inFirstName.add(value);
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('first_name_str'),
                          labelStyle: TextStyle(
                            color: Colors.white24,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: validationManager.middleName$,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(lastNameFocus);
                        },
                        focusNode: middleNameFocus,
                        onChanged: validationManager.inMiddleName.add,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixText: AppLocalizations.of(context)
                              .translate('optional_Str'),
                          suffixStyle: TextStyle(
                            color: Colors.white24,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('middleName_str'),
                          labelStyle: TextStyle(
                            color: Colors.white24,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: validationManager.lastName$,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(addressFocus);
                        },
                        focusNode: lastNameFocus,
                        onChanged: validationManager.inLastName.add,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('last_name_str'),
                          labelStyle: TextStyle(
                            color: Colors.white24,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: validationManager.address$,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(phoneFocus);
                        },
                        focusNode: addressFocus,
                        onChanged: validationManager.inAddress.add,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('address_str'),
                          labelStyle: TextStyle(
                            color: Colors.white24,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: validationManager.phone$,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(emailFocus);
                        },
                        focusNode: phoneFocus,
                        keyboardType: TextInputType.number,
                        onChanged: validationManager.inPhone.add,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_iphone,
                            color: Colors.white,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('phoneNumber_str'),
                          labelStyle: TextStyle(
                            color: Colors.white24,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: validationManager.email$,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(passwordFocus);
                        },
                        focusNode: emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: validationManager.inEmail.add,
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
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
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
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(confirmFocus);
                        },
                        focusNode: passwordFocus,
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
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: validationManager.passwordConfirmation$,
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          FocusScope.of(context).requestFocus(btnFocus);
                        },
                        focusNode: confirmFocus,
                        onChanged: validationManager.inPasswordConfirmation.add,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('confirmPassword_str'),
                          labelStyle: TextStyle(
                            color: Colors.white24,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                        validationManager
                                            .setCheckBoxValue(value);
                                      },
                                    );
                                  }),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('iAgreeToThe_str'),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily:
                                      locator<PrefsService>().appLanguage ==
                                              'en'
                                          ? 'en'
                                          : 'ar',
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('termsAndConditions_str'),
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      height: 1,
                                      color: Colors.white70,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          child: StreamBuilder(
                            stream: validationManager.isFormValid$,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                focusNode: btnFocus,
                                color: Colors.teal.shade900,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.white24),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('signUp_str'),
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                  ),
                                ),
                                onPressed: () {
                                  if (snapshot.hasData) {}
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
    // return Scaffold(
    //   resizeToAvoidBottomPadding: true,
    //   body: Stack(
    //     children: <Widget>[
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: MediaQuery.of(context).size.height,
    //         child: Image.asset(
    //           'assets/images/sign_in.png',
    //           fit: BoxFit.fill,
    //         ),
    //       ),
    //       SingleChildScrollView(
    //         physics: BouncingScrollPhysics(),
    //         child: Padding(
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 40),
    //                 child: Text(
    //                   'SIGN UP',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 35,
    //                   ),
    //                 ),
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.firstName$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(middleNameFocus);
    //                     },
    //                     onChanged: (value) {
    //                       validationManager.inFirstName.add(value);
    //                     },
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(
    //                         Icons.person,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'First Name',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.middleName$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(lastNameFocus);
    //                     },
    //                     focusNode: middleNameFocus,
    //                     onChanged: validationManager.inMiddleName.add,
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       suffixText: '(Optional)',
    //                       suffixStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       prefixIcon: Icon(
    //                         Icons.person,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'Middle Name',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.lastName$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(addressFocus);
    //                     },
    //                     focusNode: lastNameFocus,
    //                     onChanged: validationManager.inLastName.add,
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(
    //                         Icons.person,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'Last Name',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.address$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(phoneFocus);
    //                     },
    //                     focusNode: addressFocus,
    //                     onChanged: validationManager.inAddress.add,
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(
    //                         Icons.location_on,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'Address',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.phone$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(emailFocus);
    //                     },
    //                     focusNode: phoneFocus,
    //                     keyboardType: TextInputType.number,
    //                     onChanged: validationManager.inPhone.add,
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(
    //                         Icons.phone_iphone,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'Phone Number',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.email$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(passwordFocus);
    //                     },
    //                     focusNode: emailFocus,
    //                     keyboardType: TextInputType.emailAddress,
    //                     onChanged: validationManager.inEmail.add,
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(
    //                         Icons.email,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'Email',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.password$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(confirmFocus);
    //                     },
    //                     focusNode: passwordFocus,
    //                     onChanged: validationManager.inPassword.add,
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(
    //                         Icons.lock,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'Password',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               StreamBuilder(
    //                 stream: validationManager.passwordConfirmation$,
    //                 builder: (context, snapshot) {
    //                   return TextField(
    //                     textInputAction: TextInputAction.next,
    //                     onSubmitted: (v) {
    //                       FocusScope.of(context).requestFocus(btnFocus);
    //                     },
    //                     focusNode: confirmFocus,
    //                     onChanged: validationManager.inPasswordConfirmation.add,
    //                     style: TextStyle(color: Colors.white),
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(
    //                         Icons.lock,
    //                         color: Colors.white,
    //                       ),
    //                       labelText: 'Confirm Password',
    //                       labelStyle: TextStyle(
    //                         color: Colors.white24,
    //                       ),
    //                       errorText: snapshot.error,
    //                     ),
    //                   );
    //                 },
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 40.0),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.only(bottom: 16.0),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: <Widget>[
    //                           StreamBuilder(
    //                               initialData: true,
    //                               stream: validationManager.checkBoxValue$,
    //                               builder: (context, snapshot) {
    //                                 return Checkbox(
    //                                   activeColor: Colors.white,
    //                                   hoverColor: Colors.white,
    //                                   checkColor: Colors.teal.shade800,
    //                                   focusColor: Colors.white,
    //                                   value: snapshot.data,
    //                                   onChanged: (value) {
    //                                     validationManager
    //                                         .setCheckBoxValue(value);
    //                                   },
    //                                 );
    //                               }),
    //                           Text(
    //                             'I agree to the',
    //                             style: TextStyle(
    //                               color: Colors.white70,
    //                             ),
    //                           ),
    //                           InkWell(
    //                             onTap: () {},
    //                             child: Column(
    //                               children: <Widget>[
    //                                 Text(
    //                                   'Terms and conditions',
    //                                   style: TextStyle(
    //                                     color: Colors.white70,
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   width: 130,
    //                                   height: 1,
    //                                   color: Colors.white70,
    //                                 )
    //                               ],
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                     ButtonTheme(
    //                       minWidth: MediaQuery.of(context).size.width * 0.8,
    //                       child: StreamBuilder(
    //                         stream: validationManager.isFormValid$,
    //                         builder: (context, snapshot) {
    //                           return RaisedButton(
    //                             focusNode: btnFocus,
    //                             color: Colors.teal.shade900,
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(5.0),
    //                               side: BorderSide(color: Colors.white24),
    //                             ),
    //                             child: Text(
    //                               'SIGN UP',
    //                               style: TextStyle(
    //                                 color: Colors.white70,
    //                               ),
    //                             ),
    //                             onPressed: () {
    //                               if (snapshot.hasData) {}
    //                             },
    //                           );
    //                         },
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

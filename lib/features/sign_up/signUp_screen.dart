import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/sign_up/signUp_repo.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final validationManager = locator<SignUpValidationManager>();
  final btnFocus = FocusNode();
  final middleNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final addressFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: StreamBuilder(
          stream: isLoading.stream,
          builder: (context, isLoadingSnapshot) {
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('signUp_str'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : 'ar',
                              ),
                            ),
                          ),
                          StreamBuilder(
                            stream: validationManager.firstName$,
                            builder: (context, snapshot) {
                              return TextField(
                                controller: firstNameController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(middleNameFocus);
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                controller: middleNameController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(lastNameFocus);
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                controller: lastNameController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(addressFocus);
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                controller: addressController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(phoneFocus);
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                controller: phoneController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocus);
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(passwordFocus);
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(confirmFocus);
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                controller: confirmController,
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) {
                                  FocusScope.of(context).requestFocus(btnFocus);
                                },
                                focusNode: confirmFocus,
                                onChanged: validationManager
                                    .inPasswordConfirmation.add,
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
                                        locator<PrefsService>().appLanguage ==
                                                'en'
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
                                          stream:
                                              validationManager.checkBoxValue$,
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
                                          fontFamily: locator<PrefsService>()
                                                      .appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'termsAndConditions_str'),
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily:
                                                      locator<PrefsService>()
                                                                  .appLanguage ==
                                                              'en'
                                                          ? 'en'
                                                          : 'ar',
                                                ),
                                              ),
                                              Container(
                                                width: 120,
                                                height: 1,
                                                color: Colors.white70,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: StreamBuilder(
                                    stream: validationManager.isFormValid$,
                                    builder: (context, snapshot) {
                                      return RaisedButton(
                                        focusNode: btnFocus,
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
                                                .translate('signUp_str'),
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                            ),
                                          ),
                                        ),
                                        onPressed: snapshot.hasData
                                            ? () async {
                                                isLoading.add(true);
//                                      await DataConnectionChecker().hasConnection;

                                                print(
                                                    "emailController.text,phoneController.text,passwordController.text,confirmController.text,firstNameController.text,middleNameController.text,lastNameController,addressController.text  ${emailController.text} , ${phoneController.text},${passwordController.text},${confirmController.text},${firstNameController.text},${middleNameController.text},${lastNameController.text},${addressController.text} }");

                                                RegisterRepo.postRegisterData(
                                                        emailController.text,
                                                        phoneController.text,
                                                        passwordController.text,
                                                        confirmController.text,
                                                        firstNameController
                                                            .text,
                                                        middleNameController
                                                            .text,
                                                        lastNameController,
                                                        addressController.text)
                                                    .then((onValue) {
                                                  isLoading.add(false);
                                                  if (onValue.status == 1) {
                                                    locator<PrefsService>()
                                                            .userObj =
                                                        onValue.data.user;
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            '/homeScreen');
                                                    locator<PrefsService>()
                                                        .hasSignInSeen = true;
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

//                                  _showMaterialDialog(context);
                                              }
                                            : null,
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

//  void _showMaterialDialog(BuildContext context) {
//    showDialog(
//      // barrierDismissible: false,
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            contentPadding: EdgeInsets.all(15.0),
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(20.0))),
//            content: Container(
//              decoration: new BoxDecoration(
//                shape: BoxShape.rectangle,
//                color: const Color(0xFFFFFF),
//                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//              ),
//              height: 50,
//              // MediaQuery.of(context).size.height * 0.29,
//              width: MediaQuery.of(context).size.width * 0.5,
//              // child: Column(
//              // children: <Widget>[
//              child: Center(
//                child: Container(
//                  margin: EdgeInsets.only(bottom: 15.0),
//                  child: CustomObserver<RegisterModel>(
//                    stream: locator<RegisterManager>().postData(emailController.text,phoneController.text,passwordController.text,confirmController.text,firstNameController.text,middleNameController.text,lastNameController,addressController.text ),
//                    onSuccess: (context, RegisterModel data) {
////                      User user = data.data.user;
//                      String msg = data.message;
//                      if (data.status == 1) {
//                        return Text(
//                          msg,
//                          textAlign: TextAlign.center,
//                          style: TextStyle(fontSize: 18, height: 1.5),
//                        );
//                      }
//
//                      return Text(
//                        msg,
//                        textAlign: TextAlign.center,
//                        softWrap: true,
//                        maxLines: 3,
//                        style: TextStyle(fontSize: 12, height: 1.5),
//                      );
//                    },
//                  ),
//                ),
//              ),
//            ),
//            titlePadding: EdgeInsets.only(top: 35.0),
//          );
//        }).then((onValue){
//
//    });
//        .timeout(Duration(seconds: 1), onTimeout: () {
//      if (codeStatus == 1) {
//        Navigator.pushReplacementNamed(context, '/homeScreen');
//      }
//    }).whenComplete(() {
//      if (codeStatus == 1) {
//        Navigator.pushReplacementNamed(context, '/homeScreen');
//      }
//    });
//  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    isLoading.close();
    super.dispose();
  }
}

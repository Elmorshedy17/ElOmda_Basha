import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/login_api_bloc.dart';
import 'package:medicine/src/blocs/forget_password_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/signIn_bloc.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/new_code/forget_password_code.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/register.dart';
import 'package:medicine/src/views/screens/verificationCode.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  int codeStatus = 0;
  bool isSecured = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var GlobalUserId = locator<PrefsService>().saveUserId == null? locator<UserIdBloc>().currentUserId.toString() : locator<PrefsService>().saveUserId.toString();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding:
              EdgeInsets.only(top: 0, right: 20.0, left: 20.0, bottom: 20.0),
          child: ListView(
            children: <Widget>[
              Container(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 25.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Image.asset(
                  "assets/images/login.png",
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 3.4,
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate('welcome_str'),
                    //":تسجيل كـ"
                    style: TextStyle(
                        color: blackColor,
                        fontSize: MainFont,
                        fontWeight: semiFont),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              _emailFiled(),
              SizedBox(
                height: 20.0,
              ),
              _passwodFiled(),
              SizedBox(
                height: 20.0,
              ),
              _forgetLink(),
              SizedBox(
                height: 20.0,
              ),
              _submitButtom(),
              SizedBox(
                height: 40.0,
              ),
              _registeracc(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailFiled() {
    return StreamBuilder<Object>(
        stream: locator<SignInBloc>().mobileOrEmail,
        builder: (context, snapshot) {
          return TextField(
            controller: emailController,
            onChanged: locator<SignInBloc>().changeMobileOrEmail,
            decoration: InputDecoration(
                errorText: snapshot.error,
                hintText: AppLocalizations.of(context).translate('email_str'),
                labelText: AppLocalizations.of(context).translate('email_str'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          );
        });
  }

  Widget _passwodFiled() {
    return StreamBuilder<Object>(
        stream: locator<SignInBloc>().password,
        builder: (context, snapshot) {
          return TextField(
            controller: passwordController,
            onChanged: locator<SignInBloc>().changePassword,
            obscureText: isSecured,
            //  onChanged: signupBloc.changeName,
            decoration: InputDecoration(
                errorText: snapshot.error,
                suffixIcon: isSecured
                    ? IconButton(
                        icon: Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isSecured = !isSecured;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isSecured = !isSecured;
                          });
                        },
                      ),
                hintText:
                    AppLocalizations.of(context).translate('password_str'),
                labelText:
                    AppLocalizations.of(context).translate('password_str'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          );
        });
  }

  Widget _forgetLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            _showDialog();
          },
          child: Text(
            AppLocalizations.of(context).translate('forget_password'),
            style: TextStyle(
              fontSize: PrimaryFont,
              fontWeight: semiFont,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  _submitButtom() {
    return Container(
      width: double.infinity,
      child: ButtonTheme(
        height: 60.0,
        child: StreamBuilder<Object>(
            stream: locator<SignInBloc>().registerValid,
            builder: (context, snapshot) {
              return RaisedButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                child: Text(
                  AppLocalizations.of(context).translate('Login_str'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MainFont,
                    fontWeight: semiFont,
                  ),
                ),
                onPressed: snapshot.hasData
                    ? () {
                        locator<LoginApiBloc>()
                            .EmailApiSink
                            .add(emailController.text);
                        locator<LoginApiBloc>()
                            .PasswordApiSink
                            .add(passwordController.text);
//                ApiService.login();
                  locator<IsLoadingManager>().isLoading.add(true);

                        ApiService.login().then((data) {
                          locator<IsLoadingManager>().isLoading.add(false);

                          if (data.key == "1") {

                            locator<PrefsService>().rateToSar = data.data.rateToSar.toString() ;
                            locator<PrefsService>().currencyCode = data.data.currencyCode.toString() ;
                            if(locator<PrefsService>().saveUserId != null){
                              locator<UserIdBloc>()
                                  .UserIdSink
                                  .add(
//                                  data.data.id.toString().toString()
                                  locator<PrefsService>().saveUserId
                              );
                            }else{
                              locator<PrefsService>().saveUserId = data.data.id.toString().toString();
                              locator<UserIdBloc>()
                                  .UserIdSink
                                  .add(
//                                  data.data.id.toString().toString()
                                  locator<PrefsService>().saveUserId
                              );
                            }


                            if(data.data.isBlocked == true){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context).translate("Blocked_str")),
                                  );
                                },
                              );
                            }
                            else if(data.data.isActive != true){


                              if(GlobalUserId == null || GlobalUserId == ''){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text( Localizations.localeOf(context).languageCode == 'en' ? "you haven't active your account yet please contact admin" : "لم يتم تفعيل حسابك حتي الان ، برجاء التواصل مع الادارة"),
                                    );
                                  },
                                );
                              }else{
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PinCodeVerificationScreen()
                                      //  HomePage(data.data.id.toString())
                                    ));
                              }


                            }
                            else{
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      locator<UserTypeBloc>().currentUserType != "delegate"?   HomePage(data.data.id.toString())   :   DeliveyHomePage(data.data.id.toString())                                 //  HomePage(data.data.id.toString())
                                  ));
                            }




                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(data.msg),
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
    );
  }

  _registeracc() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('dont_account_str'),
            style: TextStyle(
              color: lightText,
              fontSize: MediumFont,
              fontWeight: semiFont,
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => RegisterScreen()));
            },
            child: Text(
              AppLocalizations.of(context).translate('reg_account_str'),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: MediumFont,
                fontWeight: semiFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StreamBuilder<Object>(
            stream: locator<ForgetPasswordBloc>().email,
            builder: (context, snapshot) {
              print(snapshot.data);
              return AlertDialog(
                title: Text(
                  AppLocalizations.of(context).translate('email_confirm'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: semiFont,
                    fontSize: PrimaryFont,
                  ),
                ),
                content: TextField(
                  onChanged: locator<ForgetPasswordBloc>().changeEmail,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText:
                          AppLocalizations.of(context).translate('email_str'),
                      labelText:
                          AppLocalizations.of(context).translate('email_str'),
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.only(bottom: 15.0, right: 15.0, left: 15.0),
// padding: EdgeInsets.only(bottom: 20.0),
                    child: ButtonTheme(
                      height: 60.0,
//                minWidth: 250.0,
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('con_send_str'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MainFont,
                            fontWeight: semiFont,
                          ),
                        ),
                        onPressed: snapshot.hasData
                            ? () {
                          locator<IsLoadingManager>().isLoading.add(true);

                          ApiService.ForgetPasswordCheckEmail()
                                    .then((data) {
                            locator<IsLoadingManager>().isLoading.add(false);

                            data.key == "1"
                                      ?  Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ForgetPinCodeVerificationScreen(data.data.userId)))
                                      : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(data.msg),
                                      );
                                    },
                                  );
                                } );

//                        AlertDialog(
//                          title:
//                          FutureBuilder(
//                              future: ApiService.ForgetPasswordCheckEmail(), //returns bool
//                              builder: (BuildContext context, AsyncSnapshot snapshot) {
//                                if (snapshot.connectionState == ConnectionState.done) {
//                                  // YOUR CUSTOM CODE GOES HERE
//                                  return Text(
//                                    snapshot.data.msg,
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold, fontSize: 22),
//                                    textAlign: TextAlign.center,
//                                  );
//                                } else {
//                                  return new CircularProgressIndicator();
//                                }
//                              }),
//                        );
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }


  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}

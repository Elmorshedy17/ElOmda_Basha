import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/check_code_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/models/api_models/common/resend_active_code_model.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPinCodeVerificationScreen extends StatefulWidget {

  final userId;
  ForgetPinCodeVerificationScreen(this.userId);
  @override
  _ForgetPinCodeVerificationScreenState createState() =>
      _ForgetPinCodeVerificationScreenState();
}

class _ForgetPinCodeVerificationScreenState extends State<ForgetPinCodeVerificationScreen> {
  var onTapRecognizer;

  /// this [StreamController] will take input of which function should be called

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
//  void initState() {
//    onTapRecognizer = TapGestureRecognizer()
//      ..onTap = () {
//        Navigator.pop(context);
//      };
//
//    super.initState();
//  }
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
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
              SizedBox(height: 75.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context).translate("please_Verification"),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    borderWidth: 2.0,
                    onCompleted: null,
                    activeColor: Colors.blue,
                    backgroundColor: Colors.white70,
                    inactiveColor: Colors.grey,
                    length: 4,
                    obsecureText: false,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.box,
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                      });
//                      locator<CheckCodeBloc>().checkCodeSink.add(value);
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                // error showing widget
                child: Text(
                  hasError
                      ? AppLocalizations.of(context)
                      .translate("varifitication_full")
                      : "",
                  style: TextStyle(color: Colors.red.shade300, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //         AppLocalizations.of(context)
              //             .translate('didnt_recive_code'),
              //         style: TextStyle(color: Colors.black54, fontSize: 15)),
              //     FlatButton(
              //         onPressed: () {
              //           showDialog(
              //               context: context,
              //               builder: (BuildContext context){
              //                 return AlertDialog(
              //                   title:
              //                   FutureBuilder(
              //                       future: ApiService.ResendActiveCode(), //returns bool
              //                       builder: (BuildContext context, AsyncSnapshot snapshot) {
              //                         if (snapshot.connectionState == ConnectionState.done) {
              //                           // YOUR CUSTOM CODE GOES HERE
              //                           return Text(
              //                             snapshot.data.msg,
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold, fontSize: 22),
              //                             textAlign: TextAlign.center,
              //                           );
              //                         } else {
              //                           return new CircularProgressIndicator();
              //                         }
              //                       }),
              //                 );
              //               }
              //           );
              //         },
              //         child: Text(
              //           AppLocalizations.of(context).translate('RESEND_str'),
              //           style: TextStyle(
              //               color: Theme.of(context).primaryColor,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 14),
              //         )),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: newPasswordController,
                  keyboardType: TextInputType.number,
                  //  onChanged: signupBloc.changeName,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate("new_password_str") ,
                      labelText: AppLocalizations.of(context).translate("new_password_str") ,
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: currentText.length == 4
                        ? () {
                      // ApiService.ActiveCode(currentText);

                      // conditions for validating
                      if (currentText.length != 4 ||
                          currentText != "towtow") {
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        setState(() {
                          hasError = false;
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Aye!!"),
                            duration: Duration(seconds: 2),
                          ));
                        });
                      }

                      locator<IsLoadingManager>().isLoading.add(true);

                      ApiService.ResetPasswordCheckCodeCode(currentText,newPasswordController.text,widget.userId).then((data){
                        locator<IsLoadingManager>().isLoading.add(false);

                        data.key == "1"  ?  Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => Login()))
                            : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(data.msg),
                            );
                          },
                        );
                      });


//                            showDialog(
//                                context: context,
//                                builder: (BuildContext context){
//                                  return AlertDialog(
//                                    title:
//                                    FutureBuilder(
//                                        future: ApiService.ActiveCode(currentText), //returns bool
//                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
//                                          if (snapshot.connectionState == ConnectionState.done) {
//                                            // YOUR CUSTOM CODE GOES HERE
//                                            return Text(
//                                              snapshot.data.msg,
//                                              style: TextStyle(
//                                                  fontWeight: FontWeight.bold, fontSize: 22),
//                                              textAlign: TextAlign.center,
//                                            );
//                                          } else {
//                                            return new CircularProgressIndicator();
//                                          }
//                                        }),
//                                  );
//                                }
//                            );

                    }
                        : null,
                    child: Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('continue_str')
                              .toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                decoration: currentText.length == 4
                    ? BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.red.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ])
                    : BoxDecoration(
                  color: Colors.blueGrey.withOpacity(.5),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

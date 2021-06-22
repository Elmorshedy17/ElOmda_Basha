import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/new_order_bloc.dart';
import 'package:medicine/src/blocs/signUp_bloc.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:medicine/src/views/screens/verificationCode.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

//  bool isLogging = false;
   BehaviorSubject isLogging = new BehaviorSubject.seeded(false);
//  final BehaviorSubject<String> _password = BehaviorSubject<String>();


  dynamic dropFirstVal = "+966";
  bool isSecuredPassword = true;
  bool isSecuredConfirm = true;
  int radioGroup = 1;

  String phoneCode;
  String whatsAppCode;

  void dropFirstChanged(dynamic val) {
    setState(() {
      dropFirstVal = val;
      //   locator<SignUpBloc>().phoneCodeSubjectSink.add(dropFirstVal);
    });
  }

  dynamic dropSecVal = "+966";

  void dropSecChanged(dynamic val) {
    setState(() {
      dropSecVal = val;
      //   locator<SignUpBloc>().whastappCodeSubjectSink.add(dropSecVal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: isLogging.stream,
//      initialData: false,
      builder: (context, isLoggingSnapshot) {
        print(isLoggingSnapshot);
        return Scaffold(
          body:  Stack(
            children: <Widget>[

              SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    _backButton(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _registerName(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _namesFiled(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _emailFiled(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _phoneFiled(),
                    SizedBox(
                      height: 15.0,
                    ),
                    _whatsappFiled(),
                    _optional(),
                    SizedBox(
                      height: 30.0,
                    ),

                    locator<UserTypeBloc>().currentUserType =="marketer"?  _supervisor():Container(),

                    SizedBox(
                      height: 15.0,
                    ),
                    locator<UserTypeBloc>().currentUserType== "delegate"?   _counteryCity():Container(),

                    SizedBox(
                      height: 15.0,
                    ),
                    _PasswordFiled(),
                    SizedBox(
                      height: 15.0,
                    ),
                    _confrimPasswordFiled(),
                    SizedBox(
                      height: 20.0,
                    ),
                    locator<UserTypeBloc>().currentUserType != "delegate"?  _paymentTitle():Container(),
                    locator<UserTypeBloc>().currentUserType != "delegate"?  _radioList():Container(),
                    SizedBox(
                      height: 25.0,
                    ),
                    _submitButtom(),
                    SizedBox(
                      height: 15.0,
                    ),
                    _loginacc(),
                  ],
                ),
              )),
              isLogging.value == true ?  Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              ):Container()
            ],
          ),
        );
      }
    );
  }

  Widget _backButton() {
    return Row(
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
    );
  }

  Widget _registerName() {
    return Row(
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('reg_account_str'),
          style: TextStyle(
              color: blackColor, fontSize: MainFont, fontWeight: semiFont),
        )
      ],
    );
  }

  Widget _paymentTitle() {
    return Row(
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('payment_title_str'),
          style: TextStyle(
              color: blackColor, fontSize: MainFont, fontWeight: semiFont),
        )
      ],
    );
  }

  Widget _namesFiled() {
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<SignUpBloc>().name,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: locator<SignUpBloc>().changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText: AppLocalizations.of(context)
                          .translate('first_name_str'),
                      labelText: AppLocalizations.of(context)
                          .translate('first_name_str'),
                      border: OutlineInputBorder()),
                );
              }),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<SignUpBloc>().secondname,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: locator<SignUpBloc>().changeSecondName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText: AppLocalizations.of(context)
                          .translate("family_name_str"),
                      labelText: AppLocalizations.of(context)
                          .translate("family_name_str"),
                      border: OutlineInputBorder()),
                );
              }),
        ),
      ],
    );
  }

  Widget _emailFiled() {
    return StreamBuilder<Object>(
        stream: locator<SignUpBloc>().email,
        builder: (context, snapshot) {
          return TextField(
            onChanged: locator<SignUpBloc>().changeEmail,
            //  onChanged: signupBloc.changeName,
            decoration: InputDecoration(
                errorText: snapshot.error,
                hintText: AppLocalizations.of(context).translate('email_str'),
                labelText: AppLocalizations.of(context).translate('email_str'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          );
        });
  }

  Widget _phoneFiled() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
          ),
          child: DropdownButton<dynamic>(
            //hint: Text(dropFirstVal),
            onChanged: dropFirstChanged,
            value: dropFirstVal,
            items: [
              //  "+20", "+65", "+95"
              "+93","+213","+973","+269","+20","+251","+62","+98","+964","+962","+965","+961","+218","+60","+212","+234","+968","+92","+970","+974","+966","+249","+963","+216","+90","+971","+967"
            ]
                .map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<SignUpBloc>().mobile,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: locator<SignUpBloc>().changeMobile,
                  keyboardType: TextInputType.number,
                  //  onChanged: signupBloc.changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText:
                          AppLocalizations.of(context).translate('phone_str'),
                      labelText:
                          AppLocalizations.of(context).translate('phone_str'),
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                );
              }),
        ),
      ],
    );
  }

  Widget _whatsappFiled() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
          ),
          child: DropdownButton<dynamic>(
            //hint: Text(dropFirstVal),
            onChanged: dropSecChanged,
            value: dropSecVal,
            items: [
              //  "+20", "+65", "+95"
              "+93","+213","+973","+269","+20","+251","+62","+98","+964","+962","+965","+961","+218","+60","+212","+234","+968","+92","+970","+974","+966","+249","+963","+216","+90","+971","+967"
            ]
                .map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<SignUpBloc>().whatsapp,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: locator<SignUpBloc>().changeWhatsapp,
                  keyboardType: TextInputType.number,
                  //  onChanged: signupBloc.changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText:
                          AppLocalizations.of(context).translate('phone_str'),
                      labelText:
                          AppLocalizations.of(context).translate('phone_str'),
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                );
              }),
        ),
      ],
    );
  }

  Widget _optional() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            AppLocalizations.of(context).translate('optional_str'),
            style: TextStyle(
              fontSize: PrimaryFont,
              fontWeight: semiFont,
              color: Theme.of(context).primaryColor,
              // decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _supervisor() {
    return StreamBuilder<Object>(
        stream: locator<SignUpBloc>().supervisor,
        builder: (context, snapshot) {
          return TextField(
            onChanged: locator<SignUpBloc>().changeSuperVisor,
            decoration: InputDecoration(
                errorText: snapshot.error,
                hintText:
                    AppLocalizations.of(context).translate("supervisor_code"),
                labelText:
                    AppLocalizations.of(context).translate("supervisor_code"),
                border: OutlineInputBorder()),
          );
        });
  }



  Widget _PasswordFiled() {
    return StreamBuilder<Object>(
        stream: locator<SignUpBloc>().password,
        builder: (context, snapshot) {
          return TextField(
            onChanged: locator<SignUpBloc>().changePassword,
            obscureText: isSecuredPassword,
            //  onChanged: signupBloc.changeName,
            decoration: InputDecoration(
                errorText: snapshot.error,
                suffixIcon: isSecuredPassword
                    ? IconButton(
                        icon: Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isSecuredPassword = !isSecuredPassword;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isSecuredPassword = !isSecuredPassword;
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

  Widget _confrimPasswordFiled() {
    return StreamBuilder<Object>(
        stream: locator<SignUpBloc>().confirmPassword,
        builder: (context, snapshot) {
          return TextField(
            onChanged: locator<SignUpBloc>().changePasswordConfirmation,
            obscureText: isSecuredConfirm,
            //  onChanged: signupBloc.changeName,
            decoration: InputDecoration(
                errorText: snapshot.error,
                suffixIcon: isSecuredConfirm
                    ? IconButton(
                        icon: Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isSecuredConfirm = !isSecuredConfirm;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isSecuredConfirm = !isSecuredConfirm;
                          });
                        },
                      ),
                hintText: AppLocalizations.of(context)
                    .translate('password_confirm_str'),
                labelText: AppLocalizations.of(context)
                    .translate('password_confirm_str'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          );
        });
  }

  Widget _radioList() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Radio(
                  activeColor: Theme.of(context).primaryColor,
                  value: 1,
                  groupValue: radioGroup,
                  //                 onChanged: patientBloc.setValue,
                  onChanged: (t) {
                    setState(() {
                      radioGroup = t;
                      locator<SignUpBloc>()
                          .radioButtomSink
                          .add("commission");
                    });
                  },
                ),
                SizedBox(
                  width: 0.5,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate("payment_method_first"),
                ),
              ],
            ),
          ),
          SizedBox(width: 25,),
          Container(
            child: Row(
              children: <Widget>[
                Radio(
                  activeColor: Theme.of(context).primaryColor,
                  value: 2,
                  groupValue: radioGroup,
                  //                   onChanged: patientBloc.setValue,
                  onChanged: (t) {
                    setState(() {
                      radioGroup = t;
                      locator<SignUpBloc>()
                          .radioButtomSink
                          .add("commission_point");
                    });
                  },
                ),
                SizedBox(
                  width: 0.5,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('payment_method_second'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _submitButtom() {
    void _afterClickRegister(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
              future: ApiService.Register(dropFirstVal, dropSecVal),
              builder: (context, snapshot) {
                print(snapshot.data);
                return AlertDialog(
                  title: Text(snapshot.data.msg),
                );
              });
        },
      );
    }

    return Container(
      width: double.infinity,
      child: ButtonTheme(
        height: 60.0,
        child: StreamBuilder<Object>(
            stream: locator<SignUpBloc>().registerValid,
            builder: (context, snapshot) {
              return RaisedButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                child: Text(
                  AppLocalizations.of(context).translate('just_register'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MainFont,
                    fontWeight: semiFont,
                  ),
                ),
                onPressed: snapshot.hasData
                    ? () {
//setState(() {
//  isLogging = true;
//});
                  isLogging.sink.add(true);
                        print("${locator<SignUpBloc>().currentradioButtom}");

                        ApiService.Register(dropFirstVal, dropSecVal)
                            .then((data) {

                          if(data.key == "1"){
                            isLogging.sink.add(false);
//                            setState(() {
//                              isLogging = false;
//                            });
                            locator<UserIdBloc>().UserIdSink.add(data.data.id.toString().toString());
                            locator<PrefsService>().rateToSar = data.data.rateToSar.toString() ;
                            locator<PrefsService>().currencyCode = data.data.currencyCode.toString() ;
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PinCodeVerificationScreen()
                                  //  HomePage(data.data.id.toString())
                                ));
                          }else{
                            isLogging.sink.add(false);
//                            setState(() {
//                              isLogging = false;
//                            });
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

  _loginacc() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('have_account_str'),
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
                      builder: (BuildContext context) => Login()));
            },
            child: Text(
              AppLocalizations.of(context).translate('login_account_str'),
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


  Widget _counteryCity() {
    return Row(
      children: <Widget>[
        FutureBuilder(
            future: ApiService.AllCountriesAndCities(),
            builder: (context, snapshot) {
              var countries = [];
              var countryId = [];
              var cities = [];
              var citiesIdTitle = [];
              var citiesId = [];
              if (snapshot.hasData) {
                for (int index = 0;
                index < snapshot.data.data.length;
                index++) {
                  countries.add(snapshot.data.data[index].title);
                }
              } else {
                var countries = ["السعوديه"];
              }
              return Expanded(
                child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            content: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Scrollbar(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: countries.length,
                                    gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                        MediaQuery.of(context)
                                            .size
                                            .width /
                                            (MediaQuery.of(context)
                                                .size
                                                .height /
                                                4)),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          locator<NewOrderBloc>()
                                              .counterySink
                                              .add(countries[index]);
                                          print(
                                              "locator<NewOrderBloc>().counterySink.add(countries[index])${locator<NewOrderBloc>().currentCountery}");
                                          Navigator.pop(context);
                                          locator<NewOrderBloc>()
                                              .chosenCitySink
                                              .add("");
                                          cities.clear();

//                                          for(int index = 0; index < snapshot.data.data.length; index++){
//                                               if(snapshot.data.data[index].cities.title.contains(locator<NewOrderBloc>().currentChosenCity)  ){
//                                                 citiesId.add(snapshot.data.data[index].cities.id);
//                                               }
//                                          }

//                                          for (int index = 0; index < snapshot.data.data.length; index++) {
//                                            if (snapshot.data.data[index].title.contains(locator<NewOrderBloc>().currentCountery)) {
//                                              countryId.add(snapshot.data.data[index].id);
//                                              for (int ind = 0; ind < snapshot.data.data[index].cities.length; ind++) {
////                                                cities.add(snapshot.data.data[index].cities[ind].title);
//                                                if(snapshot.data.data[index].cities[ind].title.contains(locator<NewOrderBloc>().currentChosenCity)  ){
//                                                  citiesId.add(snapshot.data.data[index].cities.id);
//                                                }
//                                              }
//                                            }
//                                          }

                                          for (int index = 0; index < snapshot.data.data.length; index++) {
                                            if (snapshot.data.data[index].title.contains(locator<NewOrderBloc>().currentCountery)) {
                                              countryId.add(snapshot.data.data[index].id);
                                              for (int ind = 0; ind < snapshot.data.data[index].cities.length; ind++) {
                                                cities.add(snapshot.data.data[index].cities[ind].title);
                                                citiesIdTitle.add(snapshot.data.data[index].cities[ind]);
                                              }
                                            }
                                          }
                                          locator<NewOrderBloc>().cityIdTitleSink.add(citiesIdTitle);

//                                          print("------------------------------------------------------- ${citiesId[0].id} ------------------------");

                                          //
                                          locator<NewOrderBloc>().counteryIdSink.add(snapshot.data.data[index].id);
                                          print("locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId ${locator<NewOrderBloc>().currentCounteryId}");
//
                                          locator<NewOrderBloc>()
                                              .citiesSink
                                              .add(cities);
                                        },
                                        child: Center(
                                            child: Text(
                                              countries[index],
                                              textAlign: TextAlign.center,
                                            )),
                                      );
                                    }),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 60.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: Center(
                          child: StreamBuilder(
                              initialData: "",
                              stream: locator<NewOrderBloc>().counteryStream$,
                              builder: (context, snapshot) {
                                return Text(snapshot.data);
                              })),
                    )),
              );
            }),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return StreamBuilder(
                        initialData: "",
                        stream: locator<NewOrderBloc>().citiesStream$,
                        builder: (context, snapshot) {
                          return AlertDialog(
                            content: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Scrollbar(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                        MediaQuery.of(context)
                                            .size
                                            .width /
                                            (MediaQuery.of(context)
                                                .size
                                                .height /
                                                4)),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          locator<NewOrderBloc>()
                                              .chosenCitySink
                                              .add(locator<NewOrderBloc>()
                                              .currentcities[index]);

                                          for(int ind = 0 ; ind < locator<NewOrderBloc>().currentCityIdTitle.length; ind ++){
                                            if(locator<NewOrderBloc>().currentCityIdTitle[ind].title.contains(locator<NewOrderBloc>()
                                                .currentChosenCity)){
                                              locator<NewOrderBloc>().cityIdSink.add(locator<NewOrderBloc>().currentCityIdTitle[ind].id);
                                            }
                                          }

                                          print(
                                              "locator<NewOrderBloc>().counterySink.add(countries[index])${locator<NewOrderBloc>().currentCityId} h hahah ------------");
                                          Navigator.pop(context);
//                                        Navigator.of(context);
                                        },
                                        child: Center(
                                            child: Text(snapshot.data[index])),
                                      );
                                    }),
                              ),
                            ),
                          );
                        });
                  },
                );
              },
              child: Container(
                height: 60.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: Center(
                    child: StreamBuilder(
                        initialData: "",
                        stream: locator<NewOrderBloc>().chosenCityStream$,
                        builder: (context, snapshot) {
                          return Text(snapshot.data);
                        })),
              )),
        )
      ],
    );
  }

  dispose() {
    isLogging.close();
    super.dispose();
  }
}

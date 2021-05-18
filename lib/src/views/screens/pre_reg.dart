import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_language.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/my_account_switch_bloc.dart';
import 'package:medicine/src/blocs/signUp_bloc.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:medicine/theme_setting.dart';
import 'package:provider/provider.dart';



class PreRegistration extends StatefulWidget {
  @override
  _PreRegistrationState createState() => _PreRegistrationState();
}

class _PreRegistrationState extends State<PreRegistration> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return
      Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child:
          ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height /8,
              ),
              Image.asset("assets/images/onboard.png",fit: BoxFit.fill,height: MediaQuery.of(context).size.height/3,),
            SizedBox(
              height: 45.0,
            ),
              Text(AppLocalizations.of(context).translate("pre_lgin_str"),textAlign: TextAlign.center,
              style: TextStyle(
fontSize: PrimaryFont,
                color: lightText,
                fontWeight: regFont,
              ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Row(
              //  mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
              AppLocalizations.of(context).translate('reg_as'),
          //":تسجيل كـ"
                    style: TextStyle(
                      color: blackColor,
                      fontSize: MainFont,
                      fontWeight: semiFont
                  ),),

                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[



                  Expanded(
                    child:
                    ButtonTheme(
                      height: 60.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                        color: Theme.of(context).accentColor,
                        child:
                        FittedBox(
                          child: Text( AppLocalizations.of(context).translate('trader'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MainFont,
                              fontWeight: semiFont,
                            ),
                          ),
                        ),
                        onPressed: (){
                          locator<UserTypeBloc>().UserTypeSink.add("marketer");
                          locator<PrefsService>().userType = "marketer";
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                   Login()));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),

                Expanded(
                  child:
                  ButtonTheme(
                    height: 60.0,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                      child:
                    FittedBox(
                      child:   Text(
                        AppLocalizations.of(context).translate('TeamLeader'),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: MainFont,
                          fontWeight: semiFont,
                        ),
                      ),
                    ),
                      onPressed: () async {
                        locator<UserTypeBloc>().UserTypeSink.add("supervisor_marketer");
                        locator<PrefsService>().userType = "supervisor_marketer";

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                Login())
                        );
                      },
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 1.5, //width of the border
                      ),
                    ),
                  ),
                ),
              ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child:
                ButtonTheme(
                  height: 60.0,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                    child:
                    Text(
                       AppLocalizations.of(context).translate('delivery'),

                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: MainFont,
                        fontWeight: semiFont,
                      ),
                    ),
                    onPressed: (){
                      locator<UserTypeBloc>().UserTypeSink.add("delegate");
                      locator<PrefsService>().userType = "delegate";
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              Login()));
                    },
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, //Color of the border
                      style: BorderStyle.solid, //Style of the border
                      width: 1.5, //width of the border
                    ),
                  ),
                ),
              ),
// SizedBox(height:  20.0,),
//               _language(),
//              RaisedButton(
//                child: Text('lang'),
//                onPressed: () {
//                  setState(() {
//                    Localizations.localeOf(context).languageCode == 'en'
//                        ? appLanguage.changeLanguage(Locale('ar'))
//                        : appLanguage.changeLanguage(Locale('en'));
//                  });
//                },
//              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _language() {
    String lang = "English";

    bool lango = false;

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: Colors.blue.withOpacity(.6),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  AppLocalizations.of(context).translate("Language_str") ,
                  style: TextStyle(fontWeight: bolFont, fontSize: PrimaryFont),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
                stream: locator<SwitchNotyBloc>().switchLangStream$,
                initialData: false,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        locator<SwitchNotyBloc>().currentLang == false
                            ? "English"
                            : "العربية",
                        style: TextStyle(
                            color: greyBlue,
                            fontWeight: bolFont,
                            fontSize: PrimaryFont),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      CupertinoSwitch(
                          activeColor: Colors.greenAccent,
                          value: snapshot.data,
                          onChanged: (bool flag) {
                            locator<SwitchNotyBloc>().onSwitchLangChanged();
                            print(locator<SwitchNotyBloc>().currentLang);

                            setState(() {
                              Localizations.localeOf(context).languageCode == 'en'
                                  ? Provider.of<AppLanguage>(context).changeLanguage(Locale('ar'))
                                  : Provider.of<AppLanguage>(context).changeLanguage(Locale('en'));
                            });

                          }
//                              (bool flag) {
//                            setState(() {
//                              switchOn = flag;
//                            });
//                          }
                      )
//                StreamBuilder<Object>(
//                    stream: locator<SwitchNotyBloc>().switchLangStream$,
//                    initialData: false,
//                    builder: (context, snapshot) {
//                      return ;
//                    }),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_language.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/my_account_switch_bloc.dart';
import 'package:medicine/src/views/screens/pre_reg.dart';
import 'package:medicine/theme_setting.dart';
import 'package:provider/provider.dart';

class FirstLangScreen extends StatefulWidget {
  @override
  _FirstLangScreenState createState() => _FirstLangScreenState();
}

class _FirstLangScreenState extends State<FirstLangScreen> {

  String lang = "English";

  bool lango = false;

  var prefs = locator<PrefsService>();

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
child:  Image.asset("assets/images/1024.png",
  fit: BoxFit.cover,
  // height: MediaQuery.of(context).size.height,
  width: MediaQuery.of(context).size.width,
),

          ),



          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonTheme(
                buttonColor: Colors.redAccent,
                minWidth:  MediaQuery.of(context).size.width * .4,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                    onPressed: (){
                      prefs.appLanguage ='ar';
                      appLanguage.changeLanguage(Locale('ar'));
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PreRegistration()));
                    },
                child: Text("العربية",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: bolFont,
                      fontSize: PrimaryFont),
                ),),
              ),


              ButtonTheme(
                buttonColor: Colors.blueAccent,
                minWidth:  MediaQuery.of(context).size.width * .4,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blueAccent)
                  ),
                    onPressed: (){
                      prefs.appLanguage ='en';
                      appLanguage.changeLanguage(Locale('en'));                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PreRegistration()));
                    },
                child: Text("English",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: bolFont,
                      fontSize: PrimaryFont),
                ),),
              ),



            ],
          ),


          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
          //     child: Row(
          //       children: <Widget>[
          //         Expanded(
          //           child: Row(
          //             children: <Widget>[
          //               Icon(
          //                 Icons.language,
          //                 color: Colors.blue.withOpacity(.6),
          //               ),
          //               SizedBox(
          //                 width: 8.0,
          //               ),
          //               Text(
          //                 AppLocalizations.of(context).translate("Language_str") ,
          //                 style: TextStyle(fontWeight: bolFont, fontSize: PrimaryFont),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Expanded(
          //           child: StreamBuilder<Object>(
          //               stream: locator<SwitchNotyBloc>().switchLangStream$,
          //               initialData: false,
          //               builder: (context, snapshot) {
          //                 return Row(
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   children: <Widget>[
          //                     Text(
          //                       locator<SwitchNotyBloc>().currentLang == false
          //                           ? "English"
          //                           : "العربية",
          //                       style: TextStyle(
          //                           color: greyBlue,
          //                           fontWeight: bolFont,
          //                           fontSize: PrimaryFont),
          //                     ),
          //                     SizedBox(
          //                       width: 8.0,
          //                     ),
          //                     CupertinoSwitch(
          //                         activeColor: Colors.greenAccent,
          //                         value: snapshot.data,
          //                         onChanged: (bool flag) {
          //                           locator<SwitchNotyBloc>().onSwitchLangChanged();
          //                           print(locator<SwitchNotyBloc>().currentLang);
          //
          //                           setState(() {
          //                             Localizations.localeOf(context).languageCode == 'en'
          //                                 ? Provider.of<AppLanguage>(context).changeLanguage(Locale('ar'))
          //                                 : Provider.of<AppLanguage>(context).changeLanguage(Locale('en'));
          //                             lango = true;
          //                           });
          //
          //                         }
          //                     )
          //                   ],
          //                 );
          //               }),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 40,
          // ),

          // SlideInUp(
          //   child: ButtonTheme(
          //     height: 60.0,
          //     minWidth: MediaQuery.of(context).size.width * .75,
          //     child: RaisedButton(
          //       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
          //       color: Theme.of(context).accentColor,
          //       child:
          //       FittedBox(
          //         child: Text( AppLocalizations.of(context).translate('start_str'),
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: MainFont,
          //             fontWeight: semiFont,
          //           ),
          //         ),
          //       ),
          //       onPressed: lango == true ? (){
          //         Navigator.push(
          //             context,
          //             new MaterialPageRoute(
          //                 builder: (BuildContext context) =>
          //                     PreRegistration()));
          //       } : null,
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }

}

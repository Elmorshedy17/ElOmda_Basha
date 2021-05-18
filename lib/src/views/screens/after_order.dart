import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/models/super_visor_marketers/store_order_model.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:medicine/src/views/screens/order_details.dart';
import 'package:medicine/theme_setting.dart';

class AfterOrder extends StatefulWidget {

  final StoreOrderModel data;
  AfterOrder(this.data);

  @override
  _AfterOrderState createState() => _AfterOrderState();
}

class _AfterOrderState extends State<AfterOrder> {
  @override
  Widget build(BuildContext context) {
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
                Image.asset("assets/images/done_vector.png",fit: BoxFit.fill,height: MediaQuery.of(context).size.height/3,),
                SizedBox(
                  height: 45.0,
                ),
                Center(
                  child: Text(
                    "${AppLocalizations.of(context).translate("order_no_str")} ${widget.data.data.id}",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: LargeFont,
                        fontWeight: bolFont
                    ),),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context).translate("Order_has_been_Sent_str"),
                    style: TextStyle(
                        color: blackColor,
                        fontSize: LargeFont,
                        fontWeight: bolFont
                    ),),
                ),


//                SizedBox(
//                  height: 25.0,
//                ),
//                Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى",textAlign: TextAlign.center,
//                  style: TextStyle(
//                    fontSize: PrimaryFont,
//                    color: lightText,
//                    fontWeight: regFont,
//                  ),
//                ),
                SizedBox(
                  height: 45.0,
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
                            child: Text(AppLocalizations.of(context).translate("Order_Details_str") ,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MainFont,
                                fontWeight: semiFont,
                              ),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) => OrderDetails(widget.data)));
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
                              AppLocalizations.of(context).translate("Back_Home_str")
                              ,style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: MainFont,
                                fontWeight: semiFont,
                              ),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) => HomePage(locator<UserIdBloc>().currentUserId.toString().toString())));
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

              ],
            ),
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/all_orders_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/models/delivery_models/show_all_delegates_orders.dart';
import 'package:medicine/src/views/screens/delivery_follow_order.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';

class DeliveryHistory extends StatefulWidget {
  @override
  _DeliveryHistoryState createState() => _DeliveryHistoryState();
}

class _DeliveryHistoryState extends State<DeliveryHistory> {

  bool checked = true;

//  dynamic dropHistoryo = AppLocalizations.of(context).translate("This_day_str");
  dynamic dropHistory = locator<PrefsService>().appLanguage == "en"?"This day":"هذا اليوم";
  dynamic filterHistory = "This day";

  dynamic secDropHistory = locator<PrefsService>().appLanguage == "en"?"Approved":"موافق";
  dynamic secFilterHistory = "Approved";

  BehaviorSubject isStepsClicked = new BehaviorSubject.seeded(false);

  //nullable| cancel,has_provider,in_way,finish
  void secDropHistoryChanged(dynamic val) {
    setState(() {
      secDropHistory = val;
      if(val== AppLocalizations.of(context).translate("canceled_str")){
        secFilterHistory ="cancel";
      }else if(val == AppLocalizations.of(context).translate("approved_str")){
        secFilterHistory ="has_provider";
      }else if(val == AppLocalizations.of(context).translate("on_the_way_str")){
        secFilterHistory ="in_way";
      }else if(val == AppLocalizations.of(context).translate("done_order")){
        secFilterHistory ="finish";
      }else if(val == null ){
        secFilterHistory ="On Way";
      }
      locator<AllOrdersFilterBloc>().allTypsOrdersFilterSink.add(secFilterHistory);


    });
  }
  void dropHistoryChanged (dynamic val) {
    setState(() {
      dropHistory = val;
      if(val== AppLocalizations.of(context).translate("This_year_str")){
        filterHistory ="year";
      }else if(val == AppLocalizations.of(context).translate("This_month_str")){
        filterHistory ="month";
      }else if(val == AppLocalizations.of(context).translate("This_week_str")){
        filterHistory ="week";
      }else if(val == AppLocalizations.of(context).translate("This_day_str")){
        filterHistory ="day";
      }else if(val == null ){
        filterHistory ="day";
      }
      locator<AllOrdersFilterBloc>().allOrdersFilterSink.add(filterHistory);

    });
  }
//  dynamic dropDeliveryHistory = "This day";
//  dynamic filterDeliveryHistory = "This day";

 // void dropDeliveryHistoryChanged(dynamic val) {
//    setState(() {
//      dropDeliveryHistory = val;
//
//
//      if(val== "This year"){
//        filterDeliveryHistory ="year";
//      }else if(val == "This month"){
//        filterDeliveryHistory ="month";
//      }else if(val == "This week"){
//        filterDeliveryHistory ="week";
//      }else if(val == "This day"){
//        filterDeliveryHistory ="day";
//      }else if(val == null ){
//        filterDeliveryHistory ="day";
//      }
//      locator<AllOrdersFilterBloc>().allOrdersFilterSink.add(filterDeliveryHistory);
//    });
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("history_str")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<ShowAllDelegatesOrdersModel>(
          future: ApiService.ShowAllDelegatesOrders(),
          builder: (context, snapshot) {
//            print("snapshot.data.data.length${snapshot.data.data}");
            return snapshot.hasData? Container(
              padding: EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                        ),
                        //color: Colors.yellow,
                        child: DropdownButton<dynamic>(
                          style: TextStyle(
                              fontSize: PrimaryFont,
                              fontWeight: bolFont,
                              color: Colors.black45),
                          //hint: Text(dropFirstVal),
                          value: dropHistory,
                          items: [AppLocalizations.of(context).translate("This_day_str"),AppLocalizations.of(context).translate("This_week_str"), AppLocalizations.of(context).translate("This_month_str"), AppLocalizations.of(context).translate("This_year_str")]
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: dropHistoryChanged,
                        ),
                        height: 50.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                        ),
                        //color: Colors.yellow,
                        child: DropdownButton<dynamic>(
                          style: TextStyle(
                              fontSize: PrimaryFont,
                              fontWeight: bolFont,
                              color: Colors.black45),
                          //hint: Text(dropFirstVal),
                          value: secDropHistory,
                          items: [AppLocalizations.of(context).translate("on_the_way_str"),AppLocalizations.of(context).translate("approved_str"), AppLocalizations.of(context).translate("canceled_str"), AppLocalizations.of(context).translate("done_order")]
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: secDropHistoryChanged,
                        ),
                        height: 50.0,
                      ),
                    ],
                  ),
//                  Row(
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(bottom: 15.0),
//                        padding: EdgeInsets.symmetric(horizontal: 10.0),
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(5.0),
//                          border: Border.all(
//                              color: Colors.grey, style: BorderStyle.solid, width: 0.80),
//                        ),
//                        //color: Colors.yellow,
//                        child: DropdownButton<dynamic>(
//                          style: TextStyle(
//                              fontSize: PrimaryFont,
//                              fontWeight: bolFont,
//                              color: Colors.black45),
//                          //hint: Text(dropFirstVal),
//                          onChanged: dropDeliveryHistoryChanged,
//                          value: dropDeliveryHistory,
//                          items: ["This day","This week", "This month", "This year"]
//                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
//                            return DropdownMenuItem(
//                              child: Text(value),
//                              value: value,
//                            );
//                          }).toList(),
//                        ),
//                        height: 50.0,
//                      ),
//                    ],
//                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 160,
                    child:  ListView.builder(
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (BuildContext context, int index){

                          return    Container(
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: InkWell(
                              onTap: (){
                                locator<IsLoadingManager>().isLoading.add(true);

                                ApiService.ShowDelegateOrder(
                                    snapshot.data.data[index].id).then((onValue) {
                                  locator<IsLoadingManager>().isLoading.add(false);

                                  if (onValue.key == "1") {
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>
                                        DelivereyFollowOrder(onValue,onValue)));
                                  } else {
                                    showDialog(context: context, builder: (BuildContext context) {
                                      return AlertDialog(title: Text(onValue.msg),);});}
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 4.0,
                                child: Container(
                                  padding: EdgeInsets.all(15.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context).translate("Order_Number_str"),
                                            style: TextStyle(
                                                fontWeight: bolFont, fontSize: MainFont),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            snapshot.data.data[index].id.toString(),
                                            //"3011",
                                            style: TextStyle(
                                                fontSize: PrimaryFont,
                                                fontWeight: semiFont,
                                                color: littleGrey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context).translate("Tottal_Price_str:"),
                                            style: TextStyle(
                                                fontWeight: bolFont,
                                                fontSize: PrimaryFont),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            snapshot.data.data[index].total.toString(),

                                            //     "300",
                                            style: TextStyle(
                                                fontSize: SecondaryFont,
                                                fontWeight: semiFont,
                                                color: Colors.red.withOpacity(.7)),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            AppLocalizations.of(context).translate("real_suadi_shortcut"),
                                            style: TextStyle(
                                                fontSize: SecondaryFont,
                                                fontWeight: regFont,
                                                color: littleGrey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context).translate("Adress_str:"),
                                            style: TextStyle(
                                                fontWeight: bolFont,
                                                fontSize: PrimaryFont),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            snapshot.data.data[index].address,

                                            //  "13 al Reyadh street,Al Reyadh",
                                            style: TextStyle(
                                                fontSize: PrimaryFont,
                                                fontWeight: semiFont,
                                                color: lightText),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "${AppLocalizations.of(context).translate("Order_Details_str")} :"  ,
                                            style: TextStyle(
                                                fontWeight: bolFont,
                                                fontSize: PrimaryFont),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          // Text(
                                          //   snapshot.data.data[index].,
                                          //   //  "13 al Reyadh street,Al Reyadh",
                                          //   style: TextStyle(
                                          //       fontSize: PrimaryFont,
                                          //       fontWeight: semiFont,
                                          //       color: lightText),
                                          // ),

                                        ],
                                      ),
                                      Container(
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.data[index].orderItems.length,
                                            itemBuilder: (BuildContext context, int indexx){
                                              return Row(
                                                children: [
                                                  Text(snapshot.data.data[index].orderItems[indexx].sectionTitle),

                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                                    child: Text("x"),
                                                  ),

                                                  Text("${snapshot.data.data[index].orderItems[indexx].quantity}"),

                                                ],

                                              );
                                            }
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                      ),
                                      snapshot.data.data[index].notes != "" ? Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${AppLocalizations.of(context).translate("notes_Str")} :"  ,
                                            style: TextStyle(
                                                fontWeight: bolFont,
                                                fontSize: PrimaryFont),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data.data[index].notes,

                                              //  "13 al Reyadh street,Al Reyadh",
                                              style: TextStyle(
                                                  fontSize: PrimaryFont,
                                                  fontWeight: semiFont,
                                                  color: lightText),
                                            ),
                                          ),


                                        ],
                                      ):Container(),
                                      // Container(
                                      //   height: 8.0,
                                      // ),
                                      // delivery text will be false and true if the order is canceled down
//                                    snapshot.data.data[index].
                                      snapshot.data.data[index].cancel == "false" ? Wrap(
                                        children: <Widget>[
//                                        snapshot.data.data[index].delegateName != "" ?   Text(
//                                          "Delivery",
//                                          style: TextStyle(
//                                              fontSize: SecondaryFont,
//                                              fontWeight: semiFont,
//                                              color: Theme.of(context).primaryColor),
//                                        ):Container(),
                                          //                                 // delivery text will be false and true if the order is canceled up
                                          snapshot.data.data[index].hasProvider == "true" ?    Wrap(
                                            children: <Widget>[
                                              Container(
                                                height: 5.0,
                                              ),
                                              // delivery text will be false and true if the order is canceled down

//                                            Row(
//                                              children: <Widget>[
//                                                snapshot.data.data[index].delegateAvatar != "" ?    ClipRRect(
//                                                  borderRadius: new BorderRadius.circular(3.0),
//                                                  child: Image.network(
//                                                    snapshot.data.data[index].delegateAvatar,
//                                                    height: 50.0,
//                                                    width: 50.0,
//                                                  ),
//                                                ):Container(),
//                                                SizedBox(
//                                                  width:snapshot.data.data[index].delegateAvatar != "" ? 8.0:0.0,
//                                                ),
////                                                snapshot.data.data[index].delegateName != "" ?  Text(
////                                                  snapshot.data.data[index].delegateName,
////                                                  style: TextStyle(
////                                                      fontSize: PrimaryFont,
////                                                      fontWeight: semiFont,
////                                                      color: lightText),
////                                                ):Container(),
//                                              ],
//                                            ),
                                              // delivery text will be false and true if the order is canceled up
                                              Container(
                                                height: 12.0,
                                              ),
                                            ],
                                          ):Container(
                                            padding: EdgeInsets.only(top: 15.0),
                                            child: Text(
                                              AppLocalizations.of(context).translate("Waiting a delgate to approve")  ,
                                              style: TextStyle(
                                                  color: accentColor
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //                           color: Colors.red,
                                            height: 50.0,
                                            child:
                                            Stack(
                                              children: <Widget>[
                                                Container(
                                                  child: Center(
                                                    child: MySeparator(
                                                      height: 2.5,
                                                      color: Colors.blue.withOpacity(.1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        //      color: Colors.red,
                                                          height: MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                          child: Center(
                                                              child: Container(
                                                                // color: Colors.white.withOpacity(.4),
                                                                child: snapshot.data.data[index].hasProvider == "true"?Image.asset(
                                                                  "assets/images/checked.png",height: 30.0,width: 30.0,):Image.asset(
                                                                  "assets/images/unchecked.png",height: 30.0,width: 30.0,),
                                                              ))),Container(
                                                        //      color: Colors.red,
                                                          height: MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                          child: Center(
                                                              child: Container(
                                                                child: snapshot.data.data[index].inWay == "true" ? Image.asset(
                                                                  "assets/images/checked.png",height: 30.0,width: 30.0,):Image.asset(
                                                                  "assets/images/unchecked.png",height: 30.0,width: 30.0,),
                                                              ))),Container(
                                                        //      color: Colors.red,
                                                          height: MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                          child: Center(
                                                              child: Container(
                                                                child:snapshot.data.data[index].finish == "true" ? Image.asset(
                                                                  "assets/images/checked.png",height: 30.0,width: 30.0,):Image.asset(
                                                                  "assets/images/unchecked.png",height: 30.0,width: 30.0,),
                                                              ))),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: snapshot.data.data[index].hasProvider == "true" ?Text(AppLocalizations.of(context).translate("Recived"),
                                                  style: TextStyle(
                                                      fontWeight: regFont,
                                                      fontSize: SecondaryFont,
                                                      color: Theme.of(context).primaryColor
                                                  ),):Container(),
                                              ),
                                              snapshot.data.data[index].inWay == "true" ?Container(
                                                child: Text(
                                                  AppLocalizations.of(context).translate("On the way")
                                                  ,
                                                  style: TextStyle(
                                                      fontWeight: regFont,
                                                      fontSize: SecondaryFont,
                                                      color: Theme.of(context).primaryColor
                                                  ),),
                                              ):Container(),
                                              snapshot.data.data[index].finish == "true" ?    Container(
                                                child: Text(
                                                  AppLocalizations.of(context).translate("Done_str")

                                                  ,
                                                  style: TextStyle(
                                                      fontWeight: regFont,
                                                      fontSize: SecondaryFont,
                                                      color: Theme.of(context).primaryColor
                                                  ),),
                                              ):Container(),
                                            ],
                                          ),
                                        ],
                                      ):Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context).translate("Order has been canceled")

                                              ,
                                              style: TextStyle(
                                                  color: accentColor
                                              ),
                                            ),
                                            snapshot.data.data[index].message != "" ? Text(
                                              "${AppLocalizations.of(context).translate('cancel_message')} : ${snapshot.data.data[index].message}",
                                              style: TextStyle(
                                                  color: accentColor
                                              ),
                                            ):Container(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ):Center(
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    isStepsClicked.close();
    super.dispose();
  }
}



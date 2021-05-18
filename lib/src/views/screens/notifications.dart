import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/views/screens/delivery_follow_order.dart';
import 'package:medicine/src/views/screens/delivery_order_details.dart';
import 'package:medicine/src/views/screens/receipt.dart';
import 'package:medicine/theme_setting.dart';


class Notifications extends StatefulWidget {
  var notificationsData;
  Notifications(this.notificationsData);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  var GlobalUserType = locator<PrefsService>().userType == null ? locator<UserTypeBloc>().currentUserType:locator<PrefsService>().userType;



  @override
  Widget build(BuildContext context) {
    Widget _trashContainer() {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 90.0,
              width: 90.0,
              child: Image.asset("assets/images/delete_.png"),
              //Icon(Icons.delete,color: Colors.white,),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("Notifications_str")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
//            Navigator.pop(context);

          Navigator.pop(context);

//            Navigator.pushReplacement(
//                context,
//                new MaterialPageRoute(
//                    builder: (BuildContext
//                    context) =>
//                    GlobalUserType!= "delegate"? HomePage(locator<UserIdBloc>().currentUserId.toString()):DeliveyHomePage(locator<UserIdBloc>().currentUserId.toString())
//                ));

          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: widget.notificationsData.data.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  if(locator<PrefsService>().userType == null){}
                 else if(locator<PrefsService>().userType !="delegate"){
                    locator<IsLoadingManager>().isLoading.add(true);
                    ApiService.ShowOrder(widget.notificationsData.data[index].orderId).then((onValue){
                      locator<IsLoadingManager>().isLoading.add(false);
                      if(onValue.key == "1"){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => Receipt(onValue.data)));
                      }
                    });
                  }else{
                    locator<IsLoadingManager>().isLoading.add(true);

                    ApiService.ShowDelegateOrder(
                        widget.notificationsData.data[index].orderId).then((onValue) {
                      locator<IsLoadingManager>().isLoading.add(false);

                      if (onValue.key == "1") {
                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>
                            DeliveryOrderDetails(onValue.data)));
                      } else {
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(title: Text(onValue.msg),);});}
                    });
                  }
                },
                child: Dismissible(
                onDismissed: (direction) {
                  ApiService.NotificationDelete(widget.notificationsData.data[index].id).then((onValue){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(onValue.msg),
                        );
                      },
                    );
                    print("locator<PrefsService>().NotiCount${locator<PrefsService>().NotiCount}");
                    locator<PrefsService>().NotiCount -= 1;
                    print("locator<PrefsService>().NotiCount${locator<PrefsService>().NotiCount}");
                  });
                },
                  direction: DismissDirection.startToEnd,
                  background: _trashContainer(),
                  key: Key(widget.notificationsData.data[index].id.toString()),
                   child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: widget.notificationsData.data[index].userAvatar != null ?  ClipRRect(
                            borderRadius:
                            BorderRadius.all( Radius.circular(500.0)),
                            child: Image.asset(widget.notificationsData.data[index].userAvatar,fit: BoxFit.fill,),
                          ):Container(),
                          title: Text(widget.notificationsData.data[index].message.toString(),style: TextStyle(
                            fontSize: PrimaryFont,
                            fontWeight: bolFont,
                            color: littleGrey
                          ),),
                          subtitle:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(widget.notificationsData.data[index].date,style: TextStyle(
                                      fontSize: PrimaryFont,
                                      fontWeight: semiFont,
                                      color: littleGrey
                                  ),),
                                  SizedBox(width: 15.0,),
                                  Text(widget.notificationsData.data[index].dateFrom,style: TextStyle(
                                      fontSize: PrimaryFont,
                                      fontWeight: semiFont,
                                      color: littleGrey
                                  ),),
                                ],
                              ),
                              InkWell(
//                            onTap: (){},
                                child: Text(widget.notificationsData.data[index].type,style: TextStyle(
                                  fontSize: PrimaryFont,
                                  fontWeight: bolFont,
                                  color: Colors.red.withOpacity(.7),
                                  decoration: TextDecoration.underline,
                                ),),
                              ),
                            ],
                          ) ,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}

//class Notify {
//  final int id;
//  final String name;
//  final String desc;
//  final int price;
//  final String imgUrl;
//  final String time;
//  int count;
//
//  Notify(
//      this.id, this.name, this.desc, this.price, this.imgUrl, this.count,this.time);
//}


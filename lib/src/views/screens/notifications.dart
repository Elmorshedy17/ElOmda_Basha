import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/notifications_manger.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/models/delivery_models/all_notification_show_model.dart';
import 'package:medicine/src/views/screens/delivery_order_details.dart';
import 'package:medicine/src/views/screens/receipt.dart';
import 'package:medicine/theme_setting.dart';



class Notifications extends StatefulWidget {
  // var notificationsData;
  // Notifications(this.notificationsData);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  List<InnerData> allNotificationsList = [];

  @override
  void initState() {
    // locator<AllOrdersFilterBloc>().allOrdersFilterSink.add(filterHistory);
    locator<NotificationsBloc>().inCurrentPageController.add(1);
    loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
        locator<NotificationsBloc>().inIsLoadingOrders.add(true);
      }
    });
    super.initState();
  }

  void loadMore() {

    ApiService.AllNotificationShow()
        .then((onValue) {

      if (allNotificationsList.length < onValue.data.pagination.total) {
        currentPage++;
        locator<NotificationsBloc>().inCurrentPageController.add(currentPage);
        onValue.data.innerData.forEach((element) {
          allNotificationsList.add(element);
        });


      }
      locator<NotificationsBloc>().inIsLoadingOrders.add(false);
      locator<NotificationsBloc>().inAllNotifications.add(allNotificationsList);
    });

    print("yayayay${allNotificationsList.length}");
    print("currentPage${currentPage}");

  }


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



          },
        ),
      ),
      body: StreamBuilder<List<InnerData>>(
          stream: locator<NotificationsBloc>().allNotifications$,
          builder: (context, notificationsSnapshot) {
            return notificationsSnapshot.hasData?
           Container(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
              controller: _scrollController,
                itemCount: notificationsSnapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      if(locator<PrefsService>().userType == null){}
                     else if(locator<PrefsService>().userType !="delegate"){
                        locator<IsLoadingManager>().isLoading.add(true);
                        ApiService.ShowOrder(notificationsSnapshot.data[index].orderId).then((onValue){
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
                            notificationsSnapshot.data[index].orderId).then((onValue) {
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
                      ApiService.NotificationDelete(notificationsSnapshot.data[index].id).then((onValue){
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
                      key: Key(notificationsSnapshot.data[index].id.toString()),
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
                              leading: notificationsSnapshot.data[index].userAvatar != null ?  ClipRRect(
                                borderRadius:
                                BorderRadius.all( Radius.circular(500.0)),
                                child: Image.asset(notificationsSnapshot.data[index].userAvatar,fit: BoxFit.fill,),
                              ):Container(),
                              title: Text(notificationsSnapshot.data[index].message.toString(),style: TextStyle(
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
                                      Text(notificationsSnapshot.data[index].date,style: TextStyle(
                                          fontSize: PrimaryFont,
                                          fontWeight: semiFont,
                                          color: littleGrey
                                      ),),
                                      SizedBox(width: 15.0,),
                                      Text(notificationsSnapshot.data[index].dateFrom,style: TextStyle(
                                          fontSize: PrimaryFont,
                                          fontWeight: semiFont,
                                          color: littleGrey
                                      ),),
                                    ],
                                  ),
                                  InkWell(
//                            onTap: (){},
                                    child: Text(notificationsSnapshot.data[index].type,style: TextStyle(
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


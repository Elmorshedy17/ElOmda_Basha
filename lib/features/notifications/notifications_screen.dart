import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/notifications/notifications_manager.dart';
import 'package:momentoo/features/notifications/notifications_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/shared/widgets/no_available.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {


  ScrollController _scrollController = ScrollController();
  int maxPage = 5;
  int currentPage = 1;
  List allNotification = [];

  @override
  void initState() {
    locator<NotificationsManager>().inCurrentPageController.add(1);
    locator<NotificationsManager>().allNotifications.add(null);
    loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    super.initState();
  }



  void loadMore() {
    locator<NotificationsManager>().inIsLoadingNotifications.add(true);
    if(maxPage >= currentPage){
      NotificationsRepo.getNotificationsData(
          locator<NotificationsManager>().currentPageControllerValue)
          .then((onValue) {

        if (allNotification.length < onValue.data.notifications.total) {
          // locator<NotificationsManager>().inMaxPageController.add(onValue.data.notifications.lastPage);
          currentPage++;
          maxPage = onValue.data.notifications.lastPage;
          locator<NotificationsManager>().inCurrentPageController.add(currentPage);

          onValue.data.notifications.data.forEach((element) {
            if(!allNotification.contains(element)){
              allNotification..add(element);
            }
          });
        }
        locator<NotificationsManager>().inIsLoadingNotifications.add(false);
        locator<NotificationsManager>().inAllNotifications.add(allNotification);
      });

      print("currentPage${currentPage}");
    }
    // else{
    //   new Future.delayed( Duration(seconds: 1), () {
    //     // deleayed code here
    //     locator<NotificationsManager>().inIsLoadingNotifications.add(false);
    //   });
    // }
        locator<NotificationsManager>().inIsLoadingNotifications.add(false);


  }



  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('notifications_str'),
              style: TextStyle(
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
              ),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('back_str'),
                    style: TextStyle(
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: StreamBuilder(
                stream: locator<NotificationsManager>().allNotifications$,
                builder: (context, allNotificationsSnapshot) {
                  return allNotificationsSnapshot.hasData
                      ?  ListView(
                    controller: _scrollController,

                    // mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: allNotificationsSnapshot.data?.length ?? 0,
                    separatorBuilder: (_, index) => Divider(
                          height: 1,
                          indent: 5,
                          endIndent: 5,
                    ),
                    itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Transform.rotate(
                              angle: locator<PrefsService>().appLanguage == 'en'
                                  ? 145
                                  : -145,
                              child: Icon(
                                Icons.notifications,
                                color: Colors.teal.shade900,
                              ),
                            ),
                            title: Text(
                              allNotificationsSnapshot.data[index].message,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                              ),
                            ),
                            trailing: Text(
                              allNotificationsSnapshot.data[index].date,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 14,
                                fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                              ),
                            ),
                          ),
                    ),
                  ),
                ),

                          StreamBuilder(
                            initialData: false,
                            stream: locator<NotificationsManager>().isLoadingNotifications$,
                            builder: (context, indicatorSnapshot) {
                              return indicatorSnapshot.data == true ? Container(
                                height: 75,
                                child: Center(
                                  child: Theme(
                                    data: Theme.of(context).copyWith(accentColor: Colors.teal.shade900),
                                    child: new CupertinoActivityIndicator(),
                                  )
                                  // (),
                                ),
                              ):Container();
                            }
                          )

                        ],
                      ):noAvailable(
                      locator<PrefsService>().appLanguage == "en"
                          ? "there are no notification"
                          : "لا توجد اشعارات",
                      Icons.notifications_active_outlined);
              }
            ),
          ),
        ),
      ),
    );
  }
}


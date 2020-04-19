import 'package:flutter/material.dart';
import 'package:momentoo/features/notifications/notifications_manager.dart';
import 'package:momentoo/features/notifications/notifications_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
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
          child: Card(
            child: CustomObserver(
              stream: locator<NotificationsManager>().getData(),
              onSuccess: (_, NotificationsModel model) => ListView.separated(
                itemCount: model.data.notifications.data?.length ?? 0,
                separatorBuilder: (_, index) => Divider(
                  height: 1,
                  indent: 5,
                  endIndent: 5,
                ),
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Transform.rotate(
                      angle: 145,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.teal.shade900,
                      ),
                    ),
                    title: Text(
                      model.data.notifications.data[index].message,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                    trailing: Text(
                      model.data.notifications.data[index].date,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontFamily: locator<PrefsService>().appLanguage == 'en'
                            ? 'en'
                            : 'ar',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:momentoo/features/notifications/notifications_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class NotificationWidget extends StatelessWidget {
  final Function onPressedNotifications;
  const NotificationWidget({Key key, this.onPressedNotifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
            size: 30,
          ),
          onPressed: onPressedNotifications,
        ),
        Positioned(
          right: 9,
          top: 7,
          child: locator<PrefsService>().notificationFlag
              ? Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.teal),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: CustomObserver(
                    stream: locator<NotificationsManager>().count$,
                    onSuccess: (_, int count) => Text(
                      '$count',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    onWaiting: (_) => Container(),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}

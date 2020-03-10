import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/fcm/FcmTokenManager.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialize() async {
    if (Platform.isIOS) {
      // request permissions if we're on IOS
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.getToken().then((token) {
      print(token);
      locator<FcmTokenManager>().inFcm.add(token);
    });

    _fcm.configure(
      // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      // Called when the app has been closed completely and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
  }
}

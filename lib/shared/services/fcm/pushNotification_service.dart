import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:momentoo/features/invoice/invoice_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/NavigationService/NavigationService.dart';
import 'package:momentoo/shared/services/fcm/FcmTokenManager.dart';
import 'package:momentoo/shared/services/fcm/localNotificationService.dart';

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
        var title = message['notification']['title'];
        var body = message['notification']['body'];
        var id = message['data']['order_id'];
        /////////////////////////////////////////////////////////////////////////
        // LocalNotification
        locator<LocalNotificationService>().showNotification(title, body, id);
        /////////////////////////////////////////////////////////////////////////
        // _serializeAndNavigate(message);
      },
      // Called when the app has been closed completely and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');

        _serializeAndNavigate(message);
      },
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');

        _serializeAndNavigate(message);
      },
    );
  }

  void _serializeAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var orderId = notificationData['order_id'];

    if (orderId != null) {
      locator<NavigationService>().navigateTo(
        '/invoiceScreen',
        arguments: OrderDetailsArguments(
          id: int.parse(orderId),
        ),
      );
    }
  }
}

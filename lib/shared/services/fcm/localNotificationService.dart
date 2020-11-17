// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:momentoo/features/invoice/invoice_screen.dart';
// import 'package:momentoo/shared/helper/locator.dart';
// import 'package:momentoo/shared/services/NavigationService/NavigationService.dart';

// ////////////////////////////////////////////////////////////////////////////////
// // LocalNotification
// ////////////////////////////////////////////////////////////////////////////////

// class LocalNotificationService {
//   FlutterLocalNotificationsPlugin localNotifications;

//   initializeLocalNotification() {
//     var initializationSettingsAndroid =
//         new AndroidInitializationSettings("@drawable/ic_notifications");
//     var initializationSettingsIOS = new IOSInitializationSettings();
//     var initializationSettings = new InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOS);
//     localNotifications = new FlutterLocalNotificationsPlugin();
//     localNotifications.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   void showNotification(title, body, id) async {
//     var android = AndroidNotificationDetails(
//         'channelId', 'channelName', 'channelDescription',
//         color: Colors.teal.shade800);
//     var ios = IOSNotificationDetails();
//     var platform = NotificationDetails(android, ios);
//     await localNotifications.show(0, '$title', '$body', platform,
//         payload: '$id');
//   }

//   Future onSelectNotification(String payload) async {
//     if (payload != null) {
//       locator<NavigationService>().navigateTo(
//         '/invoiceScreen',
//         arguments: OrderDetailsArguments(
//           id: int.parse(payload),
//         ),
//       );
//     }
//   }
// }

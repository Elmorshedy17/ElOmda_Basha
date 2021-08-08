import 'dart:async';
import 'package:medicine/src/models/delivery_models/all_notification_show_model.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsBloc {

  final BehaviorSubject currentPageController = BehaviorSubject.seeded(1);
  Stream get isCurrentPageController$ => currentPageController.stream;
  Sink get inCurrentPageController => currentPageController.sink;
  int get currentPageControllerValue => currentPageController.value;


  final BehaviorSubject<List<InnerData>> allNotifications = BehaviorSubject<List<InnerData>>();
  Stream get allNotifications$ => allNotifications.stream;
  Sink get inAllNotifications => allNotifications.sink;

  final BehaviorSubject isLoadingOrders = BehaviorSubject.seeded(false);
  Stream get isLoadingOrders$ => isLoadingOrders.stream;
  Sink get inIsLoadingOrders => isLoadingOrders.sink;


  dispose() {
    currentPageController.close();
    allNotifications.close();
    isLoadingOrders.close();
  }

}


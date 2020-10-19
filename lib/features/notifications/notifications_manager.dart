import 'package:momentoo/features/notifications/notifications_model.dart';
import 'package:momentoo/features/notifications/notifications_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsManager implements Manager {
  final BehaviorSubject<NotificationsModel> _subject =
      BehaviorSubject<NotificationsModel>();

  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();
  Stream<int> get count$ => _countSubject.stream;

  Stream<NotificationsModel> getData(currentPage) {
    Stream.fromFuture(NotificationsRepo.getNotificationsData(currentPage)).listen((v) {
      _subject.add(v);
      _countSubject.add(v.data.notifications.data.length);
    });
    return _subject.stream;
  }


  final BehaviorSubject currentPageController = BehaviorSubject();
  Stream get isCurrentPageController$ => currentPageController.stream;
  Sink get inCurrentPageController => currentPageController.sink;
  int get currentPageControllerValue => currentPageController.value;

  final BehaviorSubject maxPageController = BehaviorSubject();
  Stream get isMaxPageController$ => maxPageController.stream;
  Sink get inMaxPageController => maxPageController.sink;
  int get maxPageControllerValue => maxPageController.value;


  final BehaviorSubject isLoadingNotifications = BehaviorSubject.seeded(false);
  Stream get isLoadingNotifications$ => isLoadingNotifications.stream;
  Sink get inIsLoadingNotifications => isLoadingNotifications.sink;


  final BehaviorSubject allNotifications = BehaviorSubject();
  Stream get allNotifications$ => allNotifications.stream;
  Sink get inAllNotifications => allNotifications.sink;


  @override
  void dispose() {
    _subject.close();
    _countSubject.close();
    currentPageController.close();
    isLoadingNotifications.close();
    allNotifications.close();
    maxPageController.close();
  }
}

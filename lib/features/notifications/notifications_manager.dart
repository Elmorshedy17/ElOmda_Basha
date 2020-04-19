import 'package:momentoo/features/notifications/notifications_model.dart';
import 'package:momentoo/features/notifications/notifications_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsManager implements Manager {
  final BehaviorSubject<NotificationsModel> _subject =
      BehaviorSubject<NotificationsModel>();

  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();
  Stream<int> get count$ => _countSubject.stream;

  Stream<NotificationsModel> getData() {
    Stream.fromFuture(NotificationsRepo.getNotificationsData()).listen((v) {
      _subject.add(v);
      _countSubject.add(v.data.notifications.data.length);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
    _countSubject.close();
  }
}

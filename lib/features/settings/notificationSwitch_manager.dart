import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class NotificationSwitchManager implements Manager {
  final BehaviorSubject<bool> _switchSubject =
      BehaviorSubject<bool>.seeded(true);

  bool get currentValue => _switchSubject.value;

  Stream<bool> get switch$ => _switchSubject.stream;
  Sink<bool> get inSwitch => _switchSubject.sink;

  void notificationSwitch(bool value) => _switchSubject.add(value);

  @override
  void dispose() {
    _switchSubject.close();
  }
}

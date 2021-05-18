import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SwitchNotyBloc {
/////////////// USER TYPE
  final BehaviorSubject<bool> _switchNotificationsSubject =
  BehaviorSubject<bool>.seeded(false);

  Stream<bool> get switchStream$ => _switchNotificationsSubject.stream;

  Sink<bool> get switchSink => _switchNotificationsSubject.sink;

  bool get currentswitch => _switchNotificationsSubject.value;

//  bool switchOn = false;

  void onSwitchChanged() {
//    switchOn = false;
    _switchNotificationsSubject.value =! currentswitch;
  }





  ////// lang switch

  final BehaviorSubject<bool> _switchLangSubject =
  BehaviorSubject<bool>.seeded(false);

  Stream<bool> get switchLangStream$ => _switchLangSubject.stream;

  Sink<bool> get langSink => _switchLangSubject.sink;

  bool get currentLang => _switchLangSubject.value;

//  bool switchOn = false;

  void onSwitchLangChanged() {
//    switchOn = false;
    _switchLangSubject.value =! currentLang;
  }


  dispose() {
    _switchNotificationsSubject.close();
    _switchLangSubject.close();
  }

}

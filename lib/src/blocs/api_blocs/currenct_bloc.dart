import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CurrencyBloc {
/////////////// USER TYPE
  final BehaviorSubject CurrencySubject =
  BehaviorSubject();

  dispose() {
    CurrencySubject.close();
  }

}

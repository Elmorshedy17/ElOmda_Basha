import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CurrencyBloc {
/////////////// USER TYPE
  final BehaviorSubject CurrencySubject = BehaviorSubject();
  final BehaviorSubject CurrencyRateSubject = BehaviorSubject();
  final BehaviorSubject counteryIdSubject = BehaviorSubject();

  dispose() {
    CurrencySubject.close();
    CurrencyRateSubject.close();
    counteryIdSubject.close();
  }

}

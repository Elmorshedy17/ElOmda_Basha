import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DiscountBloc {
/////////////// USER TYPE
  final BehaviorSubject<String> _discountSubject =
  BehaviorSubject<String>();

//  Stream<String> get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink<String> get discountSink => _discountSubject.sink;

  String get currentDiscount => _discountSubject.value;
  dispose() {
    _discountSubject.close();

  }
}

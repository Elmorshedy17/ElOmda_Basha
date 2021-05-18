import 'dart:async';
import 'package:rxdart/rxdart.dart';

class MyOrdersBloc {
/////////////// USER TYPE
  final BehaviorSubject _myOrdersDiscountSubject =
  BehaviorSubject();

  Stream get myOrdersDiscountStream$ => _myOrdersDiscountSubject.stream;

  Sink get myOrdersDiscountSink => _myOrdersDiscountSubject.sink;

   get CurrentmyOrdersDiscount => _myOrdersDiscountSubject.value;




    final BehaviorSubject _mytottalOrdersDiscountSubject =
  BehaviorSubject();

  Stream get mytottalOrdersDiscountStream$ => _mytottalOrdersDiscountSubject.stream;

  Sink get mytottalOrdersDiscountSink => _mytottalOrdersDiscountSubject.sink;

   get CurrentmytottalOrdersDiscount => _mytottalOrdersDiscountSubject.value;



   dispose() {
    _myOrdersDiscountSubject.close();
    _mytottalOrdersDiscountSubject.close();
  }
}

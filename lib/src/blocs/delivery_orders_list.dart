import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DeliveryOrdersListBloc {
/////////////// DeliveryOrdersListBloc
  final BehaviorSubject _deliveryOrderListSubject =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get deliveryOrderListSink => _deliveryOrderListSubject.sink;

   get currentDeliveryOrderList => _deliveryOrderListSubject.value;
  dispose() {
    _deliveryOrderListSubject.close();
  }
}

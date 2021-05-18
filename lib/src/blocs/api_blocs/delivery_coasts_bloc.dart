import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DeliveryCostaBloc {
/////////////// USER TYPE
  final BehaviorSubject<String> _deliveryCostsSubject =
  BehaviorSubject<String>();

  Stream<String> get deliveryCostsApiStream$ => _deliveryCostsSubject.stream;

  Sink<String> get deliveryCostsSink => _deliveryCostsSubject.sink;

  String get currentDeliveryCosts => _deliveryCostsSubject.value;
  dispose() {
    _deliveryCostsSubject.close();
  }
}

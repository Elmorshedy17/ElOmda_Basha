import 'dart:async';
import 'package:rxdart/rxdart.dart';

class StepperBloc {
/////////////// Stepper
  final BehaviorSubject<int> _stepperSubject =
  BehaviorSubject<int>();

  Stream<int> get stepperStream$ => _stepperSubject.stream;

  Sink<int> get stepperSink => _stepperSubject.sink;

  int get currentStepper => _stepperSubject.value;


// /////////////// Order Status
//  final BehaviorSubject<String> _orderStatusSubject =
//  BehaviorSubject<String>();
//
//  Stream<String> get orderStatusStream$ => _orderStatusSubject.stream;
//
//  Sink<String> get orderStatusSink => _orderStatusSubject.sink;
//
//  String get currentOrderStatus => _orderStatusSubject.value;



  dispose() {
    _stepperSubject.close();
//    _orderStatusSubject.close();
  }
}

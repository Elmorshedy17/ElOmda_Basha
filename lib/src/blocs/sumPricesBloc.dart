import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SumPricesBloc {
/////////////// Sum Prices Bloc
  final BehaviorSubject<int> _sunPricesSubject = BehaviorSubject<int>();

  Stream<int> get sumPricesStream$ => _sunPricesSubject.stream;

  Sink<int> get sumPricesSink => _sunPricesSubject.sink;

  int get currentSumPrices => _sunPricesSubject.value;

  dispose() {
    _sunPricesSubject.close();
  }
}

import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailsCounterManager implements Manager {
  BehaviorSubject<int> _counter = BehaviorSubject<int>.seeded(1);

  int get currentValue => _counter.value;

  Stream<int> get counter$ => _counter.stream;
  Sink<int> get inCounter => _counter.sink;

  void increment() => _counter.add(currentValue + 1);
  void decrement() => _counter.add(currentValue - 1);

  @override
  void dispose() {
    _counter.close();
  }
}

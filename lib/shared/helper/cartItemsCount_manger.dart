import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class CartItemsCountManager implements Manager {
  BehaviorSubject<int> _cartCount = BehaviorSubject<int>.seeded(0);

  Sink<int> get inCartCount => _cartCount.sink;
  Stream<int> get cartCount$ => _cartCount.stream;

  @override
  void dispose() {
    _cartCount.close();
  }
}

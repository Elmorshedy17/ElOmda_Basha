import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class DeliveryFeeManager implements Manager {
  // Seller ID
  final BehaviorSubject<String> _sellerIdSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inSellerId => _sellerIdSubject.sink;
  String get sellerIdValue => _sellerIdSubject.value;
  // City ID
  final BehaviorSubject<String> _cityIdSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inCityId => _cityIdSubject.sink;
  String get cityIdValue => _cityIdSubject.value;

  @override
  void dispose() {
    _sellerIdSubject.close();
    _cityIdSubject.close();
  }
}

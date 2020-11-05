import 'package:momentoo/features/shopping_cart/cartActions_model.dart';
import 'package:momentoo/features/shopping_cart/cartActions_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class CartActionsManager implements Manager {
  List<Products> products = [];
  final BehaviorSubject<CartActionsModel> _subject =
      BehaviorSubject<CartActionsModel>();

  // getFinalPrice
  final BehaviorSubject<double> _finalPriceSubject =
      BehaviorSubject<double>.seeded(0.0);
  Sink<double> get inFinalPrice => _finalPriceSubject.sink;
  double get getfinalPriceValue => _finalPriceSubject.value;

  final BehaviorSubject<String> _deliveryFeeSubject =
      BehaviorSubject.seeded('0');
  Sink<String> get inDeliveryFee => _deliveryFeeSubject.sink;
  String get getDeliveryFeeValue => _deliveryFeeSubject.value;

  Stream<CartActionsModel> getData() {
    Stream.fromFuture(CartActionsRepo.postCartData()).listen((v) {
      _subject.add(v);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
    _deliveryFeeSubject.close();
    _finalPriceSubject.close();
  }

  double getTotalPrice() {
    var totalPrice = 0.0;
    products.forEach((product) {
      totalPrice += double.parse(product.price) * int.parse(product.count);
    });

    return totalPrice;
  }

  double getFinalPrice() {
    // return getTotalPrice() + double.parse(seller.deliveryFee);
    var finalPrice = getTotalPrice() + double.parse(getDeliveryFeeValue);
    // inFinalPrice.add(finalPrice);
    return finalPrice;
  }
}

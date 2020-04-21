import 'package:momentoo/features/checkout/checkout_repo.dart';
import 'package:momentoo/features/checkout/checkout_response.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutManager implements Manager {
  final BehaviorSubject<CheckoutResponse> _subject =
      BehaviorSubject<CheckoutResponse>();

  // Stream<CouponResponse> getStreamData() {
  //   Stream.fromFuture(CouponRepo.postCouponData()).listen((v) {
  //     _subject.add(v);
  //   });
  //   return _subject.stream;
  // }

  Future<CheckoutResponse> getFutureData() {
    return CheckoutRepo.postCheckoutData();
  }

  @override
  void dispose() {
    _subject.close();
  }
}

import 'package:momentoo/features/checkout/coupon/coupon_repo.dart';
import 'package:momentoo/features/checkout/coupon/coupon_response.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class CouponManager implements Manager {
  final BehaviorSubject<CouponResponse> _subject =
      BehaviorSubject<CouponResponse>();

  // Stream<CouponResponse> getStreamData() {
  //   Stream.fromFuture(CouponRepo.postCouponData()).listen((v) {
  //     _subject.add(v);
  //   });
  //   return _subject.stream;
  // }

  Future<CouponResponse> getFutureData() {
    return CouponRepo.postCouponData();
  }

  @override
  void dispose() {
    _subject.close();
  }
}

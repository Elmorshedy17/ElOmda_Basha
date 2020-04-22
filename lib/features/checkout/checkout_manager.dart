import 'package:momentoo/features/checkout/checkout_repo.dart';
import 'package:momentoo/features/checkout/checkout_response.dart';

class CheckoutManager {
  Future<CheckoutResponse> checkoutAsUserFuture() {
    return CheckoutRepo.checkoutAsUser();
  }

  Future<CheckoutResponse> checkoutAsVisitorFuture() {
    return CheckoutRepo.checkoutAsVisitor();
  }
}

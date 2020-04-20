import 'package:momentoo/features/shopping_cart/cartActions_model.dart';
import 'package:momentoo/features/shopping_cart/cartActions_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class CartActionsManager implements Manager {
  final BehaviorSubject<CartActionsModel> _subject =
      BehaviorSubject<CartActionsModel>();

  Stream<CartActionsModel> getData() {
    Stream.fromFuture(CartActionsRepo.postCartData()).listen((v) {
      _subject.add(v);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
  }
}

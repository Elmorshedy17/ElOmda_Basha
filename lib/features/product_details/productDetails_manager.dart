import 'package:momentoo/features/product_details/productDetails_model.dart';
import 'package:momentoo/features/product_details/productDetails_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailsManager implements Manager {
  final BehaviorSubject<ProductDetailsModel> _subject =
      BehaviorSubject<ProductDetailsModel>();

  Stream<ProductDetailsModel> getData(int productId) {
    Stream.fromFuture(ProductDetailsRepo.getProductDetailsData(productId))
        .listen((v) {
      _subject.add(v);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
  }
}

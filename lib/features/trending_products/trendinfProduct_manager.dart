import 'package:momentoo/features/trending_products/trendingProduct_model.dart';
import 'package:momentoo/features/trending_products/trendingProduct_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class TrendingProductsManager implements Manager {
  final BehaviorSubject<TrendingProductsModel> _subject =
      BehaviorSubject<TrendingProductsModel>();

  Stream<TrendingProductsModel> getData(int categoryId) {
    Stream.fromFuture(TrendingProductsRepo.getTrendingProductData(categoryId))
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

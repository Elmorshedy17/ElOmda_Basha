import 'package:momentoo/features/trending_stores/trendingStore_model.dart';
import 'package:momentoo/features/trending_stores/trendingStore_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class TrendingStoreManager implements Manager {
  final BehaviorSubject<TrendingStoreModel> _subject =
      BehaviorSubject<TrendingStoreModel>();

  Stream<TrendingStoreModel> getData(int categoryId) {
    Stream.fromFuture(TrendingStoreRepo.getTrendingStoreData(categoryId))
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

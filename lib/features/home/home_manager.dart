import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class HomeManager implements Manager {
  final BehaviorSubject<HomeModel> _subject = BehaviorSubject<HomeModel>();

  Stream<HomeModel> getData(int categoryId) {
    Stream.fromFuture(HomeRepo.getHomeData(categoryId)).listen((v) {
      _subject.add(v);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
  }
}

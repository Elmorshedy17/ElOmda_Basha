import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class HomeManager implements Manager {
  final BehaviorSubject<HomeModel> _subject = BehaviorSubject<HomeModel>();
  final BehaviorSubject<List<SocialMedia>> _socialSubject =
      BehaviorSubject<List<SocialMedia>>();

  Stream<List<SocialMedia>> get socialMedia$ => _socialSubject.stream;

  Stream<HomeModel> getData(int categoryId) {
    Stream.fromFuture(HomeRepo.getHomeData(categoryId)).listen((v) {
      _subject.add(v);
      _socialSubject.add(v.data.socialMedia);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
    _socialSubject.close();
  }
}

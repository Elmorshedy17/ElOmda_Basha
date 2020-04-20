import 'package:momentoo/features/favorites/favorites_model.dart';
import 'package:momentoo/features/favorites/favorites_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesManager implements Manager {
  final BehaviorSubject<FavoritesModel> _subject =
      BehaviorSubject<FavoritesModel>();

  Stream<FavoritesModel> getData() {
    Stream.fromFuture(FavoritesRepo.getFavoritesData()).listen((v) {
      _subject.add(v);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
  }
}

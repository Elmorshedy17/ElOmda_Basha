import 'package:momentoo/features/favorites/favoriteActions_model.dart';
import 'package:momentoo/features/favorites/favoriteActions_repo.dart';
import 'package:momentoo/features/favorites/favorites_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesActionsManager implements Manager {
  final BehaviorSubject<FavoritesActionsModel> _subject =
      BehaviorSubject<FavoritesActionsModel>();

  // Stream<FavoritesActionsModel>
  addOrRemoveFavorite(String type, String action, String id) {
    Stream.fromFuture(FavoriteActionsRepo.postFavoritesData(type, action, id))
        .listen((v) {
      _subject.add(v);
      locator<FavoritesManager>().getData();
    });
    // return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
  }
}

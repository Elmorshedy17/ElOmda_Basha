import 'package:momentoo/features/search/search_model.dart';
import 'package:momentoo/features/search/search_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class SearchManager implements Manager {
  final BehaviorSubject<String> _querySubject = BehaviorSubject<String>();
  Sink<String> get inQuery => _querySubject.sink;
  // Stream<String> get query$ => _querySubject.stream;

  final PublishSubject<SearchModel> _searchResultSubject =
      PublishSubject<SearchModel>();
  // Stream<SearchModel> get searchResult$ => _searchResultSubject.stream;

  final BehaviorSubject<int> _categoryIdSubject =
      BehaviorSubject<int>.seeded(1);
  Sink<int> get inCategoryId => _categoryIdSubject.sink;

  final BehaviorSubject<String> _cuisineIdSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inCuisineId => _cuisineIdSubject.sink;

  final BehaviorSubject<String> _cityIdSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inCityId => _cityIdSubject.sink;

  Stream<SearchModel> getData() {
    Stream.fromFuture(
      SearchRepo.getData(
        _categoryIdSubject.value,
        _querySubject.value,
        _cuisineIdSubject.value,
        _cityIdSubject.value,
      ),
    ).listen((v) {
      _searchResultSubject.add(v);
    });

    return _searchResultSubject.stream;
  }

  // SearchManager() {
  //   _querySubject
  //       .debounceTime(Duration(milliseconds: 500))
  //       .switchMap((query) async* {
  //     yield await SearchRepo.getData(_categoryIdSubject.value, query);
  //   }).listen((searchResult) {
  //     _searchResultSubject.add(searchResult);
  //   });
  // }
  @override
  void dispose() {
    _querySubject.close();
    _searchResultSubject.close();
    _categoryIdSubject.close();
    _cuisineIdSubject.close();
    _cityIdSubject.close();
  }
}

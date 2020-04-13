import 'package:momentoo/features/home/autoComplete_model.dart';
import 'package:momentoo/features/home/autoComplete_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class AutoCompleteManager implements Manager {
  final PublishSubject<String> _querySubject = PublishSubject<String>();
  Sink<String> get inQuery => _querySubject.sink;
  Stream<String> get query$ => _querySubject.stream;
  final PublishSubject<AutoCompleteModel> _searchResultSubject =
      PublishSubject<AutoCompleteModel>();
  Stream<AutoCompleteModel> get searchResult$ => _searchResultSubject.stream;
  final BehaviorSubject<int> _categoryIdSubject =
      BehaviorSubject<int>.seeded(1);
  Sink<int> get inCategoryId => _categoryIdSubject.sink;

  AutoCompleteManager() {
    _querySubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((query) async* {
      yield await AutoCompleteRepo.getData(_categoryIdSubject.value, query);
    }).listen((searchResult) {
      _searchResultSubject.add(searchResult);
    });
  }
  @override
  void dispose() {
    _querySubject.close();
    _searchResultSubject.close();
    _categoryIdSubject.close();
  }
}

import 'dart:async';
import 'package:rxdart/rxdart.dart';

class HomePageBloc {
/////////////// USER TYPE
  final BehaviorSubject _homePageSubject =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get homePageSink => _homePageSubject.sink;

  String get currentHomePage => _homePageSubject.value;


  ////// search with title

final BehaviorSubject _searchSubject =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get searchSink => _searchSubject.sink;

  String get currenSearch => _searchSubject.value;
  dispose() {
    _searchSubject.close();
    _homePageSubject.close();
  }
}

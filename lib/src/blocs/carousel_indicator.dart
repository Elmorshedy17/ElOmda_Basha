import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CarouselIndicatorBloc {
/////////////// USER TYPE
  final BehaviorSubject<int> _carouselIndSubject =
  BehaviorSubject<int>();

  Stream<int> get carouselIndStream$ => _carouselIndSubject.stream;

  Sink<int> get carouselIndSink => _carouselIndSubject.sink;

  int get currentCarouselInd => _carouselIndSubject.value;
  dispose() {
    _carouselIndSubject.close();
  }
}

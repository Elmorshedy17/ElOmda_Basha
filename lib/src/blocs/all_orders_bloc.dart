import 'dart:async';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:rxdart/rxdart.dart';
final prefs = locator<PrefsService>();

class AllOrdersFilterBloc {
/////////////// USER TYPE

  final BehaviorSubject allOrdersFilterBloc = BehaviorSubject.seeded("");
  final BehaviorSubject downloadUrlSubject = BehaviorSubject.seeded("");

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get allOrdersFilterSink => allOrdersFilterBloc.sink;

  String get currentAllOrdersFilter => allOrdersFilterBloc.value;


  Function(String) get orderIdFilterBlocOnChange => orderIdFilterBloc.sink.add;
  Function(String) get phoneFilterBlocOnChange => phoneFilterBloc.sink.add;

  final BehaviorSubject orderIdFilterBloc = BehaviorSubject.seeded("");
  // final BehaviorSubject countryIdFilterBloc = BehaviorSubject.seeded("");
  // final BehaviorSubject cityIdFilterBloc = BehaviorSubject.seeded("");
  final BehaviorSubject providerIdFilterBloc = BehaviorSubject.seeded("");
  final BehaviorSubject phoneFilterBloc = BehaviorSubject.seeded("");
  final BehaviorSubject startDateFilterBloc = BehaviorSubject.seeded("");
  final BehaviorSubject endDateFilterBloc = BehaviorSubject.seeded("");

  final BehaviorSubject allOrdersFilterBlocName = BehaviorSubject.seeded("");



  void clearFilter(){
    // countryIdFilterBloc.sink.add("");
    // cityIdFilterBloc.sink.add("");

    orderIdFilterBloc.sink.add("");
    phoneFilterBloc.sink.add("");
    allOrdersFilterBloc.sink.add("");
    orderIdFilterBloc.sink.add("");
    providerIdFilterBloc.sink.add("");
    startDateFilterBloc.sink.add("");
    endDateFilterBloc.sink.add("");
    counterySink.add(locator<PrefsService>().appLanguage == "en"?"choose countery":"اختر دولة");
    counteryIdSink.add("");
    chosenCitySink.add(locator<PrefsService>().appLanguage == "en"?"choose City":"اختر مدينة");
    cityIdSink.add("");
    allOrdersFilterBlocName.add("");
    // chosenCitySink.add("");
  }


  final BehaviorSubject _allTypesOrdersFilterBloc =
  BehaviorSubject.seeded("");

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get allTypsOrdersFilterSink => _allTypesOrdersFilterBloc.sink;

  String get currentAllTypsOrdersFilter => _allTypesOrdersFilterBloc.value;

///////////////
  final BehaviorSubject _newOrderSubject =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get newOrderSink => _newOrderSubject.sink;

  get currentnewOrder => _newOrderSubject.value;
////

  ////     cities  to get all cities inside one countery   //////
  final BehaviorSubject _citiesSubject =
  BehaviorSubject.seeded("");

  Stream get citiesStream$ => _citiesSubject.stream;

  Sink get citiesSink => _citiesSubject.sink;

  get currentcities => _citiesSubject.value;
////
//
//  void dropCityChanged(dynamic val) {
//      dropCityVal = val;
//  }
  dynamic dropCityVal ;



/////////////// counteries choosen
  final BehaviorSubject _counterySubject =
  BehaviorSubject.seeded(locator<PrefsService>().appLanguage == "en"?"choose countery":"اختر دولة");

  Stream get counteryStream$ => _counterySubject.stream;

  Sink get counterySink => _counterySubject.sink;

  get currentCountery => _counterySubject.value;
////






/////////////// counterie id
  final BehaviorSubject _counteryIdSubject =
  BehaviorSubject.seeded(locator<PrefsService>().appLanguage == "en"?"choose countery":"اختر دولة");

  Stream get counteryIdStream$ => _counteryIdSubject.stream;

  Sink get counteryIdSink => _counteryIdSubject.sink;

  get currentCounteryId => _counteryIdSubject.value;
////








/////////////// city id
  final BehaviorSubject _cityIdSubject =
  BehaviorSubject.seeded(locator<PrefsService>().appLanguage == "en"?"choose countery":"اختر دولة");

  Stream get cityIdStream$ => _cityIdSubject.stream;

  Sink get cityIdSink => _cityIdSubject.sink;

  get currentCityId => _cityIdSubject.value;
////









/////////////// cities titles & ids
  final BehaviorSubject _cityIdTitleSubject =
  BehaviorSubject.seeded(locator<PrefsService>().appLanguage == "en"?"choose countery":"اختر دولة");

  Stream get cityIdTitleStream$ => _cityIdTitleSubject.stream;

  Sink get cityIdTitleSink => _cityIdTitleSubject.sink;

  get currentCityIdTitle => _cityIdTitleSubject.value;
////





/////////////// citiy shoosen to get chosen countery
  final BehaviorSubject _chosenCitySubject =
  BehaviorSubject.seeded(locator<PrefsService>().appLanguage == "en"?"choose City":"اختر مدينة");

  Stream get chosenCityStream$ => _chosenCitySubject.stream;

  Sink get chosenCitySink => _chosenCitySubject.sink;

  get currentChosenCity => _chosenCitySubject.value;
////



/////////////// location lat
  final BehaviorSubject _latLocationSubject =
  BehaviorSubject();

  Stream get latLocationStream$ => _latLocationSubject.stream;

  Sink get latLocationSink => _latLocationSubject.sink;

  get currentLatLocation => _latLocationSubject.value;
////



/////////////// location long
  final BehaviorSubject _longLocationSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get longLocationSink => _longLocationSubject.sink;

  get currentlongLocation => _longLocationSubject.value;
////



/////////////// location lat second
  final BehaviorSubject _secondLatLocationSubject =
  BehaviorSubject();

  Stream get secondLatLocationStream$ => _secondLatLocationSubject.stream;

  Sink get secondLatLocationSink => _secondLatLocationSubject.sink;

  get currentSecondLatLocation => _secondLatLocationSubject.value;
////



/////////////// location long
  final BehaviorSubject _secondLongLocationSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _secondLongLocationSubject.stream;

  Sink get SecondLongLocationSink => _secondLongLocationSubject.sink;

  get currentSecondlongLocation => _secondLongLocationSubject.value;
////


/////////////// name
  final BehaviorSubject _nameSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get nameSink => _nameSubject.sink;

  get currentname => _nameSubject.value;
////




/////////////// phone code
  final BehaviorSubject _phoneCodeSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get phoneCodeSink => _phoneCodeSubject.sink;

  get currentPhoneCode => _phoneCodeSubject.value;
////




/////////////// phone number
  final BehaviorSubject _phoneNumberSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get phoneNumberSink => _phoneNumberSubject.sink;

  get currentPhoneNumber => _phoneNumberSubject.value;
////


  // final notificationsRepo = NotificationsRepo();
  // final PublishSubject<ApiResponse<NotificationsData>> homeSubject =
  // PublishSubject<ApiResponse<NotificationsData>>();



  // @override
  // Stream<ApiResponse<NotificationsData>> streamDataObj({id}) {
  //   Stream.fromFuture(notificationsRepo.apiGet()).listen((result) {
  //     result.error == null
  //         ? homeSubject.add(result)
  //         : homeSubject.addError(result.error);
  //   });
  //   return homeSubject.stream;
  // }



  final BehaviorSubject currentPageController =
  BehaviorSubject.seeded(1);
  Stream get isCurrentPageController$ => currentPageController.stream;
  Sink get inCurrentPageController => currentPageController.sink;
  int get currentPageControllerValue => currentPageController.value;


  final BehaviorSubject isLoadingOrders = BehaviorSubject.seeded(false);
  Stream get isLoadingOrders$ => isLoadingOrders.stream;
  Sink get inIsLoadingOrders => isLoadingOrders.sink;
  final BehaviorSubject<int> countSubject = BehaviorSubject<int>();


  final BehaviorSubject allOrders = BehaviorSubject();
  Stream get allOrders$ => allOrders.stream;
  Sink get inAllOrders => allOrders.sink;


  Stream<int> get count$ => countSubject.stream;



  dispose() {
    allOrdersFilterBloc.close();
    _allTypesOrdersFilterBloc.close();

    orderIdFilterBloc.close();
    // countryIdFilterBloc.close();
    // cityIdFilterBloc.close();
    providerIdFilterBloc.close();
    phoneFilterBloc.close();
    startDateFilterBloc.close();
    endDateFilterBloc.close();
    _chosenCitySubject.close();
    _counterySubject.close();
    _citiesSubject.close();
    allOrdersFilterBlocName.close();
    downloadUrlSubject.close();
  }

}


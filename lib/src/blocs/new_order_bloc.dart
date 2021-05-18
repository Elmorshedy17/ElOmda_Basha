import 'dart:async';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class NewOrderBloc {
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









/////////////// whatasapp code
  final BehaviorSubject _whatsAppCodeSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get whatsAppCodeSink => _whatsAppCodeSubject.sink;

  get currentWhatsappCode => _whatsAppCodeSubject.value;
////




/////////////// whatasapp number
  final BehaviorSubject _whatsAppNumberSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get whatsAppNumberSink => _whatsAppNumberSubject.sink;

  get currentwhatsAppNumber => _whatsAppNumberSubject.value;
////





/////////////// email
  final BehaviorSubject _emailSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get emailSink => _emailSubject.sink;

  get currentEmail => _emailSubject.value;
////




/////////////// delivery Date
  final BehaviorSubject _deliveryDateSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get deliveryDateSink => _deliveryDateSubject.sink;

  get currentDeliveryDate => _deliveryDateSubject.value;
////






/////////////// adress
  final BehaviorSubject _adressSubject =
  BehaviorSubject();

//  Stream get longLocationStream$ => _longLocationSubject.stream;

  Sink get adressSink => _adressSubject.sink;

  get currentAdress => _adressSubject.value;
////


  final BehaviorSubject notesSubject = BehaviorSubject();


/////////////// Date & Time
  final BehaviorSubject _dateTimeSubject =
  BehaviorSubject();

  Stream get dateTimeSubject$ => _dateTimeSubject.stream;

  Sink get dateTimeSink => _dateTimeSubject.sink;

  get currentdateTime => _dateTimeSubject.value;
////


  dispose() {
    _chosenCitySubject.close();
    _counterySubject.close();
    _citiesSubject.close();
  }


}

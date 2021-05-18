import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/new_order_bloc.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/views/screens/after_order.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:medicine/src/views/screens/verificationCode.dart';
import 'package:medicine/theme_setting.dart';
//import 'package:location/location.dart';lat
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';


class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  dynamic dropFirstVal = "+966";
  bool isSecuredPassword = true;
  bool isSecuredConfirm = true;

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController whatsAppNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController adrLocation = TextEditingController();
  TextEditingController notesController = TextEditingController();

  BehaviorSubject isNewOrder = new BehaviorSubject.seeded(false);


  int radioGroup = 1;

  void dropFirstChanged(dynamic val) {
    setState(() {
      dropFirstVal = val;
    });
  }

  dynamic dropSecVal = "+966";

  dynamic dropCountryVal;

  void dropSecChanged(dynamic val) {
    setState(() {
      dropSecVal = val;
    });
  }

  dynamic dropCityVal;

  void dropCityChanged(dynamic val) {
    setState(() {
      dropCityVal = val;
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("New_Order_str")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
//            Navigator.pop(context);
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(locator<UserIdBloc>().currentUserId.toString())));
          },
        ),
      ),
      body: StreamBuilder(
        stream: isNewOrder.stream,
        builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _namesFiled(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _phoneFiled(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _whatsappFiled(),
                      // _optional(),
                      SizedBox(
                        height: 20.0,
                      ),
                      // _emailFiled(),
                      // SizedBox(
                      //   height: 15.0,
                      // ),
                      _counteryCity(),
//              SizedBox(
//                height: 15.0,
//              ),
//              _locationFiled(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _adressFiled(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _notesFiled(),
                      SizedBox(
                        height: 15.0,
                      ),
                      // _deliveryTime(),
                      // _optional(),

                      SizedBox(
                        height: 45.0,
                      ),
                      _submitButtom(),
                    ],
                  ),
                )),
              ),
              isNewOrder.value == true ?  Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.5),
                child: Center(child: CircularProgressIndicator()),
              ):Container(),
            ],
          );
        }
      ),
    );
  }

  Widget _namesFiled() {
    return TextField(
      controller: name,
      onChanged: (val) {
        locator<NewOrderBloc>().nameSink.add(name.text);
      },
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate('first_name_str'),
          labelText: AppLocalizations.of(context).translate('first_name_str'),
          border: OutlineInputBorder()),
    );
  }

  Widget _emailFiled() {
    return TextField(
      controller: email,
      onChanged: (val) {
        locator<NewOrderBloc>().emailSink.add(email.text);
      },
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate('email_str'),
          labelText: AppLocalizations.of(context).translate('email_str'),
          //errorText: snapshot.error,
          border: OutlineInputBorder()),
    );
  }

  Widget _counteryCity() {
    return Row(
      children: <Widget>[
        FutureBuilder(
            future: ApiService.AllCountriesAndCities(),
            builder: (context, snapshot) {
              var countries = [];
              var countryId = [];
              var cities = [];
              var citiesIdTitle = [];
              var citiesId = [];
              if (snapshot.hasData) {
                for (int index = 0;
                    index < snapshot.data.data.length;
                    index++) {
                  countries.add(snapshot.data.data[index].title);
                }
              } else {
                var countries = ["السعوديه"];
              }
              return Expanded(
                child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            content: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Scrollbar(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: countries.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        4)),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          locator<NewOrderBloc>()
                                              .counterySink
                                              .add(countries[index]);
                                          print(
                                              "locator<NewOrderBloc>().counterySink.add(countries[index])${locator<NewOrderBloc>().currentCountery}");
                                          Navigator.pop(context);
                                          locator<NewOrderBloc>()
                                              .chosenCitySink
                                              .add("");
                                          cities.clear();

//                                          for(int index = 0; index < snapshot.data.data.length; index++){
//                                               if(snapshot.data.data[index].cities.title.contains(locator<NewOrderBloc>().currentChosenCity)  ){
//                                                 citiesId.add(snapshot.data.data[index].cities.id);
//                                               }
//                                          }

//                                          for (int index = 0; index < snapshot.data.data.length; index++) {
//                                            if (snapshot.data.data[index].title.contains(locator<NewOrderBloc>().currentCountery)) {
//                                              countryId.add(snapshot.data.data[index].id);
//                                              for (int ind = 0; ind < snapshot.data.data[index].cities.length; ind++) {
////                                                cities.add(snapshot.data.data[index].cities[ind].title);
//                                                if(snapshot.data.data[index].cities[ind].title.contains(locator<NewOrderBloc>().currentChosenCity)  ){
//                                                  citiesId.add(snapshot.data.data[index].cities.id);
//                                                }
//                                              }
//                                            }
//                                          }

                                          for (int index = 0; index < snapshot.data.data.length; index++) {
                                            if (snapshot.data.data[index].title.contains(locator<NewOrderBloc>().currentCountery)) {
                                              countryId.add(snapshot.data.data[index].id);
                                              for (int ind = 0; ind < snapshot.data.data[index].cities.length; ind++) {
                                                cities.add(snapshot.data.data[index].cities[ind].title);
                                                citiesIdTitle.add(snapshot.data.data[index].cities[ind]);
                                              }
                                            }
                                          }
                                          locator<NewOrderBloc>().cityIdTitleSink.add(citiesIdTitle);

//                                          print("------------------------------------------------------- ${citiesId[0].id} ------------------------");

                                          //
                                          locator<NewOrderBloc>().counteryIdSink.add(snapshot.data.data[index].id);
                                          print("locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId locator<NewOrderBloc>().currentCounteryId ${locator<NewOrderBloc>().currentCounteryId}");
//
                                          locator<NewOrderBloc>()
                                              .citiesSink
                                              .add(cities);
                                        },
                                        child: Center(
                                            child: Text(
                                          countries[index],
                                          textAlign: TextAlign.center,
                                        )),
                                      );
                                    }),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 60.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: Center(
                          child: StreamBuilder(
                            initialData: "",
                              stream: locator<NewOrderBloc>().counteryStream$,
                              builder: (context, snapshot) {
                                return Text(snapshot.data);
                              })),
                    )),
              );
            }),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return StreamBuilder(
                      initialData: "",
                        stream: locator<NewOrderBloc>().citiesStream$,
                        builder: (context, snapshot) {
                          return AlertDialog(
                            content: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Scrollbar(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        4)),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          locator<NewOrderBloc>()
                                              .chosenCitySink
                                              .add(locator<NewOrderBloc>()
                                                  .currentcities[index]);

                                          for(int ind = 0 ; ind < locator<NewOrderBloc>().currentCityIdTitle.length; ind ++){
                                            if(locator<NewOrderBloc>().currentCityIdTitle[ind].title.contains(locator<NewOrderBloc>()
                                                    .currentChosenCity)){
                                              locator<NewOrderBloc>().cityIdSink.add(locator<NewOrderBloc>().currentCityIdTitle[ind].id);
                                            }
                                          }

                                          print(
                                              "locator<NewOrderBloc>().counterySink.add(countries[index])${locator<NewOrderBloc>().currentCityId} h hahah ------------");
                                          Navigator.pop(context);
//                                        Navigator.of(context);
                                        },
                                        child: Center(
                                            child: Text(snapshot.data[index])),
                                      );
                                    }),
                              ),
                            ),
                          );
                        });
                  },
                );
              },
              child: Container(
                height: 60.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: Center(
                    child: StreamBuilder(
                      initialData: "",
                        stream: locator<NewOrderBloc>().chosenCityStream$,
                        builder: (context, snapshot) {
                          return Text(snapshot.data);
                        })),
              )),
        )
      ],
    );
  }

  Widget _phoneFiled() {
    return Row(
      children: <Widget>[
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5.0),
        //     border: Border.all(
        //         color: Colors.grey, style: BorderStyle.solid, width: 0.80),
        //   ),
        //   child: DropdownButton<dynamic>(
        //     //hint: Text(dropFirstVal),
        //     onChanged: dropFirstChanged,
        //     value: dropFirstVal,
        //     items: [
        //       //  "+20", "+65", "+95"
        //       "+93","+213","+973","+269","+20","+251","+62","+98","+964","+962","+965","+961","+218","+60","+212","+234","+968","+92","+970","+974","+966","+249","+963","+216","+90","+971","+967"
        //     ]
        //         .map<DropdownMenuItem<dynamic>>((dynamic value) {
        //       return DropdownMenuItem(
        //         child: Text(value),
        //         value: value,
        //       );
        //     }).toList(),
        //   ),
        // ),
        // SizedBox(
        //   width: 15.0,
        // ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: phoneNumber,
            onChanged: (val) {
              locator<NewOrderBloc>().phoneNumberSink.add(phoneNumber.text);
            },
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context).translate('phone_str'),
                labelText: AppLocalizations.of(context).translate('phone_str'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }

  Widget _whatsappFiled() {
    return Row(
      children: <Widget>[
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10.0),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5.0),
        //     border: Border.all(
        //         color: Colors.grey, style: BorderStyle.solid, width: 0.80),
        //   ),
        //   child: DropdownButton<dynamic>(
        //     //hint: Text(dropFirstVal),
        //     onChanged: dropSecChanged,
        //     value: dropSecVal,
        //     items: [
        //       //  "+20", "+65", "+95"
        //       "+93","+213","+973","+269","+20","+251","+62","+98","+964","+962","+965","+961","+218","+60","+212","+234","+968","+92","+970","+974","+966","+249","+963","+216","+90","+971","+967"
        //     ]
        //         .map<DropdownMenuItem<dynamic>>((dynamic value) {
        //       return DropdownMenuItem(
        //         child: Text(value),
        //         value: value,
        //       );
        //     }).toList(),
        //   ),
        // ),
        // SizedBox(
        //   width: 15.0,
        // ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: whatsAppNumber,
            onChanged: (val) {
              locator<NewOrderBloc>()
                  .whatsAppNumberSink
                  .add(whatsAppNumber.text);
            },
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context).translate('phone_str'),
                labelText: AppLocalizations.of(context).translate('phone_str'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }

  Widget _optional() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            AppLocalizations.of(context).translate('optional_str'),
            style: TextStyle(
              fontSize: PrimaryFont,
              fontWeight: semiFont,
              color: Theme.of(context).primaryColor,
              // decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _adressFiled() {
    return TextField(
      controller: adrLocation,
      onChanged: (val) {
        locator<NewOrderBloc>().adressSink.add(adrLocation.text);
      },
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("Adress_str"),
          labelText: AppLocalizations.of(context).translate("Adress_str"),
          border: OutlineInputBorder()),
    );
  }



  Widget _notesFiled() {
    return TextField(
      controller: notesController,
      onChanged: (val) {
        locator<NewOrderBloc>().notesSubject.add(notesController.text);
      },
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("notes_Str"),
          labelText: AppLocalizations.of(context).translate("notes_Str"),
          border: OutlineInputBorder()),
    );
  }

//  Widget _locationFiled() {
//    return Container(
//      height: MediaQuery.of(context).size.height /2,
//      width:  MediaQuery.of(context).size.width,
//      child: MapSample(),
//    );
//  }

  //  Widget _locationFiled() {
//    return InkWell(
//      child: Container(
//          height: 60.0,
//          width: MediaQuery.of(context).size.width,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(5.0),
//            border: Border.all(
//                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
//          ),
//          child: StreamBuilder(
//              stream: locator<NewOrderBloc>().latLocationStream$,
//              builder: (context, snapshot) {
//                return Center(
//                    child: snapshot.hasData
//                        ? Text(
//                            "lat: ${snapshot.data.toString()}      long: ${locator<NewOrderBloc>().currentlongLocation} ")
//                        : Text("Adress"));
//              })),
//      onTap: () {
//        var location = new Location();
//        location.onLocationChanged().listen((LocationData currentLocation) {
//          locator<NewOrderBloc>().latLocationSink.add(currentLocation.latitude);
//          locator<NewOrderBloc>()
//              .longLocationSink
//              .add(currentLocation.longitude);
//
//          print(currentLocation.latitude);
//          print(currentLocation.longitude);
//        });
//      },
//    );
//  }

//  Widget _locationFiled() {
//    return InkWell(
//      child: Container(
//          height: 60.0,
//          width: MediaQuery.of(context).size.width,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(5.0),
//            border: Border.all(
//                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
//          ),
//          child: StreamBuilder(
//              stream: locator<NewOrderBloc>().latLocationStream$,
//              builder: (context, snapshot) {
//                return Center(
//                    child: snapshot.hasData
//                        ? Text(
//                            " ${AppLocalizations.of(context).translate("lat:_Str")} ${snapshot.data.toString()}      ${AppLocalizations.of(context).translate("long:_Str")} ${locator<NewOrderBloc>().currentlongLocation} ")
//                        : Text(AppLocalizations.of(context).translate("Location_str")));
//              })),
//      onTap: () {
//        Navigator.push(
//            context,
//            new MaterialPageRoute(
//                builder: (BuildContext
//                context) =>
//                    MapSample()));
//      },
//    );
//  }

//   Widget _deliveryTime() {
// //    return TextField(
// //      decoration: InputDecoration(
// //          hintText: "Delivery time",
// //          labelText: "Delivery time",
// //          border: OutlineInputBorder()),
// //    );
//
//     return BasicDateTimeField();
//   }

  _submitButtom() {
    return Container(
      width: double.infinity,
      child: ButtonTheme(
        height: 60.0,
        child: StreamBuilder(
          stream: locator<NewOrderBloc>().dateTimeSubject$,
          builder: (context, dateTimeSnapshot) {
            print("dateTimeSnapshot $dateTimeSnapshot ");
            return RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
              child: Text(
                AppLocalizations.of(context).translate("Send_Order_str")   ,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MainFont,
                  fontWeight: semiFont,
                ),
              ),
              onPressed:(){
                isNewOrder.add(true);
//            var dayToString = locator<NewOrderBloc>().currentdateTime.toString();
//            DateTime dateo = DateTime.parse(dayToString);
//            String dateFormat = DateFormat('yyyy-MM-dd HH:mm aaa').format(dateo);
//
//            print("String dateFormat = DateFormat('EEEE').format(dateo); ${dateFormat}");

                ApiService.StoreOrder(
                    // dropFirstVal,dropSecVal,
                    name.text,phoneNumber.text,whatsAppNumber.text,email.text,adrLocation.text,notesController.text).then((data) {
                  if(data.key == "1"){
                    isNewOrder.add(false);

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => AfterOrder(data)));

                  }else{
                    isNewOrder.add(false);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(data.msg),
                        );
                      },
                    );
                  }
                });

              },
            );
          }
        ),
      ),
    );
  }


  void dispose() {
    name.dispose();
    phoneNumber.dispose();
    whatsAppNumber.dispose();
    email.dispose();
    adrLocation.dispose();
    isNewOrder.close();
    notesController.dispose();
    super.dispose();
  }
}

// class BasicDateTimeField extends StatelessWidget {
// //  final format = DateFormat("yyyy-MM-dd HH:mm aa");
//   final format = DateFormat("yyyy-MM-dd HH:mm ");
//
//   @override
//   Widget build(BuildContext context) {
//     return DateTimeField(
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
// //          errorText: snapshot.error,
//         border: OutlineInputBorder(),
// //        suffixIcon: Icon(Icons.calendar_today),
//         //  labelText: AppLocalizations.of(context).translate('date_str'),
//         hintText:AppLocalizations.of(context).translate("Delivery_Time_str") ,
//       ),
//       readOnly: true,
//       format: format,
//       onShowPicker: (context, currentValue) async {
//         final date = await showDatePicker(
//             context: context,
//             firstDate: DateTime.now(),
//             initialDate: DateTime.now().add(Duration(hours: 1)),
//             lastDate: DateTime(2100));
//         if (date != null) {
//           final time = await showTimePicker(
//             context: context,
//             initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//           );
//
//
//
//
//           var importantTime = DateTimeField.combine(date, time).toString();
// //          var importantTime = DateTimeField.combine(date, time.replacing(hour: time.hourOfPeriod)).toString();
//           DateTime dateo = DateTime.parse(importantTime);
//           String dateFormat = DateFormat("yyyy-MM-dd HH:mm").format(dateo);
//
// //          locator<NewOrderBloc>().dateTimeSink.add(DateTimeField.combine(date, time).toString());
//
//           locator<NewOrderBloc>().dateTimeSink.add(dateFormat);
//
//
// //          print("String dateFormat = DateFormat('EEEE').format(dateo); ${dateFormat}");
//
// //          var dayToString = locator<NewOrderBloc>().currentdateTime.toString();
// //          DateTime dateo = DateTime.parse(dayToString);
// //          String dateFormat = DateFormat('EEEE').format(dateo);
// //
// //          print("String dateFormat = DateFormat('EEEE').format(dateo); ${dateFormat}");
//
//           return DateTimeField.combine(date, time);
//         } else {
//           return currentValue;
//         }
//       },
//     );
//   }
//
// }


//
//
//class MapSample extends StatefulWidget {
//  @override
//  State<MapSample> createState() => MapSampleState();
//}
//
//class MapSampleState extends State<MapSample> {
//
//  _mapTapped(LatLng location) {
//    print(location);
//    locator<NewOrderBloc>().longLocationSink.add(location.longitude);
//    locator<NewOrderBloc>().latLocationSink.add(location.latitude);
////    Navigator.of(context);
//    Navigator.pop(context);
//// The result will be the location you've been selected
//// something like this LatLng(12.12323,34.12312)
//// you can do whatever you do with it
//
//  }
//
//  Completer<GoogleMapController> _controller = Completer();
//  final Map<String, Marker> _markers = {};
//
//  static final CameraPosition _kGooglePlex = CameraPosition(
//    target: LatLng(locator<NewOrderBloc>().currentLatLocation, locator<NewOrderBloc>().currentlongLocation),
//      zoom: 13,
//  );
//
////  static final CameraPosition _kLake = CameraPosition(
////      target: LatLng(locator<NewOrderBloc>().currentLatLocation, locator<NewOrderBloc>().currentlongLocation),
////    zoom: 13,);
//
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () async => false,
//      child: new Scaffold(
//        body: Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          child: GoogleMap(
//            onTap: _mapTapped,
//            compassEnabled: true,
//            mapType: MapType.normal,
//            initialCameraPosition: _kGooglePlex,
////        initialCameraPosition: CameraPosition(
////          target: LatLng(locator<NewOrderBloc>().currentLatLocation, locator<NewOrderBloc>().currentlongLocation),
////          zoom: 13,
////        ),
//            onMapCreated: (GoogleMapController controller) {
//              _controller.complete(controller);
//            },
//            markers: _markers.values.toSet(),
//          ),
//        ),
//
////      floatingActionButton: FloatingActionButton.extended(
////        onPressed: _goToTheLake,
////        label: Text('To the lake!'),
////        icon: Icon(Icons.directions_boat),
////      ),
//      ),
//    );
//  }
//
//
//
//
////  Future<void> _goToTheLake() async {
////    final GoogleMapController controller = await _controller.future;
////    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
////  }
//}
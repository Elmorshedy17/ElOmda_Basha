import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/new_order_bloc.dart';
import 'package:medicine/src/blocs/resend_canceled_details_edit.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/models/super_visor_marketers/show_all_marketer_orders_model.dart';
import 'package:medicine/src/views/screens/after_order.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:medicine/src/views/screens/verificationCode.dart';
import 'package:medicine/theme_setting.dart';
//import 'package:location/location.dart';lat
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';


// bool hadChoseCity = false;


class ResendOrderDetailsOrder extends StatefulWidget {

  final DataInner data;

  ResendOrderDetailsOrder({this.data});


  @override
  _ResendOrderDetailsOrderState createState() => _ResendOrderDetailsOrderState();
}

class _ResendOrderDetailsOrderState extends State<ResendOrderDetailsOrder> {

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController whatsAppNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController adrLocation = TextEditingController();
  // TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = widget.data.name;
    phoneNumber.text = widget.data.phone;
    whatsAppNumber.text = widget.data.whatsapp;
    adrLocation.text = widget.data.address;
    locator<ResendOrderDetailsBloc>().counteryIdSink.add(widget.data.countryId);
    locator<ResendOrderDetailsBloc>().cityIdSink.add(widget.data.cityId);
    // locator<ResendOrderDetailsBloc>().counteryTitle.sink.add(widget.data.countryTitle);
    // locator<ResendOrderDetailsBloc>().cityTitle.sink.add(widget.data.countryTitle);
    // ApiService.AllCountriesAndCities().then((value) {
    //
    // });

  }

  BehaviorSubject isNewOrder = new BehaviorSubject.seeded(false);


  dynamic dropCountryVal;


  dynamic dropCityVal;

  void dropCityChanged(dynamic val) {
    setState(() {
      dropCityVal = val;
    });
  }

  @override
  Widget build(BuildContext context) {

print("locator<ResendOrderDetailsBloc>().city  == >   ${locator<ResendOrderDetailsBloc>().currentCityId}");

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Details")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
           Navigator.pop(context);
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

                            SizedBox(
                              height: 15.0,
                            ),
                            _adressFiled(),

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
        locator<ResendOrderDetailsBloc>().nameSink.add(name.text);
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
        locator<ResendOrderDetailsBloc>().emailSink.add(email.text);
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

                                          // hadChoseCity = false;
                                          locator<ResendOrderDetailsBloc>().counterySink.add(countries[index]);
                                          print("locator<ResendOrderDetailsBloc>().counterySink.add(countries[index])${locator<ResendOrderDetailsBloc>().currentCountery}");
                                          Navigator.pop(context);
                                          locator<ResendOrderDetailsBloc>().chosenCitySink.add("");
                                          cities.clear();



                                          for (int index = 0; index < snapshot.data.data.length; index++) {
                                            if (snapshot.data.data[index].title.contains(locator<ResendOrderDetailsBloc>().currentCountery)) {
                                              countryId.add(snapshot.data.data[index].id);
                                              for (int ind = 0; ind < snapshot.data.data[index].cities.length; ind++) {
                                                cities.add(snapshot.data.data[index].cities[ind].title);
                                                citiesIdTitle.add(snapshot.data.data[index].cities[ind]);
                                              }
                                            }
                                          }
                                          locator<ResendOrderDetailsBloc>().cityIdTitleSink.add(citiesIdTitle);

//                                          print("------------------------------------------------------- ${citiesId[0].id} ------------------------");

                                          //
                                          locator<ResendOrderDetailsBloc>().counteryIdSink.add(snapshot.data.data[index].id);
                                          print("locator<ResendOrderDetailsBloc>().currentCounteryId locator<ResendOrderDetailsBloc>().currentCounteryId locator<ResendOrderDetailsBloc>().currentCounteryId locator<ResendOrderDetailsBloc>().currentCounteryId locator<ResendOrderDetailsBloc>().currentCounteryId ${locator<ResendOrderDetailsBloc>().currentCounteryId}");
//
                                          locator<ResendOrderDetailsBloc>()
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
                              initialData: widget.data.countryTitle,
                              stream: locator<ResendOrderDetailsBloc>().counteryStream$,
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
                        stream: locator<ResendOrderDetailsBloc>().citiesStream$,
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
                                          locator<ResendOrderDetailsBloc>()
                                              .chosenCitySink
                                              .add(locator<ResendOrderDetailsBloc>()
                                              .currentcities[index]);

                                          for(int ind = 0 ; ind < locator<ResendOrderDetailsBloc>().currentCityIdTitle.length; ind ++){
                                            if(locator<ResendOrderDetailsBloc>().currentCityIdTitle[ind].title.contains(locator<ResendOrderDetailsBloc>()
                                                .currentChosenCity)){
                                              locator<ResendOrderDetailsBloc>().cityIdSink.add(locator<ResendOrderDetailsBloc>().currentCityIdTitle[ind].id);
                                            }
                                          }

                                          print(
                                              "locator<ResendOrderDetailsBloc>().counterySink.add(countries[index])${locator<ResendOrderDetailsBloc>().currentCityId} h hahah ------------");
                                          // hadChoseCity = true;

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
                        initialData: widget.data.cityTitle,
                        stream: locator<ResendOrderDetailsBloc>().chosenCityStream$,
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

        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: phoneNumber,
            onChanged: (val) {
              locator<ResendOrderDetailsBloc>().phoneNumberSink.add(phoneNumber.text);
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

        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: whatsAppNumber,
            onChanged: (val) {
              locator<ResendOrderDetailsBloc>()
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
        locator<ResendOrderDetailsBloc>().adressSink.add(adrLocation.text);
      },
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("Adress_str"),
          labelText: AppLocalizations.of(context).translate("Adress_str"),
          border: OutlineInputBorder()),
    );
  }




  _submitButtom() {
    return Container(
      width: double.infinity,
      child: ButtonTheme(
        height: 60.0,
        child: StreamBuilder(
            stream: locator<ResendOrderDetailsBloc>().dateTimeSubject$,
            builder: (context, dateTimeSnapshot) {
              print("dateTimeSnapshot $dateTimeSnapshot ");
              return RaisedButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                child: Text(
                  AppLocalizations.of(context).translate("reorder_str")   ,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MainFont,
                    fontWeight: semiFont,
                  ),
                ),
                onPressed:(){
                  isNewOrder.add(true);
                  //
                  // if(hadChoseCity == false){
                  //
                  //   Fluttertoast.showToast(
                  //       msg: locator<PrefsService>().appLanguage == "en"?"please chose country & city":"برجاء تحديد الدولة و المدينة",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 16.0
                  //   );
                  //
                  // }else{

                    ApiService.ResendCanceledORder(
                        widget.data.id,
                        locator<ResendOrderDetailsBloc>().currentCounteryId,
                        locator<ResendOrderDetailsBloc>().currentCityId,
                        name.text,
                        phoneNumber.text,
                      whatsAppNumber.text,
                      email.text,
                      adrLocation.text,
                      widget.data.total
                    ).then((onValue){
                      locator<IsLoadingManager>().isLoading.add(false);
                      isNewOrder.sink.add(false);
                      if(onValue.key == "1"){
                        Fluttertoast.showToast(
                            msg: onValue.msg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomePage(
                                        locator<UserIdBloc>().currentUserId.toString()
                                            .toString())));
                      }else{
                        Fluttertoast.showToast(
                            msg: onValue.msg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    });

                  // }


                  // ApiService.StoreOrder(
                  //   // dropFirstVal,dropSecVal,
                  //     name.text,phoneNumber.text,whatsAppNumber.text,email.text,adrLocation.text,notesController.text).then((data) {
                  //   if(data.key == "1"){
                  //     isNewOrder.add(false);
                  //
                  //     Navigator.push(
                  //         context,
                  //         new MaterialPageRoute(
                  //             builder: (BuildContext context) => AfterOrder(data)));
                  //
                  //   }else{
                  //     isNewOrder.add(false);
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //           title: Text(data.msg),
                  //         );
                  //       },
                  //     );
                  //   }
                  // });

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
    super.dispose();
  }
}

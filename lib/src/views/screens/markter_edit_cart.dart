import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/widgets/shimmer_placeholders.dart';
import 'package:medicine/theme_setting.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:medicine/src/blocs/resend_canceled_details_edit.dart';
import 'package:medicine/src/models/super_visor_marketers/show_all_marketer_orders_model.dart';


List all = [];

class MarketerEditCart extends StatefulWidget {
  final varuableDiscountRate;
  final orderID;
  final DataInner data;

  MarketerEditCart(this.varuableDiscountRate,this.orderID,{this.data});

  @override
  _MarketerEditCartState createState() => _MarketerEditCartState();
}

class _MarketerEditCartState extends State<MarketerEditCart> {


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

    print(
        "locator<ResendOrderDetailsBloc>().counterySink.add(countries[index])${locator<ResendOrderDetailsBloc>().currentCityId} h hahah ------------");
    List<List> singleAll = new List();

    all.clear();

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( AppLocalizations.of(context).translate("update_button_str")),
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
      body: FutureBuilder(
          future: ApiService.HomePageApi(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60,right: 10,left: 10,top: 10),
                  child: ListView(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.data.sectionData.length,
                          itemBuilder: (BuildContext context, int index){
                            singleAll.add(new List<String>());

                            return SingleItem(snapshot.data.data.sectionData[index],widget.varuableDiscountRate,singleAll[index]);
                          }
                      ),
                      Container(
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


                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )


                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: InkWell(
                      onTap: (){


                        List how = [];
                        singleAll.forEach((element) {
                          how.addAll(element);
                        });
                        if(how.isEmpty){
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(AppLocalizations.of(context).translate("are_you_delete_order"),style: TextStyle(color: Colors.redAccent),),
                                content: Text(AppLocalizations.of(context).translate("if_count_less_than")),
                                actions: [
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: (){

                                            locator<IsLoadingManager>().isLoading.add(true);
                                            ApiService.UpdateMarkterOrder(
                                                widget.orderID,"",
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
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                              color: Colors.redAccent,
                                              child: Text(AppLocalizations.of(context).translate("Delete_str"),style: TextStyle(color: Colors.white),)),
                                        ),
                                        SizedBox(
                                          width: 45,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                            color: Colors.blueAccent,
                            child: Text(AppLocalizations.of(context).translate("Cancel_str"),style: TextStyle(color: Colors.white)))
                                        ),
                                      ],
                                    ),)
                                ],
                              )
                          );                          // Fluttertoast.showToast(
                        }
                        else{
                          locator<IsLoadingManager>().isLoading.add(true);
                          ApiService.UpdateMarkterOrder(widget.orderID,how,
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
                        }



                        // singleAll.addAll(singleAll);

                        print("alloop${how}");
                      },
                      child: Container(
                        child: Center(child: Text(locator<PrefsService>().appLanguage == "en"?"Update":"تحديث",style: TextStyle(color: Colors.white,fontSize: 18),)),
                        height: 55,
                        color: Colors.redAccent,
                      ),
                    ))
              ],
            ):HomePageItemShimmer();
          }
      ),
    );
  }
}


class SingleItem extends StatefulWidget {
  final singleAll;
  final data;
  final varuableDiscountRate;
  SingleItem(this.data,this.varuableDiscountRate,this.singleAll);

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  @override
  int quantity = 0;

  Widget build(BuildContext context) {
    int total = 0 ;
    final quantityController = PublishSubject();
    final changePrice = BehaviorSubject();


    // List singleAll = [];


    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      quantityController.close();
      changePrice.close();
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: StreamBuilder(
          initialData: 0,
          stream: changePrice.stream,
          builder: (context, changePriceSnapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                  initialData: 0,
                  stream: quantityController.stream,
                  builder: (context, updatedCountSnapshot) {
                    total = (widget.data.price * quantity) + changePriceSnapshot.data;
                  var   totalCurrency = (widget.data.price * quantity * double.parse(locator<PrefsService>().rateToSar.toString())) + changePriceSnapshot.data;
                    // all.add(SingleItemService(widget.data.id,updatedCountSnapshot.data,total));




                    Map<String, dynamic> items = {'section_id':"${widget.data.id}",'count':"${quantity}",'total':"${totalCurrency /  double.parse(locator<PrefsService>().rateToSar.toString())}"};



                    List example = [
                      widget.data.id,
                      quantity,
                      total
                    ];

                    // var items = {};
                    //
                    //  items["section_id"] = "${widget.data.id}";
                    //  items["count"] = "${updatedCountSnapshot.data}";
                    //  items["total"] = "$total";




                    if(quantity > 0){
                      widget.singleAll.clear();
                      widget.singleAll.add("${jsonEncode(items)}");
                    }else if(quantity == 0 ){
                      widget.singleAll.clear();

                    }



                    // singleAll.clear();
                    // singleAll.add(items);
                    // all.addAll(singleAll);
                    // all.clear();
                    // // singleAll.add(items);
                    // all.add(items);
                    // if(items[0] == all[0] ){
                    //   print("yayayaya");
                    // }else{
                    //   print("yayayayanonono");
                    //
                    // }




                    print("${jsonEncode(items)}items[0]");

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                print("widget.singleAll${widget.singleAll}");
                              },
                              child: Image.network(
                                widget.data.image,
                                height: 110.0,
                                width: 110.0,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.data.title,
                                      style: TextStyle(
                                        // color: Colors.white,
                                          fontSize: PrimaryFont,
                                          fontWeight: semiFont),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      widget.data.desc,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: SecondaryFont,
                                          fontWeight: semiFont),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],



                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(widget.data.price * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)} ${locator<PrefsService>().currencyCode}",
                                  // "${AppLocalizations.of(context).translate("real_suadi_shortcut")}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: PrimaryFont,
                                  fontWeight: semiFont),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: (){
                                    changePrice.add(0);

                                    setState(() {
                                      quantity ++;
                                    });
                                    // total = widget.data.price * quantity;
                                  },
                                  child: Text("+",style: TextStyle(fontSize: 28,color: Colors.blueAccent),),
                                ),
                                SizedBox(width: 15,),
                                Text("$quantity",style: TextStyle(fontSize: 21),),
                                SizedBox(width: 15,),

                                InkWell(
                                  onTap: (){
                                    if(!quantity.isNegative){
                                      changePrice.add(0);
                                      setState(() {
                                        quantity --;
                                      });


                                    }else{
                                      setState(() {
                                        quantity = 0;
                                      });
                                      // setState(() {
                                      //
                                      // });
                                    }

                                  },
                                  child: Text("-",style: TextStyle(fontSize: 35,color: Colors.redAccent),),
                                ),
                              ],
                            ),

                            Text(
                              "${(totalCurrency ).toStringAsFixed(2)} ${locator<PrefsService>().currencyCode}",
                                  // " ${AppLocalizations.of(context).translate("real_suadi_shortcut")}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: MainFont,
                                  fontWeight: semiFont),
                            ),


                          ],
                        ),

                        ExpansionTile(
                          title: Text(AppLocalizations.of(context).translate("Price_Modify_str"),
                            style: TextStyle(
                              fontSize: PrimaryFont,
                              fontWeight: semiFont,
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        quantity > 0
                                            ? Container(
                                            height: 100,
                                            child: new NumberPicker.integer(
                                                initialValue: 0,
                                                minValue: -((((quantity * widget.data.price) * widget.varuableDiscountRate) * double.parse(locator<PrefsService>().rateToSar.toString()) ) / 100).round(),
                                                maxValue: ((((quantity * widget.data.price) * widget.varuableDiscountRate) * double.parse(locator<PrefsService>().rateToSar.toString()) ) / 100).round(),
                                                onChanged: (newValue) {
                                                  changePrice.add(newValue);
                                                  // print("tottalDiscount $tottalDiscount");
                                                }))
                                            : Container(),
                                        Container(
                                          width: 90,
                                          height: 35,
                                          margin: const EdgeInsets.all(15.0),
                                          padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                                          child: Center(child: new Text(" ${changePriceSnapshot.data}")),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
//                                          AppLocalizations.of(context).translate("*_You_can_modfy_the_price_10%_as_max_str")  ,
                                      locator<PrefsService>().appLanguage == "en"
                                          ? "You can modfy the price ${widget.varuableDiscountRate} % as max"
                                          : "يمكنك تعديل السعر بحد اقصي ${widget.varuableDiscountRate} %",
                                      style: TextStyle(
                                          fontWeight: regFont,
                                          fontSize: PrimaryFont,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    );
                  }
              ),
            );
          }
      ),
    );
  }



}


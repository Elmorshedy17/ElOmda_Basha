import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/all_orders_bloc.dart';
import 'package:medicine/src/models/super_visor_marketers/show_all_marketer_orders_model.dart';
import 'package:medicine/src/views/screens/markter_edit_cart.dart';
import 'package:medicine/src/views/screens/receipt.dart';
import 'package:medicine/src/views/screens/resend_canceled_details_edit.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';


DateTime fromDate ;

final now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final yesterday = DateTime(now.year, now.month, now.day - 1);
final prefs = locator<PrefsService>();

class HistoryFilter extends StatefulWidget {
  @override
  _HistoryFilterState createState() => _HistoryFilterState();
}

class _HistoryFilterState extends State<HistoryFilter> {
  bool checked = true;
  var variableRate;



  BehaviorSubject isStepsClicked = new BehaviorSubject.seeded(false);

  ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  List<DataInner> allOrdersList = [];

  @override
  void initState() {
    // locator<AllOrdersFilterBloc>().allOrdersFilterSink.add(filterHistory);
    locator<AllOrdersFilterBloc>().inCurrentPageController.add(1);
    loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
        locator<AllOrdersFilterBloc>().inIsLoadingOrders.add(true);
      }
    });
    super.initState();
  }

  void loadMore() {

    ApiService.ShowAllMarketerOrders()
        .then((onValue) {
      variableRate = onValue.variableRate;

      if (allOrdersList.length < onValue.data.pagination.total) {
        currentPage++;
        locator<AllOrdersFilterBloc>().inCurrentPageController.add(currentPage);
        locator<AllOrdersFilterBloc>().downloadUrlSubject.add(onValue.download);
        onValue.data.dataInner.forEach((element) {
          allOrdersList.add(element);
        });
      }
      locator<AllOrdersFilterBloc>().inIsLoadingOrders.add(false);
      locator<AllOrdersFilterBloc>().inAllOrders.add(allOrdersList);
    });

    print("yayayay${allOrdersList.length}");
    print("currentPage${currentPage}");

  }


  @override
  Widget build(BuildContext context) {

    List <OrderStatus> ordersStatus = [
      // OrderStatus(
      //     "has-provider",
      //     AppLocalizations.of(context).translate("hasـprovider")
      // ),
      // OrderStatus(
      //     "refused",
      //     AppLocalizations.of(context).translate("refused_Order")
      // ),
      // OrderStatus(
      //     "user_cancel",
      //     AppLocalizations.of(context).translate("userـcancel")
      // ),
      // OrderStatus(
      //     "current_order",
      //     AppLocalizations.of(context).translate("Current_Order")
      // ),
      // OrderStatus(
      //     "finish_order",
      //     AppLocalizations.of(context).translate("Finish_Order")
      // ),
      OrderStatus(
          "new",
          AppLocalizations.of(context).translate("new_Order")
      ),
      OrderStatus(
          "cancel",
          AppLocalizations.of(context).translate("cancel_Order")
      ),
      OrderStatus(
          "in_way",
          AppLocalizations.of(context).translate("inـwayـOrder")
      ),
      OrderStatus(
          "finish",
          AppLocalizations.of(context).translate("delivered")
      ),
    ];

    void filterBottomSheet(context){
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc){
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,top: 15,left: 15,right: 15),

              child: new ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          locator<AllOrdersFilterBloc>().clearFilter();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(prefs.appLanguage == "en" ? "Rest":"اعاده تهيئه",style: TextStyle(color: Colors.redAccent),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _orderStatus(context,ordersStatus),
                  SizedBox(
                    height: 15,
                  ),
                  _counteryCity(context),
                  SizedBox(
                    height:15,
                  ),
                  _orderId(context),
                  SizedBox(height: 15,),
                  _phoneNumber(context),
                  SizedBox(height: 15,),
                  _fromToDate(context),
                  SizedBox(height: 15,),
                  ButtonTheme(
                    height: 40.0,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                      child: FittedBox(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("Filter_str"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: PrimaryFont,
                            fontWeight: regFont,
                          ),
                        ),
                      ),

                      onPressed: () {
                        print("orderId =>${locator<AllOrdersFilterBloc>().orderIdFilterBloc.value}");
                        print("currentCounteryId => ${locator<AllOrdersFilterBloc>().currentCounteryId}");
                        print("currentCityId => ${locator<AllOrdersFilterBloc>().currentCityId}");
                        print("phoneFilterBloc => ${locator<AllOrdersFilterBloc>().phoneFilterBloc.value}");
                        print("startDateFilterBloc => ${locator<AllOrdersFilterBloc>().startDateFilterBloc.value}");
                        print("endDateFilterBloc => ${locator<AllOrdersFilterBloc>().endDateFilterBloc.value}");
                        print("locator<AllOrdersFilterBloc>().currentAllOrdersFilter => ${locator<AllOrdersFilterBloc>().currentAllOrdersFilter}");
                        locator<AllOrdersFilterBloc>().inCurrentPageController.add(1);

                        setState(() {
                        });
                        loadMore();
                        Navigator.pop(context);
                      },
                    ),
                  )




                ],
              ),
            );
          }
      );
    }
    allOrdersList.clear();

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("history_filter")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  void _launchURL() async =>
                      await canLaunch(locator<AllOrdersFilterBloc>().downloadUrlSubject.value) ? await launch(locator<AllOrdersFilterBloc>().downloadUrlSubject.value) : throw 'Could not launch ${locator<AllOrdersFilterBloc>().downloadUrlSubject.value}';
                  if(locator<AllOrdersFilterBloc>().downloadUrlSubject.value != ""){
                    _launchURL();
                  }
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.download_outlined,color: Colors.white,)),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: (){
                  locator<AllOrdersFilterBloc>().orderIdFilterBloc.sink.add("");
                  locator<AllOrdersFilterBloc>().phoneFilterBloc.sink.add("");
                  filterBottomSheet(context);
                },
                child: Icon(Icons.filter_alt_outlined,color: Colors.white,),
              ),
            ],
          ),)
        ],
      ),
      body: StreamBuilder(
          stream: isStepsClicked.stream,
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                StreamBuilder(
                    stream: locator<AllOrdersFilterBloc>().allOrders$,
                    builder: (context, dataSnapshot) {
                      return dataSnapshot.hasData?
                      Container(
                        padding: EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
                        child: ListView(
                          // primary: true,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                // Container(
                                //   margin: EdgeInsets.only(bottom: 15.0),
                                //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(5.0),
                                //     border: Border.all(
                                //         color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                //   ),
                                //   //color: Colors.yellow,
                                //   child: DropdownButton<dynamic>(
                                //     style: TextStyle(
                                //         fontSize: PrimaryFont,
                                //         fontWeight: bolFont,
                                //         color: Colors.black45),
                                //     //hint: Text(dropFirstVal),
                                //     value: dropHistory,
                                //     items: [AppLocalizations.of(context).translate("Current_Order"),AppLocalizations.of(context).translate("Finish_Order")]
                                //         .map<DropdownMenuItem<dynamic>>((dynamic value) {
                                //       return DropdownMenuItem(
                                //         child: Text(value),
                                //         value: value,
                                //       );
                                //     }).toList(),
                                //     onChanged: dropHistoryChanged,
                                //   ),
                                //   height: 50.0,
                                // ),
                              ],
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height - 160,
                              child:  ListView.builder(
                                  controller: _scrollController,
                                  itemCount: dataSnapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){

                                    return    InkWell(
                                      onTap: (){
                                        isStepsClicked.add(true);

                                        ApiService.ShowOrder(dataSnapshot.data[index].id).then((onValue){
                                          if(onValue.key == "1"){
                                            isStepsClicked.add(false);
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext context) => Receipt(onValue.data)));
                                          }
                                        });


                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 15.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          elevation: 4.0,
                                          child: Container(
                                            padding: EdgeInsets.all(15.0),
                                            child: Wrap(
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(context).translate("Order_Number_str"),
                                                            style: TextStyle(
                                                                fontWeight: bolFont, fontSize: MainFont),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            dataSnapshot.data[index].id.toString(),
                                                            //"3011",
                                                            style: TextStyle(
                                                                fontSize: PrimaryFont,
                                                                fontWeight: semiFont,
                                                                color: littleGrey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    dataSnapshot.data[index].status == "new" ?   InkWell(
                                                      onTap: (){
                                                        Navigator.pushReplacement(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (BuildContext context) =>
                                                                    MarketerEditCart(variableRate,dataSnapshot.data[index].id,data: dataSnapshot.data[index],)));
                                                      },
                                                      child: Icon(Icons.edit),
                                                    ):Container(),

                                                    dataSnapshot.data[index].cancel == "true" ?   InkWell(
                                                      onTap: (){

                                                        showDialog(
                                                            context: context,
                                                            builder: (_) => AlertDialog(
                                                              title: Text(AppLocalizations.of(context).translate("are_reorder"),style: TextStyle(color: Colors.redAccent),),
                                                              // content: Text(AppLocalizations.of(context).translate("if_count_less_than")),
                                                              actions: [
                                                                Padding(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                                                                  child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: (){

                                                                          Navigator.pushReplacement(
                                                                              context,
                                                                              new MaterialPageRoute(
                                                                                  builder: (BuildContext context) =>
                                                                                      ResendOrderDetailsOrder(data: dataSnapshot.data[index],)));

                                                                          // ApiService.ResendCanceledORder(dataSnapshot.data[index].id).then((onValue){
                                                                          //   locator<IsLoadingManager>().isLoading.add(false);
                                                                          //
                                                                          //   if(onValue.key == "1"){
                                                                          //     Fluttertoast.showToast(
                                                                          //         msg: onValue.msg,
                                                                          //         toastLength: Toast.LENGTH_SHORT,
                                                                          //         gravity: ToastGravity.CENTER,
                                                                          //         timeInSecForIosWeb: 1,
                                                                          //         backgroundColor: Colors.red,
                                                                          //         textColor: Colors.white,
                                                                          //         fontSize: 16.0
                                                                          //     );
                                                                          //     Navigator.pushReplacement(
                                                                          //         context,
                                                                          //         new MaterialPageRoute(
                                                                          //             builder: (BuildContext context) =>
                                                                          //                 HomePage(
                                                                          //                     locator<UserIdBloc>().currentUserId.toString()
                                                                          //                         .toString())));
                                                                          //   }else{
                                                                          //     Fluttertoast.showToast(
                                                                          //         msg: onValue.msg,
                                                                          //         toastLength: Toast.LENGTH_SHORT,
                                                                          //         gravity: ToastGravity.CENTER,
                                                                          //         timeInSecForIosWeb: 1,
                                                                          //         backgroundColor: Colors.red,
                                                                          //         textColor: Colors.white,
                                                                          //         fontSize: 16.0
                                                                          //     );
                                                                          //   }
                                                                          // });

                                                                        },
                                                                        child: Container(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 8),
                                                                            color: Colors.redAccent,
                                                                            child: Text(AppLocalizations.of(context).translate("yes_str"),style: TextStyle(color: Colors.white),)),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 45,
                                                                      ),
                                                                      InkWell(
                                                                          onTap: (){
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 8),
                                                                              color: Colors.blueAccent,
                                                                              child: Text(AppLocalizations.of(context).translate("no_str"),style: TextStyle(color: Colors.white)))
                                                                      ),
                                                                    ],
                                                                  ),)
                                                              ],
                                                            )
                                                        );



                                                      },
                                                      child: Icon(Icons.refresh_outlined),
                                                    ):Container()
                                                  ],
                                                ),
                                                Container(
                                                  height: 8.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(context).translate("Tottal_Price_str:"),
                                                      style: TextStyle(
                                                          fontWeight: bolFont,
                                                          fontSize: PrimaryFont),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      "${(dataSnapshot.data[index].total * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}",

                                                      //     "300",
                                                      style: TextStyle(
                                                          fontSize: SecondaryFont,
                                                          fontWeight: semiFont,
                                                          color: Colors.red.withOpacity(.7)),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                       locator<PrefsService>().currencyCode,
                                                      // AppLocalizations.of(context).translate("real_suadi_shortcut"),
                                                      style: TextStyle(
                                                          fontSize: SecondaryFont,
                                                          fontWeight: regFont,
                                                          color: littleGrey),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 8.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(context).translate("Adress_str:") ,
                                                      style: TextStyle(
                                                          fontWeight: bolFont,
                                                          fontSize: PrimaryFont),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        dataSnapshot.data[index].address,

                                                        //  "13 al Reyadh street,Al Reyadh",
                                                        style: TextStyle(
                                                            fontSize: PrimaryFont,
                                                            fontWeight: semiFont,
                                                            color: lightText),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 8.0,
                                                ),
                                                // delivery text will be false and true if the order is canceled down
//                                    snapshot.data.data.dataInner.dataInner[index].
                                                dataSnapshot.data[index].cancel == "false" ? Wrap(
                                                  children: <Widget>[
                                                    dataSnapshot.data[index].delegateName != "" ?   Text(
                                                      AppLocalizations.of(context).translate("delivery"),
                                                      style: TextStyle(
                                                          fontSize: SecondaryFont,
                                                          fontWeight: semiFont,
                                                          color: Theme.of(context).primaryColor),
                                                    ):Container(),
                                                    //                                 // delivery text will be false and true if the order is canceled up
                                                    dataSnapshot.data[index].hasProvider == "true" ?    Wrap(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 5.0,
                                                        ),
                                                        // delivery text will be false and true if the order is canceled down

                                                        Row(
                                                          children: <Widget>[
                                                            dataSnapshot.data[index].delegateAvatar != "" ?    ClipRRect(
                                                              borderRadius: new BorderRadius.circular(3.0),
                                                              child: Image.network(
                                                                dataSnapshot.data[index].delegateAvatar,
                                                                height: 50.0,
                                                                width: 50.0,
                                                              ),
                                                            ):Container(),
                                                            SizedBox(
                                                              width:dataSnapshot.data[index].delegateAvatar != "" ? 8.0:0.0,
                                                            ),
                                                            dataSnapshot.data[index].delegateName != "" ?  Text(
                                                              dataSnapshot.data[index].delegateName,
                                                              style: TextStyle(
                                                                  fontSize: PrimaryFont,
                                                                  fontWeight: semiFont,
                                                                  color: lightText),
                                                            ):Container(),
                                                          ],
                                                        ),
                                                        // delivery text will be false and true if the order is canceled up
                                                        Container(
                                                          height: 12.0,
                                                        ),
                                                      ],
                                                    ):Container(
                                                      padding: EdgeInsets.only(top: 15.0),
                                                      child: Text(
                                                        AppLocalizations.of(context).translate("Waiting a delgate to approve"),
                                                        style: TextStyle(
                                                            color: accentColor
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      //                           color: Colors.red,
                                                      height: 50.0,
                                                      child:
                                                      Stack(
                                                        children: <Widget>[
                                                          Container(
                                                            child: Center(
                                                              child: MySeparator(
                                                                height: 2.5,
                                                                color: Colors.blue.withOpacity(.1),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Container(
                                                                  //      color: Colors.red,
                                                                    height: MediaQuery.of(context)
                                                                        .size
                                                                        .height,
                                                                    child: Center(
                                                                        child: Container(
                                                                          // color: Colors.white.withOpacity(.4),
                                                                          child: dataSnapshot.data[index].hasProvider == "true"?Image.asset(
                                                                            "assets/images/checked.png",height: 30.0,width: 30.0,):Image.asset(
                                                                            "assets/images/unchecked.png",height: 30.0,width: 30.0,),
                                                                        ))),Container(
                                                                  //      color: Colors.red,
                                                                    height: MediaQuery.of(context)
                                                                        .size
                                                                        .height,
                                                                    child: Center(
                                                                        child: Container(
                                                                          child: dataSnapshot.data[index].inWay == "true" ? Image.asset(
                                                                            "assets/images/checked.png",height: 30.0,width: 30.0,):Image.asset(
                                                                            "assets/images/unchecked.png",height: 30.0,width: 30.0,),
                                                                        ))),Container(
                                                                  //      color: Colors.red,
                                                                    height: MediaQuery.of(context)
                                                                        .size
                                                                        .height,
                                                                    child: Center(
                                                                        child: Container(
                                                                          child:dataSnapshot.data[index].finish == "true" ? Image.asset(
                                                                            "assets/images/checked.png",height: 30.0,width: 30.0,):Image.asset(
                                                                            "assets/images/unchecked.png",height: 30.0,width: 30.0,),
                                                                        ))),
                                                              ],
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          child: dataSnapshot.data[index].hasProvider == "true" ?Text(AppLocalizations.of(context).translate("Recived"),
                                                            style: TextStyle(
                                                                fontWeight: regFont,
                                                                fontSize: SecondaryFont,
                                                                color: Theme.of(context).primaryColor
                                                            ),):Container(),
                                                        ),
                                                        dataSnapshot.data[index].inWay == "true" ?Container(
                                                          child: Text(AppLocalizations.of(context).translate("On the way"),
                                                            style: TextStyle(
                                                                fontWeight: regFont,
                                                                fontSize: SecondaryFont,
                                                                color: Theme.of(context).primaryColor
                                                            ),),
                                                        ):Container(),
                                                        dataSnapshot.data[index].finish == "true" ?    Container(
                                                          child: Text(AppLocalizations.of(context).translate("Done_str"),
                                                            style: TextStyle(
                                                                fontWeight: regFont,
                                                                fontSize: SecondaryFont,
                                                                color: Theme.of(context).primaryColor
                                                            ),),
                                                        ):Container(),
                                                      ],
                                                    ),
                                                  ],
                                                ):Container(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context).translate("Order has been canceled")
                                                        ,
                                                        style: TextStyle(
                                                            color: accentColor
                                                        ),
                                                      ),
                                                      dataSnapshot.data[index].message != "" ? Text(
                                                        "${AppLocalizations.of(context).translate('cancel_message')} : ${dataSnapshot.data[index].message}",
                                                        style: TextStyle(
                                                            color: accentColor
                                                        ),
                                                      ):Container(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ):Center(
                        child: Container(
                          padding: EdgeInsets.all(30.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                ),
                isStepsClicked.value == true ?  Container(
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

}



Widget _counteryCity(context) {
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
                                      MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 4)),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        locator<AllOrdersFilterBloc>().counterySink.add(countries[index]);
                                        print("locator<AllOrdersFilterBloc>().counterySink.add(countries[index])${locator<AllOrdersFilterBloc>().currentCountery}");
                                        Navigator.pop(context);
                                        locator<AllOrdersFilterBloc>().chosenCitySink.add("");
                                        cities.clear();


                                        for (int index = 0; index < snapshot.data.data.length; index++) {
                                          if (snapshot.data.data[index].title.contains(locator<AllOrdersFilterBloc>().currentCountery)) {
                                            countryId.add(snapshot.data.data[index].id);

                                            for (int ind = 0; ind < snapshot.data.data[index].cities.length; ind++) {
                                              cities.add(snapshot.data.data[index].cities[ind].title);
                                              citiesIdTitle.add(snapshot.data.data[index].cities[ind]);
                                            }
                                          }
                                        }
                                        locator<AllOrdersFilterBloc>().cityIdTitleSink.add(citiesIdTitle);

//                                          print("------------------------------------------------------- ${citiesId[0].id} ------------------------");

                                        //
                                        locator<AllOrdersFilterBloc>().counteryIdSink.add(snapshot.data.data[index].id);
                                        print("locator<AllOrdersFilterBloc>().currentCounteryId locator<AllOrdersFilterBloc>().currentCounteryId locator<AllOrdersFilterBloc>().currentCounteryId locator<AllOrdersFilterBloc>().currentCounteryId locator<AllOrdersFilterBloc>().currentCounteryId ${locator<AllOrdersFilterBloc>().currentCounteryId}");
//
                                        locator<AllOrdersFilterBloc>()
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
                            stream: locator<AllOrdersFilterBloc>().counteryStream$,
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
                      stream: locator<AllOrdersFilterBloc>().citiesStream$,
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
                                        locator<AllOrdersFilterBloc>().chosenCitySink.add(locator<AllOrdersFilterBloc>().currentcities[index]);

                                        for(int ind = 0 ; ind < locator<AllOrdersFilterBloc>().currentCityIdTitle.length; ind ++){
                                          if(locator<AllOrdersFilterBloc>().currentCityIdTitle[ind].title.contains(locator<AllOrdersFilterBloc>()
                                              .currentChosenCity)){
                                            locator<AllOrdersFilterBloc>().cityIdSink.add(locator<AllOrdersFilterBloc>().currentCityIdTitle[ind].id);
                                          }
                                        }

                                        print(
                                            "locator<AllOrdersFilterBloc>().counterySink.add(countries[index])${locator<AllOrdersFilterBloc>().currentCityId} h hahah ------------");
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
                      stream: locator<AllOrdersFilterBloc>().chosenCityStream$,
                      builder: (context, snapshot) {
                        return Text(snapshot.data);
                      })),
            )),
      )
    ],
  );
}

Widget _orderId(context){
  return TextField(
    onChanged: locator<AllOrdersFilterBloc>().orderIdFilterBlocOnChange,
    decoration: InputDecoration(
        hintText: AppLocalizations.of(context).translate('Order_Number_str'),
        labelText: AppLocalizations.of(context).translate('Order_Number_str'),
        border: OutlineInputBorder()),
  );
}




Widget _phoneNumber(context){
  return TextField(
    onChanged: locator<AllOrdersFilterBloc>().phoneFilterBlocOnChange,
    decoration: InputDecoration(
        hintText: AppLocalizations.of(context).translate('Phone_Number_str'),
        labelText: AppLocalizations.of(context).translate('Phone_Number_str'),
        border: OutlineInputBorder()),
  );
}

Widget _fromToDate(context){
  return Row(
    children: [
      Expanded(
        child: Center(
          child: StreamBuilder(
              initialData: "",

              stream: locator<AllOrdersFilterBloc>().startDateFilterBloc.stream,
              builder: (context, startDateSnapshot) {
                return TextButton(
                    onPressed: () {

                      Future<void> _selectDate(BuildContext context) async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2019, 8),
                          initialDate: DateTime(now.year, now.month, now.day ),
                          lastDate: new DateTime(now.year + 1, now.month, now.day ),);
                        if(picked != null){
                          fromDate = picked;
                          print("picked${picked}");
                          locator<AllOrdersFilterBloc>().startDateFilterBloc.sink.add(formatter.format(picked));
                          // tripsManager.tripDateId.sink.add(formatter.format(picked));
                          // Navigator.pop(context);

                        }
                      }
                      _selectDate(context);
                    },
                    child: Column(
                      children: [
                        Text(
                          prefs.appLanguage == "en" ? "From Date":"من تاريخ",
                          style: TextStyle(color: Colors.blue),
                        ),

                        Text(
                          startDateSnapshot.data,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ));
              }
          ),
        ),
      ),


      Expanded(
        child: Center(
          child: StreamBuilder(
              initialData: "",

              stream: locator<AllOrdersFilterBloc>().endDateFilterBloc.stream,
              builder: (context, startDateSnapshot) {
                return TextButton(
                    onPressed: () {

                      Future<void> _selectDate(BuildContext context) async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2019, 8),
                          initialDate: DateTime(now.year, now.month, now.day ),
                          lastDate: new DateTime(now.year + 1, now.month, now.day ),);
                        if(locator<AllOrdersFilterBloc>().startDateFilterBloc.value != ""){
                          if(picked.isAfter(fromDate)){
                            if(picked != null){
                              print("picked${picked}");
                              locator<AllOrdersFilterBloc>().endDateFilterBloc.sink.add(formatter.format(picked));
                              // tripsManager.tripDateId.sink.add(formatter.format(picked));
                              // Navigator.pop(context);

                            }
                          }else{
                            Fluttertoast.showToast(
                                msg: prefs.appLanguage == "en" ? "select from date first":"برجاء اختيار من التاريخ اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        }else{
                          Fluttertoast.showToast(
                              msg: prefs.appLanguage == "en" ? "select from date first":"برجاء اختيار من التاريخ اولا",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }


                      }
                      _selectDate(context);
                    },
                    child: Column(
                      children: [
                        Text(
                          prefs.appLanguage == "en" ? "To Date":"الي تاريخ",
                          style: TextStyle(color: Colors.blue),
                        ),

                        Text(
                          startDateSnapshot.data,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ));
              }
          ),
        ),
      ),

    ],
  );

}

class OrderStatus {
  String orderId;
  String orderName;
  OrderStatus(this.orderId,this.orderName);
}

Widget _orderStatus(context,List<OrderStatus> ordersStatus) {
  return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              content: Container(
                height: 250,
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scrollbar(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ordersStatus.length,
                        // gridDelegate:
                        // new SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 1,
                        //     childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 4)),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              locator<AllOrdersFilterBloc>().allOrdersFilterBloc.sink.add(ordersStatus[index].orderId);
                              locator<AllOrdersFilterBloc>().allOrdersFilterBlocName.sink.add(ordersStatus[index].orderName);
                              Navigator.pop(context);
                            },
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    ordersStatus[index].orderName,
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          );
                        }),
                  ),
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
                stream: locator<AllOrdersFilterBloc>().allOrdersFilterBlocName.stream,
                builder: (context, snapshot) {
                  return Text(
                      snapshot.data != "" ? snapshot.data : AppLocalizations.of(context).translate("order_status_str"));
                })),
      ));
}

// class DownloadPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebviewScaffold(
//         primary: true,
//         ignoreSSLErrors: true,
//         url: locator<AllOrdersFilterBloc>().downloadUrlSubject.value,
//         withJavascript: true,
//         allowFileURLs: true,
//       ),
//     );
//   }
// }

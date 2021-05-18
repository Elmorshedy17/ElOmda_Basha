import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/all_orders_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/models/super_visor_marketers/show_all_marketer_orders_model.dart';
import 'package:medicine/src/views/screens/follow_order.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/markter_edit_cart.dart';
import 'package:medicine/src/views/screens/receipt.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool checked = true;
  var variableRate;
  dynamic dropHistory = locator<PrefsService>().appLanguage == "en"?"Current Orders":"الطلبات المتبقية";
  dynamic filterHistory = "current_order";

  BehaviorSubject isStepsClicked = new BehaviorSubject.seeded(false);


  void dropHistoryChanged(dynamic val) {
    locator<AllOrdersFilterBloc>().inCurrentPageController.add(1);

    setState(() {
      dropHistory = val;
      // if(val== AppLocalizations.of(context).translate("This_year_str")){
      //   filterHistory ="year";
      // }else if(val == AppLocalizations.of(context).translate("This_month_str")){
      //   filterHistory ="month";
      // }else
        if(val == AppLocalizations.of(context).translate("Finish_Order")){
        filterHistory ="finish_order";
      }else if(val == AppLocalizations.of(context).translate("Current_Order")){
        filterHistory ="current_order";
      }else if(val == null ){
        filterHistory ="current_order";
      }
      locator<AllOrdersFilterBloc>().allOrdersFilterSink.add(filterHistory);
    });
    loadMore();
  }



  ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  List<DataInner> allOrdersList = [];

  @override
  void initState() {
    locator<AllOrdersFilterBloc>().allOrdersFilterSink.add(filterHistory);
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



    allOrdersList.clear();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("history_str")),
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
          InkWell(
            onTap: (){
              void _launchURL() async =>
                  await canLaunch(locator<AllOrdersFilterBloc>().downloadUrlSubject.value) ? await launch(locator<AllOrdersFilterBloc>().downloadUrlSubject.value) : throw 'Could not launch ${locator<AllOrdersFilterBloc>().downloadUrlSubject.value}';
              if(locator<AllOrdersFilterBloc>().downloadUrlSubject.value != ""){
                _launchURL();
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Icon(Icons.download_outlined,color: Colors.white,)),
          ),
        ],
      ),
      body:
      StreamBuilder(
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
                              Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                ),
                                //color: Colors.yellow,
                                child: DropdownButton<dynamic>(
                                  style: TextStyle(
                                      fontSize: PrimaryFont,
                                      fontWeight: bolFont,
                                      color: Colors.black45),
                                  //hint: Text(dropFirstVal),
                                  value: dropHistory,
                                  items: [AppLocalizations.of(context).translate("Current_Order"),AppLocalizations.of(context).translate("Finish_Order")]
                                      .map<DropdownMenuItem<dynamic>>((dynamic value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: dropHistoryChanged,
                                ),
                                height: 50.0,
                              ),
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
                                                                  MarketerEditCart(variableRate,dataSnapshot.data[index].id)));
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
                                                                        ApiService.ResendCanceledORder(dataSnapshot.data[index].id).then((onValue){
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
                                                    dataSnapshot.data[index].total.toString(),

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
                                                    AppLocalizations.of(context).translate("real_suadi_shortcut"),
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

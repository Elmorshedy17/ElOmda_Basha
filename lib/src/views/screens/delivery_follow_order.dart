import 'package:flutter/material.dart';
// import 'package:flutter_launch/flutter_launch.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/delivery_coasts_bloc.dart';
import 'package:medicine/src/blocs/delivery_order_update_details_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/status_message_bloc.dart';
import 'package:medicine/src/blocs/stepper_bloc.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/models/delivery_models/show_delegate_order.dart';
import 'package:medicine/src/models/super_visor_marketers/show_order_model.dart';
import 'package:medicine/src/new_code/delivery_edit_cart/delivery_edit_cart.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class DelivereyFollowOrder extends StatefulWidget {
  ShowDelegateOrderModel data;
  ShowDelegateOrderModel ShowDelegateOrder;
  DelivereyFollowOrder(this.data,this.ShowDelegateOrder);

  @override
  _DelivereyFollowOrderState createState() => new _DelivereyFollowOrderState(data,ShowDelegateOrder);
}

class _DelivereyFollowOrderState extends State<DelivereyFollowOrder> {

  ShowDelegateOrderModel data;
  ShowDelegateOrderModel ShowDelegateOrder;
  _DelivereyFollowOrderState(this.data,this.ShowDelegateOrder);


  TextEditingController statusMessage = TextEditingController();
  // var delivery;
  // TextEditingController delivery = TextEditingController();
  var GlobalUserId = locator<PrefsService>().saveUserId == null? locator<UserIdBloc>().currentUserId.toString() : locator<PrefsService>().saveUserId.toString();
  final BehaviorSubject deliverySubject = BehaviorSubject();
  final BehaviorSubject showDelivery = BehaviorSubject();


  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+$phone/?text=$message";
      } else {
        return "https://wa.me/+$phone?text=$message";

      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    _launchURL(urlLink) async {
      var url = urlLink;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }


    List itemsDetails = [];
    itemsDetails.clear();
    for (int index = 0; index < widget.data.data.orderItems.length; index++) {
      itemsDetails.add("${widget.data.data.orderItems[index].sectionTitle} * ${widget.data.data.orderItems[index].quantity} = ${widget.data.data.orderItems[index].totalForCountry} ${widget.data.data.currencyCode}");
    }


    // var dliveryCoasts = [];

    showDelivery.add(false);
    deliverySubject.add("");

    var deliveryFees;
    var idoo = widget.ShowDelegateOrder.data.orderStatus;

    // if(idoo.length == 0){
    //   print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++haha");
    //   locator<StepperBloc>().stepperSink.add(0);
    // }else{
    //   print("---------------------------------------------------------------hoho");
    //   var ido =  widget.ShowDelegateOrder.data.status;
    //   // var ido =  widget.ShowDelegateOrder.data.orderStatus[widget.ShowDelegateOrder.data.orderStatus.length-1].status;
    //   if(ido == "has_provider"){
    //     locator<StepperBloc>().stepperSink.add(0);
    //   }else if(ido == "cancel"){
    //     locator<StepperBloc>().stepperSink.add(1);
    //   }
    //   else if(ido == "in_way"){
    //     locator<StepperBloc>().stepperSink.add(1);
    //   }else if(ido == "done"){
    //     locator<StepperBloc>().stepperSink.add(2);
    //   }else if(ido != "has_provider" && ido != "in_way" && ido != "done") {
    //     locator<StepperBloc>().stepperSink.add(0);
    //   }else{
    //     locator<StepperBloc>().stepperSink.add(0);
    //   }
    // }

  // }


    var ido =  widget.ShowDelegateOrder.data.status;
    // var ido =  widget.ShowDelegateOrder.data.orderStatus[widget.ShowDelegateOrder.data.orderStatus.length-1].status;
    if(ido == "has_provider"){
      locator<StepperBloc>().stepperSink.add(0);
    }
    else if(ido == "in_way"){
      locator<StepperBloc>().stepperSink.add(1);
    }
    else if(ido == "finish"){
      locator<StepperBloc>().stepperSink.add(2);
    }
    else if(ido == "cancel"){
      locator<StepperBloc>().stepperSink.add(1);
    }
else if(ido != "has_provider" && ido != "in_way" && ido != "finish") {
      locator<StepperBloc>().stepperSink.add(0);
    }else{
      locator<StepperBloc>().stepperSink.add(0);
    }




    return FutureBuilder(
        future: ApiService.ShowDelegateOrder(widget.ShowDelegateOrder.data.id),
        builder: (context, snapshotFuture) {
          locator<DliveryUpdateDetailsBloc>().DliveryUpdateDetailsSink.add(snapshotFuture.data);
          var dliveryCoasts = [];
          if (snapshotFuture.hasData) {
            for (int index = 0;
            index < snapshotFuture.data.deliverys.length;
            index++) {
              dliveryCoasts
                  .add(snapshotFuture.data.deliverys[index]);
            }
          } else {
            var dliveryCoasts = ["0"];
          }
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate("Follow Order")),
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
              Row(
                children: [
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        height: 40,
                        width: 40,
                        child: Icon(Icons.share)),
                    onTap: () {
                      Share.share(
                          "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.data.id}""\n"
                              "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.data.name}""\n"
                              "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.data.phone}""\n"
                              "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.data.address}""\n"
                              "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                              "${AppLocalizations.of(context).translate("total")} ${widget.data.data.totalForCountry} ${widget.data.data.currencyCode}");

                    },
                  ),
                ],
              ),
              snapshotFuture.hasData ? snapshotFuture.data.data.status == "finish" ? Container() :  FlatButton(
                child: Image.asset(
                  "assets/images/edit.png",
                  height: 40.0,
                  width: 40.0,
                  color: Colors.white,
                ),
                onPressed: () {

                  ApiService.ShowCart().then((value) {
                    if(value.key == "1"){
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>
                          DeliveryEditCart(value.variableRate,snapshotFuture.data.data.id,snapshotFuture.data.data)));
                    }else{
                      Fluttertoast.showToast(
                          msg: value.msg,
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
              ):Container(),

            ],
          ),
          body:
          // idoo.length != 0 ?
          Container(
            child:
            widget.ShowDelegateOrder.data.status == "cancel" ?Center(child: Text(AppLocalizations.of(context).translate("Order has been canceled before"),style: TextStyle(
                fontSize: MainFont,
                fontWeight: bolFont,
                color: accentColor
            ),)): ListView(
              children: [
                StreamBuilder(
                    stream: locator<StepperBloc>().stepperStream$,
                    builder: (context, snapshot) {
                      print("object snapshotttt ${snapshot.data}");

                      return Stepper(
                        physics: NeverScrollableScrollPhysics(),
                        steps: _mySteps(),
                        currentStep: snapshot.hasData? snapshot.data:0,
                        onStepTapped: (step) {
                          locator<StepperBloc>().stepperSink.add(step);
                        },
                        onStepContinue: () {
                          if (snapshot.data < this._mySteps().length - 1) {
//                      _currentStep = _currentStep + 1;
                            locator<StepperBloc>().stepperSink.add(snapshot.data + 1);
                          } else {
                            locator<StepperBloc>().stepperSink.add(2);
                            //Logic to check if everything is completed
                            print('Completed, check fields. ${locator<StepperBloc>().currentStepper}deliveryFees ${deliveryFees}');




//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     // return object of type Dialog
//                                     return AlertDialog(
//                                       content: Container(
//                                         height: MediaQuery.of(context).size.height,
//                                         width: MediaQuery.of(context).size.width,
//                                         child: Scrollbar(
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Text(
//                                                 AppLocalizations.of(context).translate("choose_delivery_fees_str"),
//                                                 style: TextStyle(
//                                                   // color: Colors.white,
//                                                   fontSize: MainFont,
//                                                   fontWeight: semiFont,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 15,),
//                                               GridView.builder(
//                                                   shrinkWrap: true,
//                                                   itemCount:
//                                                   dliveryCoasts.length,
//                                                   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                                                       crossAxisCount: 2,
//                                                       childAspectRatio: MediaQuery.of(context).size.width /
//                                                           (MediaQuery.of(context).size.height / 4)),
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                       int index) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         locator<DeliveryCostaBloc>().deliveryCostsSink.add(snapshotFuture.data.deliverys[index]);
//                                                         deliveryFees = snapshotFuture.data.deliverys[index];
//                                                         showDelivery.add(true);
// //                                                            Navigator.of(context);
// //                                                            Navigator.of(context);
//                                                         Navigator.pop(context);
//
//                                                       },
//                                                       child: Center(
//                                                           child: Text(dliveryCoasts[index],
//                                                             textAlign: TextAlign.center,
//                                                           )),
//                                                     );
//                                                   }),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
                          }
                        },
                        // onStepCancel: () {
                        //   if (snapshot.data > 0) {
                        //     locator<StepperBloc>().stepperSink.add(snapshot.data - 1);
                        //
                        //   } else {
                        //     locator<StepperBloc>().stepperSink.add(0);
                        //   }
                        // },
                      );
                    }
                ),
                SizedBox(
                  height: 30,
                ),

                Center(
                  child: ElevatedButton(
                    child: Text(AppLocalizations.of(context).translate("show_messages")),
                    onPressed: (){
                      ApiService.ShowOrder(widget.data.data.id).then((onValue){
                        if(onValue.key == "1"){
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) => MessagesWidget(data:onValue)));
                        }
                      });
                    },
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                  Card(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                        Container(
                          height: 30,
                          child:   ListView(
                            scrollDirection: Axis.horizontal,

                            children: <Widget>[
                              Text(AppLocalizations.of(context).translate("Customer_Name_:")
                                , style: TextStyle(
                                  fontWeight: bolFont,
                                  fontSize: MediumFont,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(widget.data.data.name
                                , style: TextStyle(
                                    fontWeight: bolFont,
                                    fontSize: MediumFont,
                                    color: lightText
                                ),
                              ),
                            ],
                          ),
                        ),
                          Container(
                            height: 10.0,
                          ),

                         Container(
                           height: 30,
                           child:  ListView(
                             scrollDirection: Axis.horizontal,
                             children: <Widget>[
                               Text(AppLocalizations.of(context).translate("Phone Number")
                                 , style: TextStyle(
                                   fontWeight: semiFont,
                                   fontSize: PrimaryFont,
                                 ),
                               ),
                               SizedBox(
                                 width: 5.0,
                               ),

                               InkWell(
                                 onTap: (){
                                   _launchURL("tel:+${widget.data.data.phone}");
                                 },
                                 child:
                                 Directionality( // add this
                                   textDirection: TextDirection.ltr,
                                   child: Text(widget.data.data.phone.replaceAll(new RegExp(r'[^\w\s]+'),'')
                                     , style: TextStyle(
                                         fontWeight: semiFont,
                                         fontSize: PrimaryFont,
                                         color: lightText
                                     ),
                                   ),),
                               ),
                               SizedBox(width: 50,),
                               InkWell(
                                 onTap: (){
                                   // _launchURL("https://wa.me/${widget.data.data.phone}/?text=Hello");
                                   launchWhatsApp(phone: "${widget.data.data.phone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                                   "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.data.id}""\n"
                                   "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.data.name}""\n"
                                   "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.data.phone}""\n"
                                   "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.data.address}""\n"
                                   "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                   "${AppLocalizations.of(context).translate("total")} ${widget.data.data.totalForCountry} ${widget.data.data.currencyCode}"
                                   );

                                 },
                                 child: Image.asset("assets/images/whatsapp.png",width: 20,),
                               ),
                             ],
                           ),
                         ),
                          Container(
                            height: 10.0,
                          ),

                          (widget.data.data.whatsapp != null ||widget.data.data.whatsapp != "") ?
                          Container(
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).translate("Phone Number")
                                  , style: TextStyle(
                                    fontWeight: semiFont,
                                    fontSize: PrimaryFont,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                // Directionality( // add this
                                //   textDirection: TextDirection.ltr,
                                //   child: Text("${widget.data.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'')}"
                                //   , style: TextStyle(
                                //       fontWeight: semiFont,
                                //       fontSize: PrimaryFont,
                                //       color: lightText
                                //   ),
                                // ),),


                                InkWell(
                                  onTap: (){
                                    _launchURL("tel:+${widget.data.data.whatsapp}");
                                  },
                                  child:
                                  Directionality( // add this
                                    textDirection: TextDirection.ltr,
                                    child: Text(widget.data.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'')
                                      , style: TextStyle(
                                          fontWeight: semiFont,
                                          fontSize: PrimaryFont,
                                          color: lightText
                                      ),
                                    ),),
                                ),
                                SizedBox(width: 50,),
                                InkWell(
                                  onTap: (){
                                    // _launchURL("https://wa.me/${widget.data.data.whatsapp}/?text=Hello");
                                    launchWhatsApp(phone: "${widget.data.data.whatsapp.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                                    "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.data.id}""\n"
                                        "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.data.name}""\n"
                                        "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.data.phone}""\n"
                                        "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.data.address}""\n"
                                        "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                        "${AppLocalizations.of(context).translate("total")} ${widget.data.data.totalForCountry} ${widget.data.data.currencyCode}");
                                  },
                                  child: Image.asset("assets/images/whatsapp.png",width: 20,),
                                ),

                              ],
                            ),
                          ):Container(),
                        ],
                      ),
                    ),),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius:
                            new BorderRadius.circular(50.0),
                            child: Image.network(
                              widget.data.data.marketerAvatar,
                              height: 70.0,
                              width: 70.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Text(widget.data.data.marketerName),
                          subtitle: InkWell(
                              onTap: (){
                                _launchURL("tel:+${widget.data.data.marketerPhone}");
                              },
                              child: Text(widget.data.data.marketerPhone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString())),
                          trailing: MaterialButton(
                            onPressed: ()  {
                              launchWhatsApp(phone: "${widget.data.data.marketerPhone.replaceAll(new RegExp(r'[^\w\s]+'),'').toString()}",message:
                              "${AppLocalizations.of(context).translate(" Order_Number_str")}  ${widget.data.data.id}""\n"
                                  "${AppLocalizations.of(context).translate("Customer_Name_:")}  ${widget.data.data.name}""\n"
                                  "${AppLocalizations.of(context).translate("Phone Number")}  ${widget.data.data.phone}""\n"
                                  "${AppLocalizations.of(context).translate("Adress_str")}  ${widget.data.data.address}""\n"
                                  "${AppLocalizations.of(context).translate("required_product")}  ${itemsDetails.toString()}""\n"
                                  "${AppLocalizations.of(context).translate("total")} ${widget.data.data.totalForCountry} ${widget.data.data.currencyCode}");
                            },
                            child: Image.asset(
                              "assets/images/whatsapp.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),

                          //
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width:
                              MediaQuery.of(context).size.width,
                              child: ButtonTheme(
                                height: 60.0,
                                child: RaisedButton(
                                    color: accentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(
                                            15.0)),
                                    child: Text(
                                      AppLocalizations.of(context).translate("con_send_str"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MainFont,
                                        fontWeight: semiFont,
                                      ),
                                    ),
                                    onPressed: () {

// if(locator<StatusMessageBloc>().currentStatus == "agree"){
//   Fluttertoast.showToast(
//       msg: locator<PrefsService>().appLanguage == "en" ? "you agreed order already" :"لقد قبلت الطلب بالفعل",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0
//   );
// }else{
// else{

                                      if(snapshotFuture.data.data.status == "finish"){
                                        Fluttertoast.showToast(
                                            msg: locator<PrefsService>().appLanguage == "en" ? "Order is finished" :"لقد تم تسليم الطلب بالفعل",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }else{
                                        var statusCode = locator<StepperBloc>().currentStepper;

                                        if(statusCode == 0 || statusCode == 1){
                                          if(statusCode == 0){
                                            // locator<StatusMessageBloc>().statusSink.add("agree");
                                            Fluttertoast.showToast(
                                                msg: locator<PrefsService>().appLanguage == "en" ? "you agreed order already" :"لقد قبلت الطلب بالفعل",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }else if(statusCode == 1){
                                            locator<StatusMessageBloc>().statusSink.add("in_way");
                                            locator<IsLoadingManager>().isLoading.add(true);

                                            ApiService.ChangeOrderStatus(
                                              widget.data.data.id,
                                              statusMessage.text,

                                            )
                                                .then((onValue) {
                                              locator<IsLoadingManager>().isLoading.add(false);

                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        onValue.massage),
                                                  );
                                                },
                                              );
                                            });
                                          }

                                        }

                                        if(statusCode == 2){
                                          Fluttertoast.showToast(
                                              msg: AppLocalizations.of(context).translate("choose_delivery_fees_str"),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext context) {
                                              return AlertDialog(
                                                title: Column(
                                                  children: <Widget>[
                                                    Container(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        RaisedButton(
                                                          onPressed: (){
                                                            Fluttertoast.showToast(
                                                                msg: AppLocalizations.of(context).translate("choose_delivery_fees_str"),
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.CENTER,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.red,
                                                                textColor: Colors.white,
                                                                fontSize: 16.0
                                                            );
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                // return object of type Dialog
                                                                return AlertDialog(
                                                                  content: Container(
                                                                    height: MediaQuery.of(context).size.height,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    child: Scrollbar(
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Text(
                                                                            AppLocalizations.of(context).translate("choose_delivery_fees_str"),
                                                                            style: TextStyle(
                                                                              // color: Colors.white,
                                                                              fontSize: MainFont,
                                                                              fontWeight: semiFont,
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 15,),
                                                                          GridView.builder(
                                                                              shrinkWrap: true,
                                                                              itemCount:
                                                                              dliveryCoasts.length,
                                                                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                                                                  crossAxisCount: 2,
                                                                                  childAspectRatio: MediaQuery.of(context).size.width /
                                                                                      (MediaQuery.of(context).size.height / 4)),
                                                                              itemBuilder:
                                                                                  (BuildContext context,
                                                                                  int index) {
                                                                                return InkWell(
                                                                                  onTap: () {
                                                                                    locator<DeliveryCostaBloc>().deliveryCostsSink.add(snapshotFuture.data.deliverys[index]);
                                                                                    deliveryFees = snapshotFuture.data.deliverys[index];
                                                                                    deliverySubject.sink.add(snapshotFuture.data.deliverys[index]);
//                                                            Navigator.of(context);
//                                                            Navigator.of(context);
                                                                                    Navigator.pop(context);

                                                                                  },
                                                                                  child: Center(
                                                                                      child: Text("${(double.parse(dliveryCoasts[index].toString()) * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}",
                                                                                        textAlign: TextAlign.center,
                                                                                      )),
                                                                                );
                                                                              }),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Text(AppLocalizations.of(context).translate("choose_delivery_fees_str")),
                                                        ),
                                                        StreamBuilder<Object>(
                                                            initialData: "",
                                                            stream: deliverySubject.stream,
                                                            builder: (context, deliverySubjectSnapshot) {
                                                              return Text("${deliverySubjectSnapshot.data}");
                                                            }
                                                        )
                                                      ],
                                                    ),
                                                    // TextField(
                                                    //   keyboardType: TextInputType.number,
                                                    //   controller: delivery,
                                                    //   decoration: InputDecoration(
                                                    //       hintText: AppLocalizations.of(context).translate("delivery_fees_str"),
                                                    //       labelText: AppLocalizations.of(context).translate("delivery_fees_str"),
                                                    //       //errorText: snapshot.error,
                                                    //       border:
                                                    //       OutlineInputBorder()),
                                                    // ),
                                                    Container(
                                                      height: 25.0,
                                                    ),
                                                    ButtonTheme(
                                                      height: 60.0,
                                                      minWidth: MediaQuery.of(context).size.width,
                                                      child: RaisedButton(
                                                          color: accentColor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: new BorderRadius.circular(15.0)),
                                                          child: Text(
                                                            AppLocalizations.of(context).translate("con_send_str"), style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: MainFont,
                                                            fontWeight: semiFont,
                                                          ),
                                                          ),
                                                          onPressed: () {

                                                            // if(statusMessage.text.isNotEmpty){
                                                              if(deliveryFees != null ){
                                                                locator<IsLoadingManager>().isLoading.add(true);
                                                                ApiService.DelegateFinishOrder(
                                                                    widget.data.data.id,
                                                                    statusMessage.text,
                                                                    deliveryFees
                                                                )
                                                                    .then((onValue) {
                                                                  // showDialog(
                                                                  // context: context,
                                                                  // builder: (BuildContext
                                                                  // context) {
                                                                  // return AlertDialog(
                                                                  // title: Text(
                                                                  // onValue.msg),
                                                                  // );
                                                                  // },
                                                                  // );
                                                                  locator<IsLoadingManager>().isLoading.add(false);
                                                                  Fluttertoast.showToast(
                                                                      msg: onValue.msg,
                                                                      toastLength: Toast.LENGTH_SHORT,
                                                                      gravity: ToastGravity.CENTER,
                                                                      timeInSecForIosWeb: 1,
                                                                      backgroundColor: Colors.red,
                                                                      textColor: Colors.white,
                                                                      fontSize: 16.0
                                                                  );
                                                                  if(onValue.key == "1"){
                                                                    Navigator.pop(context);

                                                                    Navigator.pushReplacement(
                                                                        context,
                                                                        new MaterialPageRoute(
                                                                            builder: (BuildContext
                                                                            context) => DeliveyHomePage(GlobalUserId)));

                                                                  }
                                                                });     }else{
                                                                Fluttertoast.showToast(
                                                                    msg: AppLocalizations.of(context).translate("choose_delivery_fees_str"),
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    gravity: ToastGravity.CENTER,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.red,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0
                                                                );
                                                              }
                                                            }
                                                            // else{
                                                            //   Fluttertoast.showToast(
                                                            //       msg: AppLocalizations.of(context).translate("write_reason_cancellation"),
                                                            //       toastLength: Toast.LENGTH_SHORT,
                                                            //       gravity: ToastGravity.CENTER,
                                                            //       timeInSecForIosWeb: 1,
                                                            //       backgroundColor: Colors.red,
                                                            //       textColor: Colors.white,
                                                            //       fontSize: 16.0
                                                            //   );
                                                            // }


                                                          // }
                                                          ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                        }
                                      }



                                    }),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width:
                              MediaQuery.of(context).size.width,
                              child: ButtonTheme(
                                height: 60.0,
                                child: RaisedButton(
                                    color: accentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(
                                            15.0)),
                                    child: Text(
                                      AppLocalizations.of(context).translate("Cancel Order"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MainFont,
                                        fontWeight: semiFont,
                                      ),
                                    ),
                                    onPressed: () {

                                      if(snapshotFuture.data.data.status == "finish"){
                                        Fluttertoast.showToast(
                                            msg: locator<PrefsService>().appLanguage == "en" ? "Order is finished" :"لقد تم تسليم الطلب بالفعل",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }else{
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return AlertDialog(
                                              title: Column(
                                                children: <Widget>[
                                                  Text(
                                                      AppLocalizations.of(context).translate("Do you want cancel Order ?")  ),
                                                  Container(
                                                    height: 25.0,
                                                  ),
                                                  TextField(
                                                    controller:
                                                    statusMessage,
                                                    maxLines: 3,
                                                    decoration:
                                                    InputDecoration(
                                                        hintText:
                                                        AppLocalizations.of(context).translate("Reason of Cancelation")
                                                        ,
                                                        labelText:
                                                        AppLocalizations.of(context).translate("Reason of Cancelation"),
                                                        //errorText: snapshot.error,
                                                        border:
                                                        OutlineInputBorder()),
                                                  ),
                                                  Container(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      RaisedButton(
                                                        onPressed: (){
                                                          Fluttertoast.showToast(
                                                              msg: AppLocalizations.of(context).translate("choose_delivery_fees_str"),
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.CENTER,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              // return object of type Dialog
                                                              return AlertDialog(
                                                                content: Container(
                                                                  height: MediaQuery.of(context).size.height,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: Scrollbar(
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        Text(
                                                                          AppLocalizations.of(context).translate("choose_delivery_fees_str"),
                                                                          style: TextStyle(
                                                                            // color: Colors.white,
                                                                            fontSize: MainFont,
                                                                            fontWeight: semiFont,
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 15,),
                                                                        GridView.builder(
                                                                            shrinkWrap: true,
                                                                            itemCount:
                                                                            dliveryCoasts.length,
                                                                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                                                                crossAxisCount: 2,
                                                                                childAspectRatio: MediaQuery.of(context).size.width /
                                                                                    (MediaQuery.of(context).size.height / 4)),
                                                                            itemBuilder:
                                                                                (BuildContext context,
                                                                                int index) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  locator<DeliveryCostaBloc>().deliveryCostsSink.add(snapshotFuture.data.deliverys[index]);
                                                                                  deliveryFees = snapshotFuture.data.deliverys[index];
                                                                                  deliverySubject.sink.add(snapshotFuture.data.deliverys[index]);
//                                                            Navigator.of(context);
//                                                            Navigator.of(context);
                                                                                  Navigator.pop(context);

                                                                                },
                                                                                child: Center(
                                                                                    child: Text("${(double.parse(dliveryCoasts[index].toString()) * double.parse(locator<PrefsService>().rateToSar.toString())).toStringAsFixed(2)}",
                                                                                      textAlign: TextAlign.center,
                                                                                    )),
                                                                              );
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Text(AppLocalizations.of(context).translate("choose_delivery_fees_str")),
                                                      ),
                                                      StreamBuilder<Object>(
                                                          initialData: "",
                                                          stream: deliverySubject.stream,
                                                          builder: (context, deliverySubjectSnapshot) {
                                                            return Text("${deliverySubjectSnapshot.data}");
                                                          }
                                                      )
                                                    ],
                                                  ),
                                                  // TextField(
                                                  //   keyboardType: TextInputType.number,
                                                  //   controller: delivery,
                                                  //   decoration: InputDecoration(
                                                  //       hintText: AppLocalizations.of(context).translate("delivery_fees_str"),
                                                  //       labelText: AppLocalizations.of(context).translate("delivery_fees_str"),
                                                  //       //errorText: snapshot.error,
                                                  //       border:
                                                  //       OutlineInputBorder()),
                                                  // ),
                                                  Container(
                                                    height: 25.0,
                                                  ),
                                                  ButtonTheme(
                                                    height: 60.0,
                                                    minWidth: MediaQuery.of(context).size.width,
                                                    child: RaisedButton(
                                                        color: accentColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: new BorderRadius.circular(15.0)),
                                                        child: Text(
                                                          AppLocalizations.of(context).translate("con_send_str"), style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MainFont,
                                                          fontWeight: semiFont,
                                                        ),
                                                        ),
                                                        onPressed: () {

                                                          if(statusMessage.text.isNotEmpty){
                                                            if(deliveryFees != null){
                                                              locator<StatusMessageBloc>().statusSink.add("cancel");
                                                              locator<IsLoadingManager>().isLoading.add(true);

                                                              ApiService.cancelOrderStatus(
                                                                  widget.data.data.id,
                                                                  statusMessage.text,
                                                                  deliveryFees
                                                              )
                                                                  .then((onValue) {
                                                                locator<IsLoadingManager>().isLoading.add(false);

                                                                if (onValue.key == "1") {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (BuildContext
                                                                          context) =>
                                                                              DeliveyHomePage(locator<
                                                                                  UserIdBloc>()
                                                                                  .currentUserId
                                                                                  .toString()
                                                                                  .toString())));
                                                                } else {
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext
                                                                    context) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            onValue.massage),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              });
                                                            }else{
                                                              Fluttertoast.showToast(
                                                                  msg: AppLocalizations.of(context).translate("choose_delivery_fees_str"),
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
                                                                msg: AppLocalizations.of(context).translate("write_reason_cancellation"),
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.CENTER,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.red,
                                                                textColor: Colors.white,
                                                                fontSize: 16.0
                                                            );
                                                          }




                                                        }),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }


                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )

          )
//             :


        );
      }
    );
  }

  List<Step> _mySteps() {

    List<Step> _steps = [
      Step(
        title: Row(
          children: <Widget>[
            Image.asset(
              "assets/images/Import.png",
              height: 35.0,
              width: 35.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              AppLocalizations.of(context).translate("Order Recived , In Progress") ,
              style: TextStyle(fontSize: PrimaryFont),
            )
          ],
        ),
        content: TextField(
          controller: statusMessage,
          maxLines: 3,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        isActive: locator<StepperBloc>().currentStepper >= 0,
      ),
      Step(
        title: Opacity(
          opacity: locator<StepperBloc>().currentStepper >= 1 ? 1 : 0.4,
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/images/shipped.png",
                height: 40.0,
                width: 40.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(

                AppLocalizations.of(context).translate("On the way")
                ,
                style: TextStyle(fontSize: PrimaryFont),
              )
            ],
          ),
        ),
        content: TextField(
          controller: statusMessage,
          maxLines: 3,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        isActive: locator<StepperBloc>().currentStepper >= 1,
      ),
      Step(
        title: Opacity(
          opacity: locator<StepperBloc>().currentStepper >= 2 ? 1 : .4,
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/images/done.png",
                height: 35.0,
                width: 35.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                AppLocalizations.of(context).translate("Done_str")

                ,
                style: TextStyle(fontSize: PrimaryFont),
              )
            ],
          ),
        ),
        content: TextField(
          controller: statusMessage,
          maxLines: 3,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        isActive: locator<StepperBloc>().currentStepper >= 2,
      )
    ];
    return _steps;
  }

  @override
  void dispose() {
    statusMessage.dispose();
    deliverySubject.close();
    super.dispose();
  }
}


class MessagesWidget extends StatelessWidget {
  final  data;
  MessagesWidget({this.data});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("show_messages")),
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
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.data.orderStatus.length,
            itemBuilder: (context, index) {

return Container(
child: Card(

  child: Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(vertical: 12),
    child: Column(
      children: [
        // Text(data.data.orderStatus[index].status),
        Text(data.data.orderStatus[index].message),
      ],
    ),
  )
),
);

            }),
      ),
    );
  }
}


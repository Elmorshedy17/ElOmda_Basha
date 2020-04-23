import 'package:flutter/material.dart';
import 'package:momentoo/features/invoice/invoice_screen.dart';
import 'package:momentoo/features/my_orders/_manager.dart';
import 'package:momentoo/features/my_orders/_model.dart';
import 'package:momentoo/features/track_details/trackDetails_screen.dart';
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/features/my_orders/reorder/_repo.dart';
import 'package:rxdart/subjects.dart';


class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {

  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);


  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('my_orders_Str'),
            // AppLocalizations.of(context).translate('test'),
            style: TextStyle(color: Colors.white),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text('Back'),
              ],
            ),
          ),
          actions: <Widget>[
            NotificationWidget(
              onPressedNotifications: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pushNamed('/notificationsScreen');

                locator<PrefsService>().notificationFlag = false;
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: isLoading.stream,
            builder: (context, isLoadingSnapshot) {
            return Stack(
              children: <Widget>[
                CustomObserver(
                    stream: locator<MyOrdersManager>().getData(),
                    onSuccess: (_, MyOrdersModel model) {
                      return Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 150,
                            width: MediaQuery.of(context).size.width - 50,
                            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
//                    physics: NeverScrollableScrollPhysics(),
                                itemCount: model.data.orders.length,
                                itemBuilder: (context, index) {
                                  return Wrap(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(model.data.orders[index].date,style: TextStyle(
                                              color: Colors.teal.shade900,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),),
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
//                          physics: BouncingScrollPhysics(),
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: model.data.orders[index].ordersInsider.length,
                                        itemBuilder: (context, ind) {
                                          return InkWell(
                                            onTap: (){
                                              Navigator.of(context).pushNamed(
                                                  '/invoiceScreen',
                                                  arguments: OrderDetailsArguments(
                                                      id: model.data.orders[index].ordersInsider[ind].id));
                                            },
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  // order status
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,

                                                    children: <Widget>[
                                                      Text(
                                                        model.data.orders[index].ordersInsider[ind].status,

                                                        style: TextStyle(
                                                            color: Colors.redAccent,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
// end order status

                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  // picture and other details
                                                  Row(
                                                    children: <Widget>[
                                                      // the order image
                                                      Container(
                                                        height: 65.0,
                                                        width: 65.0,
                                                        child: Image.network(
//                                  "https://dynl.mktgcdn.com/p/d9AXTJEWMZ156q11dLLVRHsmufNu0K-ng4JYb_4WwRI/1900x1427.jpg",
//                                          'https://picsum.photos/250?image=9',
                                                          model.data.orders[index].ordersInsider[ind].logo,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      // end the order image
                                                      SizedBox(
                                                        width: 15.0,
                                                      ),
                                                      // order number & price & desc
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            // order number
                                                            Row(
                                                              children: <Widget>[
                                                                Text(
                                                                  AppLocalizations.of(context)
                                                                      .translate("Order_Number_str"),
                                                                  style: TextStyle(
                                                                      color: Colors.teal.shade900,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 15.0,
                                                                ),
                                                                Text(
                                                                  "# ${model.data.orders[index].ordersInsider[ind].id}",
                                                                  style: TextStyle(
                                                                      color: Colors.black87,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                              ],
                                                            ),
                                                            // end order number

                                                            SizedBox(
                                                              height: 8.0,
                                                            ),
// desc of order
                                                            Text(
//                                              "2x tuna sahimi , 3x vegtables, 1x nudle",
                                                              model.data.orders[index].ordersInsider[ind].seller ,
                                                              textAlign: TextAlign.start,
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                            // end desc of order

                                                            SizedBox(
                                                              height: 8.0,
                                                            ),

                                                            // price
                                                            Text(
                                                              "${model.data.orders[index].ordersInsider[ind].total}",
                                                              style: TextStyle(
                                                                  color: Colors.teal.shade900,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                            // end price
                                                          ],
                                                        ),
                                                      ),
                                                      // order number & price & desc
                                                    ],
                                                  ),
                                                  // end picture and other details
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  RaisedButton(
                                                    color: model.data.orders[index].ordersInsider[ind].track == "yes" ? Colors.teal.shade900 : Colors.redAccent,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: new BorderRadius.circular(18.0),
//                                side: BorderSide(color: Colors.red)
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(horizontal: 15.0),
                                                      child:   model.data.orders[index].ordersInsider[ind].track == "yes" ?
                                                      Text(
                                                        AppLocalizations.of(context)
                                                            .translate('Track_your_order_str')  ,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600),
                                                      ) : Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(context)
                                                                .translate('reorder_order_str')  ,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600),
                                                          ),
                                                          SizedBox(width: 8.0,),
                                                          Icon(Icons.autorenew ,color: Colors.white,size: 18.0,)
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () {

                                                      isLoading.add(true);


                                                      if(model.data.orders[index].ordersInsider[ind].track == "yes"){
                                                        isLoading.add(false);

                                                        Navigator.of(context).pushNamed(
                                                            '/TrackorderScreen',
                                                            arguments: TrackOrderScreenArguments(
                                                                id: model.data.orders[index].ordersInsider[ind].id));


//                                                  Navigator.of(context)
//                                                      .pushNamed('/TrackorderScreen');
                                                      }else{

                                                        ReOrderRepo.postReOrderData(model.data.orders[index].ordersInsider[ind].id).then((onValue){
                                                          isLoading.add(false);

                                                          if(onValue.status == 1){
                                                            Navigator.of(context)
                                                                .pushReplacementNamed('/myOrdersScreen');
                                                          }else{
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: Text(onValue.message),
                                                                );
                                                              },
                                                            );
                                                          }

                                                        });
                                                      }

                                                    },
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                                    height: 1.0,
                                                    width: MediaQuery.of(context).size.width,
                                                    color: Colors.grey.withOpacity(.2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
                isLoading.value == true
                    ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                      child: Container(
//                      color: mainColor,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
                )
                    : Container(),
              ],
            );
          }
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
  void dispose() {
    isLoading.close();

    super.dispose();
  }
}



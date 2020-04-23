import 'package:flutter/material.dart';
import 'package:momentoo/features/invoice/_manager.dart';
import 'package:momentoo/features/invoice/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';


class OrderDetailsArguments {
  final int id;

  OrderDetailsArguments({@required this.id});
}

class InvoiceScreen extends StatelessWidget {

  OrderDetailsArguments args;


  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: CustomObserver(
          stream: locator<OrderDetailsManager>().getData(args.id),
          onSuccess: (_, InvoiceModel model) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
//                AppLocalizations.of(context).translate('Invoice_str')
                model.message ,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily:
                        locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar'),
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
            ),
            body: Center(
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 115.0,
                        color: Colors.teal.shade900,
                        child: Row(
                          children: <Widget>[

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('Order_str'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            locator<PrefsService>().appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar'),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('Order_No_str'),
                                        style: TextStyle(
                                            fontSize: 21.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: locator<PrefsService>()
                                                        .appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar'),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        "${model.data.order.id}",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: locator<PrefsService>()
                                                        .appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar'),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${model.data.order.date}",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white,
                                        fontFamily:
                                            locator<PrefsService>().appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar'),
                                  ),
                                ],
                              ),
                            ),                            Expanded(
                              child: Center(
                                  child: Container(
                                      margin: EdgeInsets.all(25.0),
                                      child:
                                      Image.asset("assets/images/logo.png"))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Stack(
                            children: <Widget>[
                              ListView(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${model.data.order.name}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.teal.shade900,
                                        fontFamily:
                                            locator<PrefsService>().appLanguage == 'en'
                                                ? 'en'
                                                : 'ar'),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "${model.data.order.street}",
                                    style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontFamily:
                                            locator<PrefsService>().appLanguage == 'en'
                                                ? 'en'
                                                : 'ar'),
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                  ),

                                ListView.builder(
                                  shrinkWrap: true,
//                          physics: BouncingScrollPhysics(),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.data.order.products.length,
                                  itemBuilder: (context, ind) {
                                    return                               Container(
                                      margin: EdgeInsets.only(bottom: 13.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "${model.data.order.products[ind].name}",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "${model.data.order.products[ind].price}",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

Divider(),
                                  SizedBox(
                                    height: 30,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * .3,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate('delivery_Fees_str'),
                                              style: TextStyle(color: Colors.grey,fontSize: 18.0,fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "${model.data.order.delivery}",
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * .3,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate('subtotal_str'),
                                              style: TextStyle(color: Colors.grey,fontSize: 18.0,fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "${model.data.order.subTotal}",
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),


                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Container(
                                    height: 1.0,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey.withOpacity(.3),
                                  ),
                                  Container(
//                                    color: Colors.red,
                                    height: 150.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('total_Str'),
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.grey.withOpacity(.7),
                                              fontFamily:
                                                  locator<PrefsService>().appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar'),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${model.data.order.total}",
                                          style: TextStyle(
                                              fontSize: 21.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.teal.shade900,
                                              fontFamily:
                                                  locator<PrefsService>().appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    );
  }
}

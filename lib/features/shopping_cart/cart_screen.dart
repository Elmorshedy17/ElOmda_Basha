import 'package:flutter/material.dart';
import 'package:momentoo/features/order_details/orderDetails_screen.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:rxdart/rxdart.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  List<BehaviorSubject> countWithIndex = new List();
  List<BehaviorSubject> singleCartTotal = new List();
  BehaviorSubject totalCartsMount = new BehaviorSubject();
  List<List> totalCartsMountList = new List();
  List testTotalCartsMountList = [];


  List<Cart> singleCart = <Cart>[
    Cart(1, "Product name 1", "This text is an example of text that can be  ",
        100, 'https://picsum.photos/250?image=9', 1, "11:00 am"),
    Cart(2, "Product name 2", "This text is an example of text that can be  ",
        100, 'https://picsum.photos/250?image=9', 20, "11:00 am"),
    Cart(3, "Product name 3", "This text is an example of text that can be  ",
        100, 'https://picsum.photos/250?image=9', 10, "11:00 am"),
    Cart(4, "Product name 4", "This text is an example of text that can be  ",
        100, 'https://picsum.photos/250?image=9', 5, "11:00 am"),
  ];

  @override
  Widget build(BuildContext context) {
//    for (int index = 0;index < singleCart.length;index++) {
//      countWithIndex[index].close();
//      singleCartTotal[index].close();
//    }
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.2,
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
                Text(AppLocalizations.of(context).translate('back_str')),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // FocusScope.of(context).requestFocus(FocusNode());
                // overlayEntry?.remove();
                Navigator.of(context).pushNamed('/notificationsScreen');
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              child: ListView(
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: singleCart.length,
                      itemBuilder: (context, index) {


                        totalCartsMountList
                            .add(new List());
                        countWithIndex
                            .add(new BehaviorSubject());

                        singleCartTotal
                            .add(new BehaviorSubject());

                        return Container(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
// picture and other details
                              Row(
                                children: <Widget>[
// the order image
                                  Container(
                                    height: 65.0,
                                    width: 65.0,
                                    child: Image.network(
                                      singleCart[index].imgUrl,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
// order number
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              singleCart[index].name,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              width: 50.0,
                                              height: 25.0,
                                              child: FlatButton(
                                                onPressed: () {},
                                                child: Image.asset(
                                                    "assets/images/close@2x.png"),
                                              ),
                                            ),
                                          ],
                                        ),
// end order number

                                        SizedBox(
                                          height: 8.0,
                                        ),
// desc of order
                                        Text(
                                          singleCart[index].desc,
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
                                        StreamBuilder(
                                          stream: countWithIndex[index].stream,
                                          initialData: singleCart[index].count,
                                          builder: (context, countWithIndexSnapshot) {
                                            singleCartTotal[index].add(countWithIndexSnapshot.data * singleCart[index].price);

                                            return StreamBuilder(
                                              stream: singleCartTotal[index].stream,
                                                initialData: singleCart[index].price,
                                                builder: (context, singleCartTotalSnapshot) {
                                                return Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
//                                                            singleCart[index]
//                                                                .price
//                                                                .toString()
                                                            singleCartTotalSnapshot.data.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .teal.shade900,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight.w600),
                                                          ),
                                                          SizedBox(
                                                            width: 4.0,
                                                          ),
                                                          Text(
                                                            "KW",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .teal.shade900,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight.w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          IconButton(
                                                            onPressed: () {
                                                                countWithIndex[index].add(singleCart[index].count++);

                                                            },
                                                            icon: Container(
                                                              width: 50.0,
                                                              height:25,
                                                              decoration: new BoxDecoration(
                                                                  color: Colors
                                                                      .teal.shade900,
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          13.0))),
                                                              child: Center(
                                                                child: Text(
                                                                  "+",
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 21.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15.0),
                                                            child: Text(
//                                                          singleCart[index]
//                                                              .count
//                                                              .toString()
                                                             countWithIndexSnapshot.data.toString() ,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .teal.shade900,
                                                                  fontSize: 24.0,
                                                                  fontWeight:
                                                                      FontWeight.bold),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {

                                                              if (singleCart[index].count >= 1) {
                                                                countWithIndex[index].add(singleCart[index].count--);
                                                              }

                                                            },
                                                            icon: Container(
                                                              width: 50.0,
                                                              height:25,
                                                              decoration: new BoxDecoration(
                                                                  color: Colors
                                                                      .teal.shade900,
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              13.0))),
                                                              child: Center(
                                                                child: Text(
                                                                  "-",
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 21.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                            );
                                          }
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
                                height: 10.0,
                              ),
                              Container(
                                height: 1.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.withOpacity(.2),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder(
                    stream: totalCartsMount.stream,
                    builder: (context, totalCartsMountSnapshot) {
                      for (int index = 0;index < singleCart.length;index++) {
                        totalCartsMountList[index].clear();
                        totalCartsMountList[index].add(singleCartTotal[index].value);
                      }
                      var sum = totalCartsMountList.reduce((a, b) => a + b);
                      var finalSum = sum.fold(0, (previous, current) => previous + current);
                      totalCartsMount.add(finalSum);

                      return Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context)
                                      .translate("subtotal_str"),style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),),
                                  Row(
                                    children: <Widget>[
                                      Text(totalCartsMountSnapshot.data.toString() ,style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text("KD",style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context)
                                      .translate("additional_Fees_str"),style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),),
                                  Row(
                                    children: <Widget>[
                                      Text("24.5",style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text("KD",style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context)
                                      .translate("Discount_str"),style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),),
                                  Row(
                                    children: <Widget>[
                                      Text("24.5",style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text("KD",style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context)
                                      .translate("subtotal_str"),style: TextStyle(
                                      color: Colors.teal.shade900,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),),
                                  Row(
                                    children: <Widget>[
                                      Text("24.5",style: TextStyle(
                                          color: Colors.teal.shade900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),

                                      Text("KD",style: TextStyle(
                                          color: Colors.teal.shade900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ButtonTheme(
                    minWidth: 280.0,
                    height: 55.0,
                    child: RaisedButton(
                      color: Colors.teal.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate('Checkout_str'),
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {

                        print("totalCartsMountList ${totalCartsMount.value}");

                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }




  dispose() {
    totalCartsMount.close();
    super.dispose();
  }
}

class Cart {
  final int id;
  final String name;
  final String desc;
  final int price;
  final String imgUrl;
  final String time;
  int count;

  Cart(this.id, this.name, this.desc, this.price, this.imgUrl, this.count,
      this.time);
}

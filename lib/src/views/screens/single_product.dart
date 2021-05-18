import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/src/views/screens/my_orders.dart';
import 'package:medicine/theme_setting.dart';
// import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share/share.dart';

class SingleProduct extends StatefulWidget {

  var sectionDataContent;
  SingleProduct(this.sectionDataContent);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //     color: Colors.yellow,
          ),
          Container(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.0)),
              child: Container(
                color: Color(0xffC1DAF9),
                height: MediaQuery.of(context).size.height / 2.8,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child:

                    Image.network(widget.sectionDataContent.image,
                       width: MediaQuery.of(context).size.width,
                       height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fitHeight,

                 ),

//                  Image.asset(
//                    'assets/images/medicine.png',
//                    // width: size.width,
//                    // height: size.height,
//                    fit: BoxFit.fitHeight,
//                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 15.0),
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.transparent,

//                    color: Color(0xffC1DAF9),
                    elevation: 0,
                    onPressed: () {
                      Share.share(

                          '${widget.sectionDataContent.image} \n ${ widget.sectionDataContent.desc}');
                    },
                    child: Image.asset(
                      "assets/images/share.png",
                      height: 40,
                      width: 40.0,
                    ),
                  ),
                  RaisedButton(
                    color: Colors.transparent,
//                    color: Color(0xffC1DAF9),
                    elevation: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/images/back_.png",
                      height: 40,
                      width: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.7,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              // color: Colors.red,
              //   color: Colors.red,
              child: ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  _mainDesc(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _descritopn(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.white,
              height: 125.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  ButtonTheme(
                    height: 60.0,
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                               AppLocalizations.of(context).translate("Order_str"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MainFont,
                              fontWeight: semiFont,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white.withOpacity(.5),
                            ),
                            padding: EdgeInsets.all(8.0),
                            height: 40.0,
                            width: 45.0,
                            child: Image.asset(
                              "assets/images/cart.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
//                        Navigator.push(
//                            context,
//                            new MaterialPageRoute(
//                                builder: (BuildContext context) => MyOrdersScreen()));



//                        ApiService.AddToCart(widget.sectionDataContent.id.toString());

                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return FutureBuilder(
                                  future: ApiService.AddToCart(widget.sectionDataContent.id.toString()),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    return AlertDialog(
                                      title: snapshot.hasData? Text(snapshot.data.msg):Center(child: CircularProgressIndicator()),
                                    );
                                  }
                              );
                            }
                        );



                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descritopn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate("About_Product_str :"),
          style: TextStyle(fontSize: PrimaryFont, fontWeight: bolFont),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
            widget.sectionDataContent.desc
    //"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using "
            ,textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: PrimaryFont, fontWeight: semiFont, color: littleGrey)),
      ],
    );
  }

  Widget _mainDesc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.sectionDataContent.title,
                //"Product Name",
                style: TextStyle(fontSize: MainFont, fontWeight: bolFont),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate("Amount_str :") ,
                    style:
                        TextStyle(fontSize: PrimaryFont, fontWeight: bolFont),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("${widget.sectionDataContent.quantity.toString()} ${AppLocalizations.of(context).translate("packages_str")} ",
                      style: TextStyle(
                          fontSize: PrimaryFont,
                          fontWeight: regFont,
                          color: littleGrey)),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  widget.sectionDataContent.price.toString(),
                  //"100",
                  style: TextStyle(
                      fontSize: MainFont,
                      fontWeight: bolFont,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Text(AppLocalizations.of(context).translate("Suadi_Reyals_str"),
                  style: TextStyle(
                      fontSize: PrimaryFont,
                      fontWeight: regFont,
                      color: littleGrey)),
            ],
          ),
        ),
      ],
    );
  }
}

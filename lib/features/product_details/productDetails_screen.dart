//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
//class ProductDetailsScreen extends StatefulWidget {
//  @override
//  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
//}
//
//class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      child: Stack(
//        children: <Widget>[
//          SingleChildScrollView(
//            // physics: BouncingScrollPhysics(),
//            scrollDirection: Axis.vertical,
//            child: Column(
//              children: <Widget>[
//                Container(
//                  height: MediaQuery.of(context).size.height * 0.5,
//                  width: MediaQuery.of(context).size.width,
//                  color: Colors.red,
//                  child: Stack(
//                    children: <Widget>[
//                      InkWell(
//                        onTap: () {},
//                        child: Image.asset(
//                          'assets/images/x.png',
//                          fit: BoxFit.cover,
//                          height: MediaQuery.of(context).size.height * 0.5,
//                          width: MediaQuery.of(context).size.width,
//                        ),
//                      ),
//                      Align(
//                        alignment: Alignment.bottomCenter,
//                        child: ListTile(
//                          title: Text(
//                            'California Roll With Black Sesame',
//                            style: TextStyle(
//                                color: Colors.teal.shade900,
//                                // fontWeight: FontWeight.bold,
//                                fontSize: 25),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                ListTile(
//                  isThreeLine: true,
//                  title: Text(
//                    'DESCRIPTION',
//                    style: TextStyle(
//                      color: Colors.teal.shade900,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                  subtitle: Text(
//                      '''The user can click on the product picture to see it in bigger scale and scroll to see any other pictures for the product.'''),
//                ),
//                ListTile(
//                  title: Text(
//                    'EXTRAS',
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                ),
//                ListView.separated(
//                  shrinkWrap: true,
//                  primary: false,
//                  itemCount: 6,
//                  separatorBuilder: (context, index) {
//                    return Divider(
//                      indent: 10,
//                      endIndent: 10,
//                      color: Colors.black12,
//                      height: 1,
//                    );
//                  },
//                  itemBuilder: (context, index) {
//                    return ListTile(
//                      title: Row(
//                        children: <Widget>[
//                          Text(
//                            'data',
//                            style: TextStyle(fontWeight: FontWeight.bold),
//                          ),
//                          Text(
//                            ' + 35.00 KD',
//                            style: TextStyle(color: Colors.black38),
//                          ),
//                        ],
//                      ),
//                    );
//                  },
//                ),
//                Divider(
//                  indent: 10,
//                  endIndent: 10,
//                  color: Colors.black12,
//                  height: 1,
//                ),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//                RaisedButton(onPressed: () {}),
//              ],
//            ),
//          ),
//          Align(
//            alignment: Alignment.topCenter,
//            child: Row(
//              mainAxisSize: MainAxisSize.max,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                InkWell(
//                  onTap: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.arrow_back_ios,
//                        color: Colors.white,
//                        // size: 15,
//                      ),
//                      Text(
//                        'Back',
//                        style: TextStyle(color: Colors.white),
//                      ),
//                    ],
//                  ),
//                ),
//                Spacer(
//                  flex: 1,
//                ),
//                Container(
//                  width: 40,
//                  height: 40,
//                  margin: EdgeInsets.all(4),
//                  decoration: BoxDecoration(
//                    color: Colors.grey.shade200,
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(1000),
//                    ),
//                  ),
//                  child: IconButton(
//                    icon: Icon(
//                      FontAwesomeIcons.shareSquare,
//                      color: Colors.black,
//                      size: 20,
//                    ),
//                    onPressed: () {},
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

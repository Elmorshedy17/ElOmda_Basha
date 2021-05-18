import 'package:flutter/material.dart';
import 'package:medicine/theme_setting.dart';
import 'package:shimmer/shimmer.dart';


class HomePageImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.white,
        ), baseColor: Colors.grey[300], highlightColor: Colors.white);
  }
}

class HomePagePrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Shimmer.fromColors(
        child: Container(
          height: 20.0,
          width: 60.0,
          color: Colors.white,
        ), baseColor: Colors.grey[300], highlightColor: Colors.white);
  }
}

class HomePageProductName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Shimmer.fromColors(
        child: Container(
          height: 20.0,
          width: 100.0,
          color: Colors.white,
        ), baseColor: Colors.grey[300], highlightColor: Colors.white);
  }
}

class HomePageDesc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return     Shimmer.fromColors(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 20.0,
              width: 220.0,
              color: Colors.white,
            ),
            Container(
              height: 10.0,
            ),
            Container(
              height: 20.0,
              width: 220.0,
              color: Colors.white,
            )
          ],
        ), baseColor: Colors.grey[300], highlightColor: Colors.white);
  }
}



class HomePageItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 200.0,
          width: 300.0,
          //    color: Colors.green,
          child: Stack(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3.0,
                child: Container(
                  height: 190.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 100.0,
                  padding: EdgeInsets.only(
                      top: 7.0, right: 70.0, bottom: 0.0, left: 15.0),
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          HomePageProductName(),
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      HomePageDesc(),
                      Container(
                        height: 5.0,
                      ),
                      HomePagePrice(),
                      Container(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ButtonTheme(
                              height: 40.0,
                              child: RaisedButton(
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                                child: FittedBox(
                                  child: Text(
                                    "/ / / /",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: PrimaryFont,
                                      fontWeight: regFont,
                                    ),
                                  ),
                                ),

//                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (BuildContext context) =>
//                                          MyOrdersScreen()));
//                            },
                              ),
                            ),
                          ),
                          Expanded(
                            child:HomePagePrice(),
                          ),
                        ],
                      ),
                      Container(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 40,
                  right: 0.0,
                  child: InkWell(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: (BuildContext context) => SingleProduct()));
//                },
                    child:
                    HomePageImage(),
                  )),
            ],
          ),
        ),Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 200.0,
          width: 300.0,
          //    color: Colors.green,
          child: Stack(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3.0,
                child: Container(
                  height: 190.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 100.0,
                  padding: EdgeInsets.only(
                      top: 7.0, right: 70.0, bottom: 0.0, left: 15.0),
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          HomePageProductName(),
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      HomePageDesc(),
                      Container(
                        height: 5.0,
                      ),
                      HomePagePrice(),
                      Container(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ButtonTheme(
                              height: 40.0,
                              child: RaisedButton(
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                                child: FittedBox(
                                  child: Text(
                                    "/ / / /",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: PrimaryFont,
                                      fontWeight: regFont,
                                    ),
                                  ),
                                ),

//                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (BuildContext context) =>
//                                          MyOrdersScreen()));
//                            },
                              ),
                            ),
                          ),
                          Expanded(
                            child:HomePagePrice(),
                          ),
                        ],
                      ),
                      Container(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 40,
                  right: 0.0,
                  child: InkWell(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: (BuildContext context) => SingleProduct()));
//                },
                    child:
                    HomePageImage(),
                  )),
            ],
          ),
        ),Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 200.0,
          width: 300.0,
          //    color: Colors.green,
          child: Stack(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3.0,
                child: Container(
                  height: 190.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 100.0,
                  padding: EdgeInsets.only(
                      top: 7.0, right: 70.0, bottom: 0.0, left: 15.0),
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          HomePageProductName(),
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      HomePageDesc(),
                      Container(
                        height: 5.0,
                      ),
                      HomePagePrice(),
                      Container(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ButtonTheme(
                              height: 40.0,
                              child: RaisedButton(
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                                child: FittedBox(
                                  child: Text(
                                    "/ / / /",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: PrimaryFont,
                                      fontWeight: regFont,
                                    ),
                                  ),
                                ),

//                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (BuildContext context) =>
//                                          MyOrdersScreen()));
//                            },
                              ),
                            ),
                          ),
                          Expanded(
                            child:HomePagePrice(),
                          ),
                        ],
                      ),
                      Container(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 40,
                  right: 0.0,
                  child: InkWell(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: (BuildContext context) => SingleProduct()));
//                },
                    child:
                    HomePageImage(),
                  )),
            ],
          ),
        ),Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 200.0,
          width: 300.0,
          //    color: Colors.green,
          child: Stack(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 3.0,
                child: Container(
                  height: 190.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 100.0,
                  padding: EdgeInsets.only(
                      top: 7.0, right: 70.0, bottom: 0.0, left: 15.0),
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          HomePageProductName(),
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      HomePageDesc(),
                      Container(
                        height: 5.0,
                      ),
                      HomePagePrice(),
                      Container(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ButtonTheme(
                              height: 40.0,
                              child: RaisedButton(
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                                child: FittedBox(
                                  child: Text(
                                    "/ / / /",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: PrimaryFont,
                                      fontWeight: regFont,
                                    ),
                                  ),
                                ),

//                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  new MaterialPageRoute(
//                                      builder: (BuildContext context) =>
//                                          MyOrdersScreen()));
//                            },
                              ),
                            ),
                          ),
                          Expanded(
                            child:HomePagePrice(),
                          ),
                        ],
                      ),
                      Container(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 40,
                  right: 0.0,
                  child: InkWell(
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: (BuildContext context) => SingleProduct()));
//                },
                    child:
                    HomePageImage(),
                  )),
            ],
          ),
        )
      ],
    );
  }
}

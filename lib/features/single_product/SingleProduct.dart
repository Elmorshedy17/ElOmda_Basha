import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/subjects.dart';
import 'package:share/share.dart';

class SingleProduct extends StatefulWidget {
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {

  BehaviorSubject _counter = new BehaviorSubject();

  int _count = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(backgroundColor: Colors
              .teal.shade900,
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
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Share.share('انا استخدم هذا المنتج + google play url',
                          subject: 'Look what I made!');

                      print("ey");
                    },
                    child: Icon(
                      Icons.share,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Collapsing Toolbar",
                      style: TextStyle(
                        color: Colors
                            .teal.shade900,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('Description_str'),
                style: TextStyle(
                    color: Colors.teal.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                AppLocalizations.of(context).translate('Extras_str'),
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                         "Tuna",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 10.0,),
                   Expanded(
                     child: Row(
                       children: <Widget>[
                         Text(
                           "35.00 +",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                         SizedBox(width: 5.0,),
                         Text(
                           "KD",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                   ),
                      ],
                    ),
                  ),
                  Divider(),  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                         "Tuna",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 10.0,),
                   Expanded(
                     child: Row(
                       children: <Widget>[
                         Text(
                           "35.00 +",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                         SizedBox(width: 5.0,),
                         Text(
                           "KD",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                   ),
                      ],
                    ),
                  ),
                  Divider(),  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                         "Tuna",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 10.0,),
                   Expanded(
                     child: Row(
                       children: <Widget>[
                         Text(
                           "35.00 +",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                         SizedBox(width: 5.0,),
                         Text(
                           "KD",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                   ),
                      ],
                    ),
                  ),
                  Divider(),  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                         "Tuna",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 10.0,),
                   Expanded(
                     child: Row(
                       children: <Widget>[
                         Text(
                           "35.00 +",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                         SizedBox(width: 5.0,),
                         Text(
                           "KD",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                   ),
                      ],
                    ),
                  ),
                  Divider(),  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                         "Tuna",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 10.0,),
                   Expanded(
                     child: Row(
                       children: <Widget>[
                         Text(
                           "35.00 +",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                         SizedBox(width: 5.0,),
                         Text(
                           "KD",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                   ),
                      ],
                    ),
                  ),
                  Divider(),  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                         "Tuna",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(width: 10.0,),
                   Expanded(
                     child: Row(
                       children: <Widget>[
                         Text(
                           "35.00 +",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                         SizedBox(width: 5.0,),
                         Text(
                           "KD",
                           style: TextStyle(
                               color: Colors.grey.shade600,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                   ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
              SizedBox(
                height: 28.0,
              ),
              StreamBuilder(
                stream: _counter.stream,
                initialData: _count,
                builder: (context, counterSnapshot) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('Quantity_str'),
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),

                        Container(
                          height: 45.0,
                          decoration: new BoxDecoration(
                              border: Border.all(color: Colors.teal.shade900,width: 1),
                              color: Colors.teal.shade900,
                              borderRadius: new BorderRadius.all(
                              Radius.circular(40.0)
                              )
                        ),
                        child: Container(
                          width: 140.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 70.0,
                                child: Center(
                                  child: FlatButton(
                                      onPressed: (){
                                        _counter.add(_count++);
                                      },
                                      child: Text("+",style: TextStyle(color: Colors.white,fontSize: 40.0,height: 1.0),)),
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                                    borderRadius: new BorderRadius.only(
                                        topLeft: locator<PrefsService>().appLanguage != "ar" ? const  Radius.circular(0.0): const  Radius.circular(40.0) ,
                                        bottomLeft: locator<PrefsService>().appLanguage != "ar" ?const  Radius.circular(0.0): const  Radius.circular(40.0),

                                        topRight: locator<PrefsService>().appLanguage == "ar" ? const  Radius.circular(0.0): const  Radius.circular(40.0) ,
                                        bottomRight: locator<PrefsService>().appLanguage == "ar" ? const  Radius.circular(0.0) : const  Radius.circular(40.0),

                                    ),),

//                                  decoration: new BoxDecoration(
//                                    color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
//                                    borderRadius: new BorderRadius.only(
//                                      topLeft: locator<PrefsService>().appLanguage != "en" ? const  Radius.circular(40.0) : const  Radius.circular(0.0),
//                                      bottomLeft: locator<PrefsService>().appLanguage != "en" ? const  Radius.circular(40.0) : const  Radius.circular(0.0),
//
//                                      topRight: locator<PrefsService>().appLanguage == "en" ?  const  Radius.circular(40.0) : const  Radius.circular(0.0),
//                                      bottomRight: locator<PrefsService>().appLanguage == "en" ? const  Radius.circular(40.0) : const  Radius.circular(0.0),
//
//                                    ),),
                                  width: 70.0,
                                  child: Center(
                                    child: FlatButton(
                                        onPressed: (){
                                          if(_count >= 1){
                                            _counter.add(_count--);
                                          }
                                        },
                                        child: Text("-",style: TextStyle(color:Colors
                                            .teal.shade900,fontSize: 40.0,height: 1.0),)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),

                        Text(
                           "${counterSnapshot.data}  ${AppLocalizations.of(context).translate('item_str')}",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  );
                }
              ),

              SizedBox(
                height: 28.0,
              ),

        Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        child: TextField(
          maxLines: 10,
          decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              hintStyle: TextStyle(color: Colors.grey[600],fontSize: 16,fontWeight: FontWeight.w800),
              hintText: locator<PrefsService>().appLanguage == "ar" ?"التعليمات": "instructions",
              fillColor: Colors.white),
        ),
        ),

          SizedBox(height: 28.0,) ,
              ButtonTheme(
                minWidth: 280.0,
                height: 55.0,
                child: RaisedButton(
                  color: Colors.teal.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('Add_to_order_str'),
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        Text(
                          "25.8 ${AppLocalizations.of(context).translate('Kd_str')}",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  onPressed: (){},
                ),
              ),
SizedBox(
  height: 40.0,
),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(),

    );
  }
  dispose() {
    _counter.close();
    super.dispose();
  }
}


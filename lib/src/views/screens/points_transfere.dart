import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/carousel_indicator.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/markteres_points_transfere.dart';
import 'package:medicine/theme_setting.dart';



class CarouselWithIndicator extends StatefulWidget {
  var data;
  CarouselWithIndicator(this.data);
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {

  List allData = [];




  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

//  int _current = 0;
  List dataList = [
  ];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.data.data.length; i++) {
      dataList.add(widget.data.data[i]);
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate("Markter_Points_Transfere_str")),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage(locator<UserIdBloc>().currentUserId.toString())));
            },
          ),
        ),
//      appBar: AppBar(
//        title: Text("Points Transfere"),
//      ),
      body: StreamBuilder(
        initialData: 0,
        stream: locator<CarouselIndicatorBloc>().carouselIndStream$,
        builder: (context, snapshot) {
          return Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Text(AppLocalizations.of(context).translate("Choose_the_sutabel_package : "),style: TextStyle(fontSize: MainFont,fontWeight: bolFont),),
              ],
            ),
          SizedBox(
            height: 35.0,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 2 ,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 7),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: true,
              // pauseAutoPlayOnTouch: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason){
                locator<CarouselIndicatorBloc>().carouselIndSink.add(index);
              }
            ),

//           onPageChanged: (index) {
// //        setState(() {
// //        });
// //        _current = index;
//             locator<CarouselIndicatorBloc>().carouselIndSink.add(index);
//           },
          items: dataList.map((allData) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => MarktersPointsTransfrer(allData.id)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
//              decoration: BoxDecoration(
//                color: Colors.green,
//              ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent,width: 3.0),
//                  color: Colors.orange,
//                  shape: BoxShape.circle,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(AppLocalizations.of(context).translate("package_of_str"),style: TextStyle(fontSize: MainFont,fontWeight: bolFont),),
                        Text("${allData.point}",style: TextStyle(fontSize: 40.0,fontWeight: bolFont,color: primaryColor),),
                        Text(AppLocalizations.of(context).translate("Points_str"),style: TextStyle(fontSize: MainFont,fontWeight: bolFont),),

                        Container(
                          height: 15.0,
                        ),
//                  Image.network(
//                    imgUrl,
//                    fit: BoxFit.fill,
//                    height: 40.0,
//                    width: 40.0,
//                  ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),

   ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(dataList, (index, url) {
                return Container(
                  width: snapshot.data == index ? 30.0 : 15.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                   shape: snapshot.data == index ? BoxShape.rectangle : BoxShape.circle,
                    color: snapshot.data == index ? primaryColor : Colors.grey,
                  ),
                );
              }),
            ),
          ]));
        }
      ));

  }}




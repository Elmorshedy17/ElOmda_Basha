import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/points_transfere.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';

class MarktersPointsTransfrer extends StatefulWidget {
  var id;

  MarktersPointsTransfrer(this.id);

  @override
  _MarktersPointsTransfrerState createState() =>
      _MarktersPointsTransfrerState();
}

class _MarktersPointsTransfrerState extends State<MarktersPointsTransfrer> {
  List<BehaviorSubject> _BehaviorSubjects = new List();
  List allIds = [];

  @override
  Widget build(BuildContext context) {
    ApiService.ShowPackageMarketers(widget.id).then((onValue){
      for (var i = 0; i < onValue.data.length; i++) {
        _BehaviorSubjects.add(new BehaviorSubject());
      }
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate("Markter_Points_Transfere_str")),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
            ),
            onPressed: () {
//              Navigator.pop(context);
              ApiService.PackagesShow().then((data) => data.key == "1"
                  ? Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CarouselWithIndicator(data)))
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(data.msg),
                        );
                      },
                    ));
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: FutureBuilder(
                  future: ApiService.ShowPackageMarketers(widget.id),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, int index) {
                          return Container(
                            margin: EdgeInsets.all(10.0),
                            child: StreamBuilder(
                                stream: _BehaviorSubjects[index].stream,
                                initialData: false,
                                builder: (context, snapshotBool) {
                                  return Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          if(snapshotBool.data == true){
                                            _BehaviorSubjects[index].sink.add(false);
                                            allIds.remove(snapshot.data.data[index].id);
                                          }else{
                                            _BehaviorSubjects[index].sink.add(true);
                                            allIds.add(snapshot.data.data[index].id);
                                          }
                                          print(allIds.toString().substring(1, allIds.toString().length - 1));


                                        },
                                        child: Container(
                                          height: 30.0,
                                          width: 30.0,
                                          decoration: new BoxDecoration(
                                              color: snapshotBool.data == false ?  Colors.transparent : primaryColor,
                                              border: Border.all(
                                                  color: Colors.grey, width: 1.0),
                                              borderRadius: new BorderRadius.all(
                                                  Radius.circular(50.0))),
                                        ),
                                      ),
                                      Container(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 4.0,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: ListTile(
                                              leading: ClipRRect(
                                                borderRadius:
                                                new BorderRadius.circular(50.0),
                                                child: Image.network(
                                                  snapshot.data.data[index].avatar ,
                                                  height: 65.0,
                                                  width: 65.0,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              title: Text(
                                                snapshot.data.data[index].name ,
                                                style: TextStyle(
                                                  fontWeight: bolFont,
                                                  fontSize: MainFont,
                                                ),
                                              ),
                                              subtitle: Row(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data.data[index].needPoint.toString(),
                                                    style: TextStyle(
                                                        fontSize: PrimaryFont,
                                                        fontWeight: semiFont,
                                                        color: accentColor),
                                                  ),
                                                  Container(
                                                    width: 8.0,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context).translate("Points_str"),
                                                    style: TextStyle(
                                                        fontSize: SecondaryFont,
                                                        fontWeight: regFont,
                                                        color: littleGrey),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                            ),
                          );
                        })
                        : Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            Positioned(
              bottom: 20.0,
              width: MediaQuery.of(context).size.width ,
              height: 60.0,
              child: Center(
                child: InkWell(
                  onTap: (){
                    print("$allIds");
                    ApiService.StoreGifts(widget.id,allIds.toString().substring(1, allIds.toString().length - 1)).then((data) {
                      if(data.key == "1"){

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => HomePage(locator<UserIdBloc>().currentUserId.toString().toString())));

                      }else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(data.msg),
                            );
                          },
                        );
                      }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100 ,
                    color: accentColor,
                    child: Center(child: Text(AppLocalizations.of(context).translate("Transfere_str"),style: TextStyle(color: Colors.white,fontWeight:bolFont,fontSize: MainFont ),),),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

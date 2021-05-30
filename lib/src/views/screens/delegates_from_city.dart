import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medicine/src/models/super_visor_marketers/show_cities_delgates.dart';
import 'package:url_launcher/url_launcher.dart';


class CityDelegates extends StatefulWidget {
 Data data;
 CityDelegates(this.data);

  @override
  _CityDelegatesState createState() =>
      _CityDelegatesState();
}

class _CityDelegatesState extends State<CityDelegates> {

  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+$phone/?text=${Uri.parse(message)}";
        return "https://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        // return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
        // return "https://wa.me/$phone/?text=${Uri.parse(message)}";
        return "https://wa.me/+$phone?text=${Uri.parse(message)}";

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


    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.data.title),
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
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.data.delegates.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        widget.data.delegates[index].avatar,fit: BoxFit.fill,
                        height: 75.0,
                        width: 75.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.data.delegates[index].name),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text("+${widget.data.delegates[index].phoneCode.replaceAll("+",'')} ${widget.data.delegates[index].phone}")),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: (){
                            // _launchURL("https://wa.me/${widget.data.data.phone}/?text=Hello");
                            launchWhatsApp(phone: "${widget.data.delegates[index].phoneCode.replaceAll("+",'')}${widget.data.delegates[index].phone}",message:"hello");
                          },
                          child: Image.asset("assets/images/whatsapp.png",width: 20,),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text("+${widget.data.delegates[index].whatsappCode.replaceAll("+",'')} ${widget.data.delegates[index].whatsapp}")),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: (){
                            // _launchURL("https://wa.me/${widget.data.data.phone}/?text=Hello");
                            launchWhatsApp(phone: "${widget.data.delegates[index].whatsappCode.replaceAll("+",'')}${widget.data.delegates[index].whatsapp}",message:"hello");
                          },
                          child: Image.asset("assets/images/whatsapp.png",width: 20,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }
}

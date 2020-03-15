import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:momentoo/features/join_us/birthDateDropdown.dart';
import 'package:momentoo/shared/helper/main_background.dart';

class JoinUsSecondScreen extends StatefulWidget {
  @override
  _JoinUsSecondScreenState createState() => _JoinUsSecondScreenState();
}

class _JoinUsSecondScreenState extends State<JoinUsSecondScreen> {
  // File _image;

  // Future getImageFromCam() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  // Future getImageFromGallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  int count = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> children =
        List.generate(count, (int i) => JoinUsSecondScreenItem(index: i));

    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
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
          title: Text('Join Us'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Drivers',
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '2/2',
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: children,
              ),
              // child: Container(
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   child: Card(
              //     elevation: 5,
              //     child: SingleChildScrollView(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Padding(
              //             padding: const EdgeInsets.symmetric(
              //                 vertical: 8, horizontal: 4),
              //             child: Container(
              //               padding: EdgeInsets.all(4),
              //               child: TextField(
              //                 decoration: InputDecoration(
              //                     filled: true,
              //                     border: InputBorder.none,
              //                     enabledBorder: OutlineInputBorder(
              //                       borderSide:
              //                           BorderSide(color: Colors.transparent),
              //                       borderRadius: const BorderRadius.all(
              //                         const Radius.circular(10.0),
              //                       ),
              //                     ),
              //                     hintStyle: TextStyle(color: Colors.grey[600]),
              //                     hintText: "Driver Name",
              //                     fillColor: Colors.grey[200]),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(
              //               bottom: 8.0,
              //               right: 4,
              //               left: 4,
              //             ),
              //             child: Container(
              //               padding: EdgeInsets.all(4),
              //               child: TextField(
              //                 decoration: InputDecoration(
              //                     filled: true,
              //                     border: InputBorder.none,
              //                     enabledBorder: OutlineInputBorder(
              //                       borderSide:
              //                           BorderSide(color: Colors.transparent),
              //                       borderRadius: const BorderRadius.all(
              //                         const Radius.circular(10.0),
              //                       ),
              //                     ),
              //                     hintStyle: TextStyle(color: Colors.grey[600]),
              //                     hintText: "Contact Number",
              //                     fillColor: Colors.grey[200]),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(
              //               bottom: 8.0,
              //               right: 4,
              //               left: 4,
              //             ),
              //             child: Container(
              //               padding: EdgeInsets.only(top: 4, left: 8),
              //               child: Text(
              //                 'Birth Date',
              //                 style: TextStyle(
              //                   color: Colors.teal.shade900,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           BirthDateDropdown(),
              //           Padding(
              //             padding: const EdgeInsets.all(8),
              //             child: Container(
              //               padding: EdgeInsets.all(4),
              //               decoration: BoxDecoration(
              //                 color: Colors.black12.withOpacity(0.09),
              //                 borderRadius: const BorderRadius.all(
              //                   const Radius.circular(10.0),
              //                 ),
              //               ),
              //               child: ListTile(
              //                 onTap: getImageFromGallery,
              //                 leading: Icon(Icons.camera_alt),
              //                 title: Text(
              //                   'Driver Licenses',
              //                   style: TextStyle(color: Colors.black26),
              //                 ),
              //                 trailing: FittedBox(
              //                   child: _image == null
              //                       ? Icon(Icons.add)
              //                       : Image.file(_image),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8),
              //             child: Container(
              //               padding: EdgeInsets.all(4),
              //               decoration: BoxDecoration(
              //                 color: Colors.black12.withOpacity(0.09),
              //                 borderRadius: const BorderRadius.all(
              //                   const Radius.circular(10.0),
              //                 ),
              //               ),
              //               child: ListTile(
              //                 onTap: getImageFromGallery,
              //                 leading: Icon(Icons.camera_alt),
              //                 title: Text(
              //                   'Driver ID',
              //                   style: TextStyle(color: Colors.black26),
              //                 ),
              //                 trailing: FittedBox(
              //                   child: _image == null
              //                       ? Icon(Icons.add)
              //                       : Image.file(_image),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ),
            RaisedButton(onPressed: _addNewItem)
            // Expanded(
            //     child: RaisedButton(
            //   onPressed: () {},
            // ))
          ],
        ),
      ),
    );
  }

  void _addNewItem() {
    setState(() {
      count = count + 1;
    });
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
class JoinUsSecondScreenItem extends StatefulWidget {
  final int index;

  const JoinUsSecondScreenItem({Key key, this.index}) : super(key: key);
  @override
  _JoinUsSecondScreenItemState createState() => _JoinUsSecondScreenItemState();
}

class _JoinUsSecondScreenItemState extends State<JoinUsSecondScreenItem> {
  File _image;

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 5,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: "Driver Name",
                        fillColor: Colors.grey[200]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  right: 4,
                  left: 4,
                ),
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: "Contact Number",
                        fillColor: Colors.grey[200]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  right: 4,
                  left: 4,
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 4, left: 8),
                  child: Text(
                    'Birth Date',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
              ),
              BirthDateDropdown(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.09),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  child: ListTile(
                    onTap: getImageFromGallery,
                    leading: Icon(Icons.camera_alt),
                    title: Text(
                      'Driver Licenses',
                      style: TextStyle(color: Colors.black26),
                    ),
                    trailing: FittedBox(
                      child:
                          _image == null ? Icon(Icons.add) : Image.file(_image),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.09),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  child: ListTile(
                    onTap: getImageFromGallery,
                    leading: Icon(Icons.camera_alt),
                    title: Text(
                      'Driver ID',
                      style: TextStyle(color: Colors.black26),
                    ),
                    trailing: FittedBox(
                      child:
                          _image == null ? Icon(Icons.add) : Image.file(_image),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

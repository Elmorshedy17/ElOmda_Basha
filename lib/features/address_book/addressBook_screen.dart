import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/main_background.dart';

class AddressBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
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
        ),
        body: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 60,
                  child: Center(
                    child: Text(
                      'Address Book',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    AddressBookItem(
                      deleteTag: 'd1',
                      editTag: 'e1',
                    ),
                    AddressBookItem(
                      deleteTag: 'd2',
                      editTag: 'e2',
                    ),
                    AddressBookItem(
                      deleteTag: 'd3',
                      editTag: 'e3',
                    ),
                    AddressBookItem(
                      deleteTag: 'd4',
                      editTag: 'e4',
                    ),
                    AddressBookItem(
                      deleteTag: 'd5',
                      editTag: 'e5',
                    ),
                    AddressBookItem(
                      deleteTag: 'd6',
                      editTag: 'e6',
                    ),
                    AddressBookItem(
                      deleteTag: 'd7',
                      editTag: 'e7',
                    ),
                    AddressBookItem(
                      deleteTag: 'd8',
                      editTag: 'e8',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ListTile(
          title: ButtonTheme(
            height: 45,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              color: Colors.teal.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.white24),
              ),
              child: Text(
                'Add New Address',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/newAddressScreen');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AddressBookItem extends StatelessWidget {
  final String deleteTag;
  final String editTag;
  AddressBookItem({this.deleteTag, this.editTag});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 80,
      child: Card(
        elevation: 5,
        child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                'assets/images/address_book.png',
                width: 30,
                height: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('data jhgjgjg jgkhkh khkh'),
                    Text('data'),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.grey[350],
                  heroTag: editTag,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/editAddressScreen');
                  },
                  child: Text('Edit'),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  heroTag: deleteTag,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  onPressed: () {},
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

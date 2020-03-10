import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/main_background.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: (MediaQuery.of(context).size.height * 0.1) - 40,
            right: 0.0,
            left: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                  child: Image.asset(
                'assets/images/welcome_logo.png',
                height: (MediaQuery.of(context).size.height * 0.3) - 80,
                color: Colors.white,
                // fit: BoxFit.scaleDown,
              )),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: <Widget>[Icon(Icons.arrow_back_ios), Text('Back')],
                ),
              ),
              title: Text('Forget password'),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: 500,
                  // height: (MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            """Enter your email address below and we'll send you an email with instruction on how to change your password"""),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                // spreadRadius: 1,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: "Enter Your Email",
                                fillColor: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: ListTile(
              title: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.8,
                child: RaisedButton(
                  color: Colors.teal.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.white24),
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 13,
            right: 0,
            left: 0,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

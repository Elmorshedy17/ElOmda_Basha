import 'package:flutter/material.dart';
import 'package:momentoo/features/sign_in/signInValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';

class SignInScreen extends StatelessWidget {
  final validationManager = locator<SignInValidationManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/sign_in.png',
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Sign to continue',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: validationManager.email$,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) {
                          validationManager.inEmail.add(value);
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white24,
                          ),
                          errorText: snapshot.error,
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                      stream: validationManager.password$,
                      builder: (context, snapshot) {
                        return TextField(
                          onChanged: validationManager.inPassword.add,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.white24,
                            ),
                            errorText: snapshot.error,
                          ),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      StreamBuilder(
                          initialData: true,
                          stream: validationManager.checkBoxValue$,
                          builder: (context, snapshot) {
                            return Checkbox(
                              activeColor: Colors.white,
                              hoverColor: Colors.white,
                              checkColor: Colors.teal.shade800,
                              focusColor: Colors.white,
                              value: snapshot.data,
                              onChanged: (value) {
                                validationManager.setCheckBoxValue(value);
                              },
                            );
                          }),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          child: StreamBuilder(
                              stream: validationManager.isFormValid$,
                              builder: (context, snapshot) {
                                return RaisedButton(
                                  color: Colors.teal.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.white24),
                                  ),
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (snapshot.hasData) {}
                                  },
                                );
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/forgetPasswordScreen');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Forget your password?',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/homeScreen');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Continue as guest',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/signUpScreen');
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 1,
                                      color: Colors.white70,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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
}

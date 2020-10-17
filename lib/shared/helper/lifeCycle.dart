import 'package:flutter/material.dart';
import 'package:momentoo/features/sign_in/signInValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class AppLifeCycleWidget extends StatefulWidget {
  final Widget child;
  AppLifeCycleWidget({Key key, @required this.child}) : super(key: key);

  @override
  _AppLifeCycleWidgetState createState() => _AppLifeCycleWidgetState();
}

class _AppLifeCycleWidgetState extends State<AppLifeCycleWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print('AppLifecycleState => paused');
        break;
      case AppLifecycleState.inactive:
        print('AppLifecycleState => inactive');
        break;
      case AppLifecycleState.resumed:
        print('AppLifecycleState => resumed');
        break;
      case AppLifecycleState.detached:
        print('AppLifecycleState => detached');
        // if (!locator<SignInValidationManager>().checkBoxValue) {
        //   print(
        //       'AppLifecycleState => ${locator<SignInValidationManager>().checkBoxValue}');
        //   locator<PrefsService>().removeUserObj();
        //   locator<PrefsService>().hasLoggedIn = false;
        //   locator<PrefsService>().hasSignedUp = false;
        // }
        break;
    }
  }

  @override
  void dispose() {
    // if (locator<SignInValidationManager>().checkBoxValue == false) {
    //   locator<PrefsService>().removeUserObj();
    //   locator<PrefsService>().hasLoggedIn = false;
    //   locator<PrefsService>().hasSignedUp = false;
    // }

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:momentoo/features/checkout/paymentGateway/paymentResponse.dart';
import 'package:momentoo/features/payment/failed_screen.dart';
import 'package:momentoo/features/payment/successful_screen.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';

class PaymentGatewayScreen extends StatelessWidget {
  final String url;
  PaymentGatewayScreen({@required this.url});

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      print('xXx: $url');
      if (url.contains("payment_success")) {
        print('xXx: payment_success');
        PaymentResponse.paymentResponse(url).then((value) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Successful(value.message)));
        });
        flutterWebViewPlugin.close();
      }
      if (url.contains("payment_fail")) {
        print('xXx: payment_fail');
        PaymentResponse.paymentResponse(url).then((value) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => Failed(value.message)));
        });
        flutterWebViewPlugin.close();
      }
    });

    return NetworkSensitive(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('Payment_Gateway_str'),
//            style: TextStyle(
//                fontSize: MainFont, fontWeight: semiFont, color: Colors.white),
            ),
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
          body: WebviewScaffold(
            ignoreSSLErrors: true,
            url: url,
            withJavascript: true,
          )),
    );
  }
}

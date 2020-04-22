import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:momentoo/features/checkout/checkout_manager.dart';
import 'package:momentoo/features/checkout/checkout_response.dart';
import 'package:momentoo/features/payment/successful_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';

class WebViewKnet extends StatelessWidget {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
//     flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (url.contains("payment_success") || url.contains("payment_fail")) {
// //        flutterWebviewPlugin.close();
//         // locator<KnetBloc>().inUrl.add(url);
//         flutterWebviewPlugin.close();
// //        var response = Dio().get(url).then((value) {
// //          return CheckoutModel.fromJson(value.data);
// //
// //
// //        });
//         // flutterWebviewPlugin.close();
//         // Navigator.pop(context);
//         // Navigator.pop(context);

//         Navigator.push(
//             context,
//             new MaterialPageRoute(
//                 builder: (BuildContext context) => Successful())); //Failed
//       }
//     });

    return NetworkSensitive(
      child: Scaffold(
        body: CustomObserver(
            stream:
                locator<CheckoutManager>().checkoutAsUserFuture().asStream(),
            onSuccess: (context, CheckoutResponse response) {
              String msg = response.message;
              int status = response.status;
              String webView = response.data.paymentLink;
              return WebviewScaffold(
                ignoreSSLErrors: true,
                url: webView,
                withJavascript: true,
              );
            }),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomObserver<T> extends StatelessWidget {
  final Stream<T> stream;
  final Function onSuccess;
  final Function onWaiting;
  final Function onError;

  const CustomObserver({
    @required this.stream,
    @required this.onSuccess,
    this.onWaiting,
    this.onError,
  });

  Function get _defaultOnWaiting => (context) => Center(
        child: CircularProgressIndicator(),
        //   child: CupertinoActivityIndicator(
        // radius: 20,
        // )
      );

  Function get _defaultOnError => (context, error) => Container();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return onError != null
              ? onError(context, snapshot.error)
              : _defaultOnError(context, snapshot.error);
        }

        if (snapshot.hasData) {
          T data = snapshot.data;
          return onSuccess(context, data);
        } else {
          return onWaiting != null
              ? onWaiting(context)
              : _defaultOnWaiting(context);
        }
      },
    );
  }
}

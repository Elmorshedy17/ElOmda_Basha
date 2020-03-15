import 'package:flutter/material.dart';

class WaveBackground extends StatelessWidget {
  final Widget child;
  final double height;

  const WaveBackground({@required this.child, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            color: Colors.transparent,
            child: Image.asset(
              'assets/images/wave_header.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

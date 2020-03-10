import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/main_background.dart';

// Track Order
class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

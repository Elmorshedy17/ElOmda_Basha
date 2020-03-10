import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/shared/widgets/custom_card.dart';

class CardsHorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        reverse: locator<PrefsService>().appLanguage == 'ar' ? true : false,
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            child: cards[index],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareService {
  static shareService(BuildContext context, String title, String subject) {
    final RenderBox box = context.findRenderObject();

    Share.share(
      title,
      subject: subject,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}

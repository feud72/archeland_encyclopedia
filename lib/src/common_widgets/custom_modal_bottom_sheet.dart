import 'package:flutter/material.dart';

Future showCustomModalBottomSheet({
  required BuildContext context,
  required Widget widget,
}) async {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: (context),
      builder: (BuildContext context) {
        return widget;
      });
}

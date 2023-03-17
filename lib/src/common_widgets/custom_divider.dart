import 'package:flutter/material.dart';

class CustomTransparentDivider extends StatelessWidget {
  const CustomTransparentDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(color: Colors.transparent);
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.grey.withOpacity(0.5));
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(color: Colors.grey.withOpacity(0.3));
  }
}

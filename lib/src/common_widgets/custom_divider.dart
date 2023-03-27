import 'package:flutter/material.dart';

class CustomTransparentDivider extends StatelessWidget {
  const CustomTransparentDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(color: Colors.transparent);
  }
}

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.grey.withOpacity(0.5));
  }
}

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(color: Colors.grey.withOpacity(0.3));
  }
}

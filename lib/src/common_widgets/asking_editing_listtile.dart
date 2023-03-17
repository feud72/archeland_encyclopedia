import 'package:flutter/material.dart';

class AskingEditingListTile extends StatelessWidget {
  const AskingEditingListTile(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.edit_note),
    );
  }
}

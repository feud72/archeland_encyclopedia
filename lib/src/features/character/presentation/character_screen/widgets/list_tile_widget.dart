import 'package:flutter/material.dart';

class CharacterListTileWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;

  const CharacterListTileWidget(
      {Key? key, required this.title, this.subtitle, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: content,
      ),
    );
  }
}

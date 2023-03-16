import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:flutter/material.dart';

class CharacterSkillListWidget extends StatelessWidget {
  const CharacterSkillListWidget({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(),
    );
  }
}

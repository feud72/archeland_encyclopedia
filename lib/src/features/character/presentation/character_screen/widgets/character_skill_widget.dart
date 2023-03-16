import 'package:archeland_encyclopedia/src/features/characters/domain/skill.dart';
import 'package:flutter/material.dart';

class CharacterSkillWidget extends StatelessWidget {
  const CharacterSkillWidget({Key? key, this.skill}) : super(key: key);

  final Skill? skill;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: skill != null
          ? Column(
              children: [Text(skill?.name ?? "")],
            )
          : const Text("스킬 정보가 없습니다."),
    );
  }
}

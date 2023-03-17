import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_skill_widget.dart';
import 'package:flutter/material.dart';

enum SkillPosition {
  base,
  ultimate,
  middleFirst,
  middleSecond,
  upperFirst,
  upperSecond,
  lowerFirst,
  lowerSecond,
}

class CharacterSkillListWidget extends StatelessWidget {
  const CharacterSkillListWidget({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CharacterSkillWidget(
            title: "기본 기술",
            skill: character.baseSkill,
            position: SkillPosition.base.name,
          ),
          CharacterSkillWidget(
            title: "궁극기",
            level: 55,
            skill: character.ultimate,
            position: SkillPosition.ultimate.name,
          ),
          CharacterSkillWidget(
            title: "특성(중) 제 1스킬",
            level: 3,
            skill: character.middleFirst,
            position: SkillPosition.middleFirst.name,
          ),
          CharacterSkillWidget(
            title: "특성(중) 제 2스킬",
            level: 25,
            skill: character.middleSecond,
            position: SkillPosition.middleSecond.name,
          ),
          character.rank == 'R' && character.job == Job.tanker
              ? const SizedBox.shrink()
              : CharacterSkillWidget(
                  title: "특성(상) 제 1스킬",
                  level: 15,
                  skill: character.upperFirst,
                  position: SkillPosition.upperFirst.name,
                ),
          character.rank == 'R' && character.job != Job.tanker
              ? const SizedBox.shrink()
              : CharacterSkillWidget(
                  title: "특성(상) 제 2스킬",
                  level: 45,
                  skill: character.upperSecond,
                  position: SkillPosition.upperSecond.name,
                ),
          character.rank == 'R' && character.job != Job.tanker
              ? const SizedBox.shrink()
              : CharacterSkillWidget(
                  title: "특성(하) 제 1스킬",
                  level: 15,
                  skill: character.lowerFirst,
                  position: SkillPosition.lowerFirst.name,
                ),
          character.rank == 'R' && character.job == Job.tanker
              ? const SizedBox.shrink()
              : CharacterSkillWidget(
                  title: "특성(하) 제 2스킬",
                  level: 45,
                  skill: character.lowerSecond,
                  position: SkillPosition.lowerSecond.name,
                ),
        ],
      ),
    );
  }
}

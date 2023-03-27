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

class CharacterSkillPage extends StatelessWidget {
  const CharacterSkillPage({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    final positionList = [
      SkillPosition.base.name,
      SkillPosition.ultimate.name,
      SkillPosition.middleFirst.name,
      SkillPosition.middleSecond.name,
      SkillPosition.upperFirst.name,
      SkillPosition.upperSecond.name,
      SkillPosition.lowerFirst.name,
      SkillPosition.lowerSecond.name,
    ];
    final positionTitle = [
      '기본 기술',
      '궁극기',
      "특성(중) 제 1스킬",
      "특성(중) 제 2스킬",
      "특성(상) 제 1스킬",
      "특성(상) 제 2스킬",
      "특성(하) 제 1스킬",
      "특성(하) 제 2스킬",
    ];
    final level = [null, 55, 3, 25, 15, 45, 15, 45];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          ...character.rank != Rank.r
              ? List.generate(
                  8,
                  (index) => CharacterSkillWidget(
                    title: positionTitle[index],
                    character: character,
                    skill: character.skill?.firstWhere(
                        (skill) => skill?.position == positionList[index],
                        orElse: () => null),
                    position: positionList[index],
                    level: level[index],
                  ),
                )
              : List.generate(6, (index) {
                  final tempLevel = [...level];
                  final tempPositionList = [...positionList];
                  final tempPositionTitle = [...positionTitle];
                  if (character.job == Job.tanker ||
                      character.job == Job.warrior) {
                    tempLevel.removeAt(4);
                    tempLevel.removeAt(6);
                    tempPositionList.removeAt(4);
                    tempPositionList.removeAt(6);
                    tempPositionTitle.removeAt(4);
                    tempPositionTitle.removeAt(6);
                  } else {
                    tempLevel.removeAt(5);
                    tempLevel.removeAt(5);
                    tempPositionList.removeAt(5);
                    tempPositionList.removeAt(5);
                    tempPositionTitle.removeAt(5);
                    tempPositionTitle.removeAt(5);
                  }
                  return CharacterSkillWidget(
                    title: tempPositionTitle[index],
                    character: character,
                    skill: character.skill?.firstWhere(
                        (skill) => skill?.position == tempPositionList[index],
                        orElse: () => null),
                    position: tempPositionList[index],
                    level: tempLevel[index],
                  );
                }),
        ],
      ),
    );
  }
}

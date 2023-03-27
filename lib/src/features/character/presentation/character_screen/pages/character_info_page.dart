import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_basic_info_widget.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_special_skill_widget.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_weapon_widget.dart';
import 'package:flutter/material.dart';

class CharacterInfoPage extends StatelessWidget {
  final Character character;
  const CharacterInfoPage({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CharacterBasicInfoWidget(character: character),
          CharacterSpecialSkillWidget(
            title: '특성',
            skill: character.uniqueSkill,
          ),
          character.isLeader != null && character.isLeader!
              ? CharacterSpecialSkillWidget(
                  title: '리더 스킬',
                  skill: character.leaderSkill,
                )
              : const SizedBox.shrink(),
          character.rank == 'SSR'
              ? CharacterWeaponWidget(character: character)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

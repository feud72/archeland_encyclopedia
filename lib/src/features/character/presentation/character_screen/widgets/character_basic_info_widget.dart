import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/special_skill.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_weapon_widget.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';

class CharacterBasicInfoWidget extends StatelessWidget {
  final Character character;
  const CharacterBasicInfoWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CharacterListTileWidget(
              title: "속성",
              subtitle: "Element",
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: character.element != null
                        ? ColoredBox(
                            color: elementColor[character.element]!
                                .withOpacity(0.5),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(character.element ?? "(알 수 없음)"),
                ],
              )),
          CharacterListTileWidget(
              title: "직업",
              subtitle: "Class",
              content: Text(character.job ?? "(알 수 없음)")),
          CharacterListTileWidget(
              title: "등급",
              subtitle: "Rank",
              content: Text(character.rank ?? "(알 수 없음)")),
          CharacterListTileWidget(
              title: "무기 타입",
              subtitle: "Weapon Type",
              content: Text(character.weaponType ?? "(알 수 없음)")),
          SpecialSkillWidget(
            title: '특성',
            skill: character.uniqueSkill,
          ),
          SpecialSkillWidget(
            title: '리더 스킬',
            skill: character.leaderSkill,
          ),
          CharacterWeaponWidget(title: '전용 무기', weapon: character.weapon),
        ],
      ),
    );
  }
}

class SpecialSkillWidget extends StatelessWidget {
  const SpecialSkillWidget({
    Key? key,
    required this.skill,
    required this.title,
  }) : super(key: key);
  final String title;
  final SpecialSkill? skill;

  @override
  Widget build(BuildContext context) {
    return skill != null
        ? Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      skill!.name ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(title),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  skill!.description ?? "(알 수 없음)",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

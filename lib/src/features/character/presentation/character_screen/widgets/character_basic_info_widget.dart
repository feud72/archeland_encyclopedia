import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/widgets/list_tile_widget.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/widgets/unique_skill_widget.dart';
import 'package:flutter/material.dart';

class CharacterBasicInfoWidget extends StatelessWidget {
  final Character character;
  const CharacterBasicInfoWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          color:
                              elementColor[character.element]!.withOpacity(0.5),
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
        UniqueSkillWidget(character: character),
      ],
    );
  }
}

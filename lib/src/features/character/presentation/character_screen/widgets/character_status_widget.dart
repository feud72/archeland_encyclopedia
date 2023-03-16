import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/widgets/character_status_hexagon_widget.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';

class CharacterStatusWidget extends StatelessWidget {
  const CharacterStatusWidget({Key? key, required this.character})
      : super(key: key);

  final Character character;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CharacterStatusHexagonWidget(
            character: character, screenWidth: screenWidth),
        Column(
          children: [
            CharacterListTileWidget(
                title: "HP",
                subtitle: "HP",
                content: Text(character.hp ?? "(알 수 없음)")),
            CharacterListTileWidget(
                title: "물리 공격력",
                subtitle: "Physical Attack",
                content: Text(character.pAtk ?? "(알 수 없음)")),
            CharacterListTileWidget(
                title: "마법 방어력",
                subtitle: "Magical Defense",
                content: Text(character.mAtk ?? "(알 수 없음)")),
            CharacterListTileWidget(
                title: "물리 방어력",
                subtitle: "Physical Defense",
                content: Text(character.pDef ?? "(알 수 없음)")),
            CharacterListTileWidget(
                title: "마법 방어력",
                subtitle: "Magical Defense",
                content: Text(character.mDef ?? "(알 수 없음)")),
            CharacterListTileWidget(
                title: "집중력",
                subtitle: "Concentration",
                content: Text(character.concentration ?? "(알 수 없음)")),
          ],
        ),
      ],
    );
  }
}

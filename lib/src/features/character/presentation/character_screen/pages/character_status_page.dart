import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_status_hexagon_widget.dart';
import 'package:flutter/material.dart';

class CharacterStatusPage extends StatelessWidget {
  const CharacterStatusPage({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CharacterStatusHexagonWidget(
              character: character, screenWidth: screenWidth),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: StatusTileWidget(
                            title: "물리 공격력",
                            content: character.pAtk ?? "(알 수 없음)")),
                    const SizedBox(width: 16),
                    Expanded(
                        child: StatusTileWidget(
                            title: "물리 방어력",
                            content: character.pDef ?? "(알 수 없음)")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: StatusTileWidget(
                            title: "마법 공격력",
                            content: character.mAtk ?? "(알 수 없음)")),
                    const SizedBox(width: 16),
                    Expanded(
                        child: StatusTileWidget(
                            title: "마법 방어력",
                            content: character.mDef ?? "(알 수 없음)")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: StatusTileWidget(
                            title: "집중력",
                            content: character.concentration ?? "(알 수 없음)")),
                    const SizedBox(width: 16),
                    Expanded(
                        child: StatusTileWidget(
                            title: "HP", content: character.hp ?? "(알 수 없음)")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StatusTileWidget extends StatelessWidget {
  const StatusTileWidget({Key? key, required this.title, required this.content})
      : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

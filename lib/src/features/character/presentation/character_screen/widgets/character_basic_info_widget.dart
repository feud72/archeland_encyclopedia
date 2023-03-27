import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';

class CharacterBasicInfoWidget extends StatelessWidget {
  const CharacterBasicInfoWidget({Key? key, required this.character})
      : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child: Text("기본 정보", style: Theme.of(context).textTheme.titleLarge),
        ),
        Row(
          children: [
            Expanded(
              child: CharacterListTileWidget(
                  title: "속성",
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
                      Text(
                        character.element ?? "(알 수 없음)",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: CharacterListTileWidget(
                  title: "직업",
                  content: Text(
                    character.job ?? "(알 수 없음)",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CharacterListTileWidget(
                  title: "등급",
                  content: Text(
                    character.rank ?? "(알 수 없음)",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ),
            Expanded(
              child: CharacterListTileWidget(
                  title: "무기 타입",
                  content: Text(
                    character.weaponType ?? "(알 수 없음)",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
